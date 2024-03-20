import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:footrack_front/enums/player_status_enum.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/utils/pickers.dart';

class AlertPlayer extends ConsumerStatefulWidget {
  const AlertPlayer({
    Key? key,
    this.player,
  }) : super(key: key);

  final Player? player;

  @override
  ConsumerState<AlertPlayer> createState() => _AlertPlayerState();
}

class _AlertPlayerState extends ConsumerState<AlertPlayer> {
  final TextEditingController _playerNameController = TextEditingController();
  final TextEditingController _playerBirthdateController = TextEditingController();

  PlayerRoleEnum? _playerRole = PlayerRoleEnum.none;
  PlayerStatusEnum? _playerStatus = PlayerStatusEnum.none;
  DateTime? _birthdatePicked;

  @override
  void initState() {
    super.initState();
    _playerRole = widget.player?.getRole();
    _playerStatus = widget.player?.getStatus();
    _birthdatePicked = widget.player?.birthdate.toDateTime();

    _playerNameController.text = widget.player?.getName() ?? "";
    _playerBirthdateController.text = _birthdatePicked.format();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.player != null ? "Modifier le joueur" : "Ajouter un joueur"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.abc),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _playerNameController,
                  decoration: const InputDecoration(
                    hintText: "Nom du joueur",
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _playerBirthdateController,
                  decoration: const InputDecoration(
                    hintText: "Date de naissance",
                  ),
                  readOnly: true,
                  onTap: () {
                    ref.read(datePicker(context).future).then((d) {
                      if (d != null) {
                        _birthdatePicked = d;
                        _playerBirthdateController.text = d.format();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.label_important, color: Colors.amber),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  value: _playerRole,
                  items: List<PlayerRoleEnum>.from(PlayerRoleEnum.values)
                      .map<DropdownMenuItem<PlayerRoleEnum>>((PlayerRoleEnum value) {
                    return DropdownMenuItem<PlayerRoleEnum>(
                      value: value,
                      child: Text(value.format()),
                    );
                  }).toList(),
                  onChanged: (PlayerRoleEnum? value) {
                    setState(() {
                      _playerRole = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.add_circle, color: Colors.lightGreen),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  value: _playerStatus,
                  items: List<PlayerStatusEnum>.from(PlayerStatusEnum.values)
                      .map<DropdownMenuItem<PlayerStatusEnum>>((PlayerStatusEnum value) {
                    return DropdownMenuItem<PlayerStatusEnum>(
                      value: value,
                      child: Text(value.format()),
                    );
                  }).toList(),
                  onChanged: (PlayerStatusEnum? value) {
                    setState(() {
                      _playerStatus = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (widget.player != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Êtes-vous sûr de vouloir supprimer le joueur ?"),
                    content: Text(widget.player!.getName()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(dbProvider).removePlayer(
                                ref.read(seasonChoseProvider)?.id,
                                widget.player!.id,
                              );

                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return Colors.red;
                            },
                          ),
                        ),
                        child: const Text("Supprimer"),
                      ),
                    ],
                  );
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return Colors.red;
                },
              ),
            ),
            child: const Text("Supprimer"),
          ),
        ElevatedButton(
          onPressed: () {
            var player = Player()
              ..name = _playerNameController.value.text
              ..birthdate = _birthdatePicked.toTimestamp()
              ..role = _playerRole?.name
              ..status = _playerStatus?.name;

            if (widget.player != null) {
              ref.read(dbProvider).editPlayer(
                    ref.read(seasonChoseProvider)?.id,
                    widget.player!.id,
                    player,
                  );
            } else {
              ref.read(dbProvider).addNewPlayer(
                    ref.read(seasonChoseProvider)?.id,
                    player,
                  );
            }

            Navigator.pop(context);
          },
          child: Text(widget.player != null ? "Modifier" : "Ajouter"),
        ),
      ],
    );
  }
}
