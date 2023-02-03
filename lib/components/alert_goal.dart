import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertGoal extends StatefulWidget {
  AlertGoal({
    Key? key,
    required this.ref,
    this.goal,
  }) : super(key: key);

  final WidgetRef ref;
  final Goal? goal;

  @override
  State<AlertGoal> createState() => _AlertGoalState();
}

class _AlertGoalState extends State<AlertGoal> {
  final TextEditingController _goalTimeController = TextEditingController();

  String? _scorerRefPath;
  String? _passerRefPath;
  int? _timeGoalScored;

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _scorerRefPath = widget.goal!.scorerRef?.path;
      _passerRefPath = widget.goal!.passerRef?.path;
      _timeGoalScored = widget.goal!.time;

      _goalTimeController.text = _timeGoalScored?.toString() ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                child: FirestoreBuilder(
                    ref: seasonsRef.doc(widget.ref.read(seasonChoseProvider)?.id).players,
                    builder: (context, AsyncSnapshot<PlayerQuerySnapshot> snapshot, child) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      List<Pair<String, String>> scorersList =
                          List<PlayerQueryDocumentSnapshot>.from(snapshot.requireData.docs).map((e) => Pair(e.reference.path, e.data.name)).toList()
                            ..add(Pair(null, "- Contre son camp"))
                            ..sort(comparePairSecond);

                      if (widget.goal == null) {
                        _scorerRefPath ??= scorersList.first.first;
                      }

                      return DropdownButton(
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
                      );
                    }),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.person),
              const SizedBox(width: 8),
              Expanded(
                child: FirestoreBuilder(
                    ref: seasonsRef.doc(widget.ref.read(seasonChoseProvider)?.id).players,
                    builder: (context, AsyncSnapshot<PlayerQuerySnapshot> snapshot, child) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      List<Pair<String, String>> passersList =
                          List<PlayerQueryDocumentSnapshot>.from(snapshot.requireData.docs).map((e) => Pair(e.reference.path, e.data.name)).toList()
                            ..add(Pair(null, "- Pas de passeur"))
                            ..sort(comparePairSecond);

                      if (widget.goal == null) {
                        _passerRefPath ??= passersList.first.first;
                      }

                      return DropdownButton(
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
                      );
                    }),
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
                          widget.ref
                              .watch(seasonsProvider)
                              .removeGoal(widget.ref.read(seasonChoseProvider)?.id, widget.ref.read(matchChoseProvider)?.id, widget.goal!.id);

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
            Goal goal = Goal(
              scorerRef: _scorerRefPath != null ? FirebaseFirestore.instance.doc(_scorerRefPath!) : null,
              passerRef: _passerRefPath != null ? FirebaseFirestore.instance.doc(_passerRefPath!) : null,
              time: _timeGoalScored,
            );

            if (widget.goal != null) {
              widget.ref.read(seasonsProvider).editGoal(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.ref.read(matchChoseProvider)?.id,
                    widget.goal!.id,
                    goal,
                  );
            } else {
              widget.ref.read(seasonsProvider).addNewGoal(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.ref.read(matchChoseProvider)?.id,
                    goal,
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
