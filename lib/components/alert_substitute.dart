import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/extensions/match_extension.dart';
import 'package:footrack_front/models/extensions/player_extension.dart';
import 'package:footrack_front/models/extensions/squad_player_extension.dart';
import 'package:footrack_front/models/substitute.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertSubstitute extends ConsumerStatefulWidget {
  const AlertSubstitute({
    Key? key,
    this.substitute,
  }) : super(key: key);

  final Substitute? substitute;

  @override
  ConsumerState<AlertSubstitute> createState() => _AlertSubstituteState();
}

class _AlertSubstituteState extends ConsumerState<AlertSubstitute> {
  final TextEditingController _substituteTimeController = TextEditingController();

  String? _playerInRefPath;
  String? _playerOutRefPath;
  int? _timeSubstitution;

  @override
  void initState() {
    super.initState();

    _playerInRefPath = widget.substitute?.playerIn?.path;
    _playerOutRefPath = widget.substitute?.playerOut?.path;
    _timeSubstitution = widget.substitute?.getTime();

    _substituteTimeController.text = _timeSubstitution?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var match = ref.watch(matchChoseProvider);
    var squad = match.getSquad(ref);
    var players = squad
        .map(
          (e) => e.getPlayer(ref),
        )
        .where(
          (e) => e.getRole() == PlayerRoleEnum.player,
        );

    List<Pair<String, String>> playersInList = players.map((e) => Pair(e?.reference.path, e.getName())).toList()
      ..sort(comparePairSecondAsc);

    List<Pair<String, String>> playersOutList = players.map((e) => Pair(e?.reference.path, e.getName())).toList()
      ..sort(comparePairSecondAsc);

    if (widget.substitute == null) {
      _playerInRefPath ??= playersInList.firstOrNull?.first;
      _playerOutRefPath ??= playersOutList.firstOrNull?.first;
    }

    return players.isEmpty
        ? const AlertDialog(
            title: Text("Attention"),
            content: Text("Veuillez remplir votre effectif avant de faire un changement"),
          )
        : AlertDialog(
            title: Text(widget.substitute != null ? "Modifier le remplacement" : "Ajouter un remplacement"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_alarm),
                    const SizedBox(width: Spacing.xs),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _substituteTimeController,
                        decoration: const InputDecoration(
                          hintText: "Temps",
                        ),
                        onChanged: (value) {
                          _timeSubstitution = int.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.arrow_forward, color: Colors.green),
                    const SizedBox(width: Spacing.xs),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        value: _playerInRefPath,
                        items: playersInList.map<DropdownMenuItem<String>>((Pair<String, String> value) {
                          return DropdownMenuItem<String>(
                            value: value.first,
                            child: Text(value.second ?? ""),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _playerInRefPath = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.red),
                    const SizedBox(width: Spacing.xs),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        value: _playerOutRefPath,
                        items: playersOutList.map<DropdownMenuItem<String>>((Pair<String, String> value) {
                          return DropdownMenuItem<String>(
                            value: value.first,
                            child: Text(value.second ?? ""),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _playerOutRefPath = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              if (widget.substitute != null)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            return AlertDialog(
                              title: const Text("Êtes-vous sûr de vouloir supprimer ce remplacement ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Annuler")),
                                ElevatedButton(
                                  onPressed: () {
                                    ref.read(dbProvider).removeSubstitute(
                                          ref.watch(seasonChoseProvider)?.id,
                                          ref.watch(matchChoseProvider)?.id,
                                          widget.substitute!.id,
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
                  var substitute = Substitute()
                    ..playerIn = _playerInRefPath?.let((it) => FirebaseFirestore.instance.doc(it))
                    ..playerOut = _playerOutRefPath?.let((it) => FirebaseFirestore.instance.doc(it))
                    ..time = _timeSubstitution;

                  if (widget.substitute != null) {
                    ref.read(dbProvider).editSubstitute(
                          ref.watch(seasonChoseProvider)?.id,
                          ref.watch(matchChoseProvider)?.id,
                          widget.substitute!.id,
                          substitute,
                        );
                  } else {
                    ref.read(dbProvider).addNewSubstitute(
                          ref.watch(seasonChoseProvider)?.id,
                          ref.watch(matchChoseProvider)?.id,
                          substitute,
                        );
                  }

                  Navigator.pop(context);
                },
                child: Text(widget.substitute != null ? "Modifier" : "Ajouter"),
              ),
            ],
          );
  }
}
