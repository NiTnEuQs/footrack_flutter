import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertGoal extends ConsumerStatefulWidget {
  const AlertGoal({
    Key? key,
    this.goal,
    this.onAddPressed,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  final Goal? goal;
  final Function(Goal)? onAddPressed;
  final Function(Goal)? onEditPressed;
  final Function()? onDeletePressed;

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
    var players = ref.watch(selectedSeasonProvider).players;

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
                child: FutureBuilder(
                    future: firestoreInstance.collection(players.path).get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      List<Pair<String, String>>? scorersList = snapshot.data?.docs
                          .map((e) => Player(snapshot: e))
                          .map((e) => Pair(e.reference.path, e.name))
                          .toList()
                        ?..add(Pair(null, "- Contre son camp"))
                        ..sort(comparePairSecond);

                      if (widget.goal == null) {
                        _scorerRefPath ??= scorersList?.first.first;
                      }

                      return DropdownButton(
                        isExpanded: true,
                        value: _scorerRefPath,
                        items: scorersList?.map<DropdownMenuItem<String>>((Pair<String, String> value) {
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
                child: FutureBuilder(
                    future: firestoreInstance.collection(players.path).get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      List<Pair<String, String>>? passersList = snapshot.data?.docs
                          .map((e) => Player(snapshot: e))
                          .map((e) => Pair(e.reference.path, e.name))
                          .toList()
                        ?..add(Pair(null, "- Pas de passeur"))
                        ..sort(comparePairSecond);

                      if (widget.goal == null) {
                        _passerRefPath ??= passersList?.first.first;
                      }

                      return DropdownButton(
                        isExpanded: true,
                        value: _passerRefPath,
                        items: passersList?.map<DropdownMenuItem<String>>((Pair<String, String> value) {
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
                        child: const Text("Annuler"),
                      ),
                      ElevatedButton(
                        onPressed: widget.onDeletePressed,
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
            Goal goal = Goal()
              ..scorer = _scorerRefPath != null ? FirebaseFirestore.instance.doc(_scorerRefPath!) : null
              ..passer = _passerRefPath != null ? FirebaseFirestore.instance.doc(_passerRefPath!) : null
              ..time = _timeGoalScored;

            if (widget.goal != null) {
              widget.onEditPressed?.call(goal);
            } else {
              widget.onAddPressed?.call(goal);
            }
          },
          child: Text(widget.goal != null ? "Modifier" : "Ajouter"),
        ),
      ],
    );
  }
}
