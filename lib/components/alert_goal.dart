import "package:flamingo/flamingo.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/squad_player_extension.dart";
import "package:footrack_front/models/goal.dart";
import "package:footrack_front/utils/comparables.dart";
import "package:footrack_front/utils/tuples.dart";

class AlertGoal extends ConsumerStatefulWidget {
  const AlertGoal({
    super.key,
    this.goal,
  });

  final Goal? goal;

  @override
  ConsumerState<AlertGoal> createState() => _AlertGoalState();
}

class _AlertGoalState extends ConsumerState<AlertGoal> {
  final TextEditingController _timeGoalController = TextEditingController();

  int? _timeGoalScored;
  String? _scorerRefPath;
  String? _passerRefPath;

  @override
  void initState() {
    super.initState();

    _timeGoalScored = widget.goal?.getTime();
    _scorerRefPath = widget.goal?.scorer?.path;
    _passerRefPath = widget.goal?.passer?.path;

    _timeGoalController.text = _timeGoalScored?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var match = ref.watch(matchChoseProvider);
    var squad = match.getSquad(ref);
    var players = squad.map((e) => e.getPlayer(ref)).where((e) => e.getRole() == PlayerRoleEnum.player);
    var scorersList = players.map((e) => Pair(e?.reference.path, e.getName())).toList()
      ..add(Pair(null, "- Contre son camp"))
      ..sort(comparePairSecondAsc);
    var passersList = players.map((e) => Pair(e?.reference.path, e.getName())).toList()
      ..add(Pair(null, "- Pas de passeur"))
      ..sort(comparePairSecondAsc);

    if (widget.goal == null) {
      _scorerRefPath ??= scorersList.firstOrNull?.first;
      _passerRefPath ??= passersList.firstOrNull?.first;
    }

    return AlertDialog(
      title: Text(widget.goal != null ? "Modifier le but" : "Ajouter un but"),
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
                  controller: _timeGoalController,
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
              const SizedBox(width: Spacing.xs),
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
              const SizedBox(width: Spacing.xs),
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
                  return Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
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
                            onPressed: () {
                              ref.read(dbProvider).removeGoal(
                                    ref.watch(clubChoseProvider)?.id,
                                    ref.watch(seasonChoseProvider)?.id,
                                    ref.watch(matchChoseProvider)?.id,
                                    widget.goal!.id,
                                  );

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.redAccent,
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
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.redAccent,
            ),
            child: const Text("Supprimer"),
          ),
        ElevatedButton(
          onPressed: () {
            Goal goal = Goal()
              ..time = _timeGoalScored
              ..scorer = _scorerRefPath?.let((it) => FirebaseFirestore.instance.doc(it))
              ..passer = _passerRefPath?.let((it) => FirebaseFirestore.instance.doc(it));

            if (widget.goal != null) {
              ref.read(dbProvider).editGoal(
                    ref.watch(clubChoseProvider)?.id,
                    ref.watch(seasonChoseProvider)?.id,
                    ref.watch(matchChoseProvider)?.id,
                    widget.goal!.id,
                    goal,
                  );
            } else {
              ref.read(dbProvider).addNewGoal(
                    ref.watch(clubChoseProvider)?.id,
                    ref.watch(seasonChoseProvider)?.id,
                    ref.watch(matchChoseProvider)?.id,
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
