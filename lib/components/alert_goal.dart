import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/squad_player.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertGoal extends ConsumerStatefulWidget {
  const AlertGoal({
    Key? key,
    this.goal,
  }) : super(key: key);

  final Goal? goal;

  @override
  ConsumerState<AlertGoal> createState() => _AlertGoalState();
}

class _AlertGoalState extends ConsumerState<AlertGoal> {
  final TextEditingController _goalTimeController = TextEditingController();

  String? _scorerRefPath;
  String? _passerRefPath;
  int? _timeGoalScored;

  @override
  void initState() {
    super.initState();

    _scorerRefPath = widget.goal?.scorer?.path;
    _passerRefPath = widget.goal?.passer?.path;
    _timeGoalScored = widget.goal?.time;

    _goalTimeController.text = _timeGoalScored?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var match = ref.watch(matchChoseProvider);
    var squad = match != null ? ref.watch(match.squadProvider) : <SquadPlayer>[];
    var players = squad
        .map(
          (e) => ref.watch(e.playerProvider),
        )
        .where(
          (e) => e?.getRole() == PlayerRoleEnum.player,
        );

    List<Pair<String, String>> scorersList = players.map((e) => Pair(e?.reference.path, e?.name)).toList()
      ..add(Pair(null, "- Contre son camp"))
      ..sort(comparePairSecond);

    List<Pair<String, String>> passersList = players.map((e) => Pair(e?.reference.path, e?.name)).toList()
      ..add(Pair(null, "- Pas de passeur"))
      ..sort(comparePairSecond);

    if (widget.goal == null) {
      _scorerRefPath ??= scorersList.first.first;
      _passerRefPath ??= passersList.first.first;
    }

    return players.isEmpty
        ? const AlertDialog(
            title: Text("Attention"),
            content: Text("Veuillez remplir votre effectif avant d'ajouter un but"),
          )
        : AlertDialog(
            title: Text(widget.goal != null ? "Modifier le but" : "Ajouter un but"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_alarm),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _goalTimeController,
                        decoration: const InputDecoration(
                          hintText: "Temps",
                        ),
                        onChanged: (value) {
                          _timeGoalScored = value.isNotEmpty ? int.parse(value) : null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.sports_soccer),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        value: _scorerRefPath,
                        items: scorersList.map<DropdownMenuItem<String>>((Pair<String, String> value) {
                          return DropdownMenuItem<String>(
                            value: value.first,
                            child: Text(value.second ?? ""),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _scorerRefPath = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        value: _passerRefPath,
                        items: passersList.map<DropdownMenuItem<String>>((Pair<String, String> value) {
                          return DropdownMenuItem<String>(
                            value: value.first,
                            child: Text(value.second ?? ""),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _passerRefPath = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              if (widget.goal != null)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Êtes-vous sûr de vouloir supprimer ce but ?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Annuler")),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(dbProvider).removeGoal(
                                      ref.read(seasonChoseProvider)?.id,
                                      ref.read(matchChoseProvider)?.id,
                                      widget.goal!.id,
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
                  Goal newGoal = Goal()
                    ..scorer = _scorerRefPath?.let((it) => FirebaseFirestore.instance.doc(it))
                    ..passer = _passerRefPath?.let((it) => FirebaseFirestore.instance.doc(it))
                    ..time = _timeGoalScored;

                  if (widget.goal != null) {
                    ref.read(dbProvider).editGoal(
                          ref.read(seasonChoseProvider)?.id,
                          ref.read(matchChoseProvider)?.id,
                          widget.goal!.id,
                          newGoal,
                        );
                  } else {
                    ref.read(dbProvider).addNewGoal(
                          ref.read(seasonChoseProvider)?.id,
                          ref.read(matchChoseProvider)?.id,
                          newGoal,
                        );
                  }

                  Navigator.pop(context);
                },
                child: Text(widget.goal != null ? "Modifier" : "Ajouter"),
              ),
            ],
          );
  }
}
