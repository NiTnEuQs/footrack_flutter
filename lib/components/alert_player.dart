import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:footrack_front/models/season.dart';

class AlertPlayer extends StatefulWidget {
  AlertPlayer({
    Key? key,
    required this.ref,
    this.player,
  }) : super(key: key);

  final WidgetRef ref;
  final Player? player;

  @override
  State<AlertPlayer> createState() => _AlertPlayerState();
}

class _AlertPlayerState extends State<AlertPlayer> {
  final TextEditingController _playerNameController = TextEditingController();

  PlayerRoleEnum? _playerRole = PlayerRoleEnum.none;

  @override
  void initState() {
    super.initState();
    if (widget.player != null) {
      _playerNameController.text = widget.player!.name;
      _playerRole = widget.player!.role!;
    }
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
              const Icon(Icons.label_important),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  value: _playerRole,
                  items: List<PlayerRoleEnum>.from(PlayerRoleEnum.values).map<DropdownMenuItem<PlayerRoleEnum>>((PlayerRoleEnum value) {
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
                    content: Text(widget.player!.name),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          widget.ref.watch(seasonsProvider).removePlayer(
                                widget.ref.read(seasonChoseProvider)?.id,
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
            if (widget.player != null) {
              widget.ref.read(seasonsProvider).editPlayer(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.player!.id,
                    Player(
                      name: _playerNameController.value.text,
                      role: _playerRole,
                    ),
                  );
            } else {
              widget.ref.read(seasonsProvider).addNewPlayer(
                    widget.ref.read(seasonChoseProvider)?.id,
                    Player(
                      name: _playerNameController.value.text,
                      role: _playerRole,
                    ),
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
