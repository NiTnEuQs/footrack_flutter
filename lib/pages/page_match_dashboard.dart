import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_goal.dart';
import 'package:footrack_front/components/alert_substitute.dart';
import 'package:footrack_front/components/footrack_grid_tile.dart';
import 'package:footrack_front/components/separator.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/season.dart';
import 'package:wakelock/wakelock.dart';

class MatchDashboardPage extends ConsumerStatefulWidget {
  const MatchDashboardPage(this.matchId, {Key? key}) : super(key: key);

  final String matchId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchDashboardPageState();
}

class _MatchDashboardPageState extends ConsumerState<MatchDashboardPage> {
  void _addGoal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertGoal(ref: ref);
      },
    );
  }

  void _updateOpponentGoal(int? newOpponentGoal) {
    ref.watch(seasonsProvider).updateOpponentGoal(ref.read(seasonChoseProvider)?.id, ref.read(matchChoseProvider)?.id, newOpponentGoal);
  }

  void _addSubstitute() {
    showDialog(
      context: context,
      builder: (context) {
        return AddSubstituteAlert(ref: ref);
      },
    );
  }

  void _editGoal(Goal? goal) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertGoal(
          ref: ref,
          goal: goal,
        );
      },
    );
  }

  void _editSubstitute(Substitute? substitute) {
    showDialog(
      context: context,
      builder: (context) {
        return AddSubstituteAlert(
          ref: ref,
          substitute: substitute,
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    Wakelock.disable();
    return true;
  }

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {
    MatchDocumentReference matchRef = seasonsRef.doc(ref.watch(seasonChoseProvider)?.id).matchs.doc(widget.matchId);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: FirestoreBuilder(
          ref: matchRef,
          builder: (context, AsyncSnapshot<MatchDocumentSnapshot> matchDocumentSnapshot, Widget? child) {
            if (matchDocumentSnapshot.hasError) {
              return const Center(child: Text("Erreur"));
            }

            if (!matchDocumentSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            Match? match = matchDocumentSnapshot.requireData.data;

            return StreamBuilder(
              stream: match?.opponentRef?.snapshots(),
              builder: (context, opponentDocumentSnapshot) {
                if (opponentDocumentSnapshot.hasError) {
                  return const Center(child: Text("Erreur"));
                }

                if (!opponentDocumentSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                Opponent opponent = Opponent.fromSnapshot(opponentDocumentSnapshot.requireData as DocumentSnapshot);

                return FirestoreBuilder(
                    ref: matchRef.goals,
                    builder: (context, AsyncSnapshot<GoalQuerySnapshot> goalQuerySnapshot, child) {
                      if (goalQuerySnapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!goalQuerySnapshot.hasData) {
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      int goals = goalQuerySnapshot.requireData.docs.length;
                      match?.scoreTeam = goals;

                      return FirestoreBuilder(
                          ref: matchRef.substitutes,
                          builder: (context, AsyncSnapshot<SubstituteQuerySnapshot> substituteQuerySnapshot, child) {
                            if (substituteQuerySnapshot.hasError) {
                              return const Center(child: Text("Erreur"));
                            }

                            if (!substituteQuerySnapshot.hasData) {
                              return const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            return Scaffold(
                              appBar: AppBar(
                                title: Text(opponent.name),
                              ),
                              body: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                          child: Center(
                                            child: Text(
                                              match?.date.formatWithTime() ?? "Erreur",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                flex: 3,
                                                fit: FlexFit.tight,
                                                child: Center(
                                                  child: Text(
                                                    ref.watch(seasonChoseProvider)?.teamName ?? "Votre équipe",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 2,
                                                child: Center(
                                                  child: Text(
                                                    "${match?.scoreTeam.toString() ?? "?"} - ${match?.scoreOpponent.toString() ?? "?"}",
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                fit: FlexFit.tight,
                                                child: Center(
                                                  child: Text(
                                                    opponent.name,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: PageView(
                                      children: [
                                        GoalsListPage(
                                          goalsSnapshot: goalQuerySnapshot.requireData.docs
                                            ..sort((a, b) {
                                              return b.data.time.compare(a.data.time, nullIsFirst: true);
                                            }),
                                          onGoalLongPress: _editGoal,
                                        ),
                                        SubstitutesListPage(
                                          substitutesSnapshot: substituteQuerySnapshot.requireData.docs
                                            ..sort((a, b) {
                                              return b.data.time.compare(a.data.time, nullIsFirst: true);
                                            }),
                                          onSubstituteLongPress: _editSubstitute,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Separator(),
                                  ),
                                  MatchDashboard(
                                    onGoalClicked: () {
                                      _addGoal();
                                    },
                                    onSubstituteClicked: () {
                                      _addSubstitute();
                                    },
                                    onOpponentGoalClicked: () {
                                      if (match == null || match.scoreOpponent == null) return;

                                      _updateOpponentGoal(match.scoreOpponent! + 1);
                                    },
                                    onOpponentGoalLongPress: () {
                                      if (match == null || match.scoreOpponent == null) return;

                                      _updateOpponentGoal(max(0, match.scoreOpponent! - 1));
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    });
              },
            );
          }),
    );
  }
}

class GoalsListPage extends StatelessWidget {
  const GoalsListPage({
    Key? key,
    required this.goalsSnapshot,
    this.onGoalLongPress,
  }) : super(key: key);

  final List<GoalQueryDocumentSnapshot> goalsSnapshot;
  final Function(Goal? goal)? onGoalLongPress;

  @override
  Widget build(BuildContext context) {
    return goalsSnapshot.isEmpty
        ? const Center(child: Text("Aucun but"))
        : ListView.builder(
            itemCount: goalsSnapshot.length,
            itemBuilder: (context, index) {
              var goalQueryDocumentSnapshot = goalsSnapshot[index];

              return FirestoreBuilder(
                ref: goalQueryDocumentSnapshot.reference,
                builder: (context, AsyncSnapshot<GoalDocumentSnapshot> goalDocumentSnapshot, Widget? child) {
                  if (goalDocumentSnapshot.hasError) {
                    return const Center(child: Text("Erreur"));
                  }

                  if (!goalDocumentSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Goal? goal = goalDocumentSnapshot.requireData.data;
                  Goal? goal = goalQueryDocumentSnapshot.toModel();

                  return InkWell(
                    onTap: () {
                      // TODO OnGoalClicked
                    },
                    onLongPress: () {
                      if (onGoalLongPress != null) {
                        onGoalLongPress!(goal);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.sports_soccer),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  goal?.scorerRef != null
                                      ? StreamBuilder(
                                          stream: goal?.scorerRef?.snapshots(),
                                          builder: (context, scorerSnapshot) {
                                            if (scorerSnapshot.hasError) {
                                              return const Center(child: Text("Erreur"));
                                            }

                                            if (!scorerSnapshot.hasData) {
                                              return const Center(child: CircularProgressIndicator());
                                            }

                                            Player scorer = Player.fromSnapshot(scorerSnapshot.requireData as DocumentSnapshot);

                                            return RichText(
                                              text: TextSpan(children: [
                                                const TextSpan(
                                                  text: "But de ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: scorer.name,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ]),
                                            );
                                          },
                                        )
                                      : RichText(
                                          text: const TextSpan(children: [
                                            TextSpan(
                                              text: "But ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "contre son camp",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                        ),
                                  if (goal?.passerRef != null)
                                    StreamBuilder(
                                      stream: goal?.passerRef?.snapshots(),
                                      builder: (context, passerSnapshot) {
                                        if (passerSnapshot.hasError) {
                                          return const Center(child: Text("Erreur"));
                                        }

                                        if (!passerSnapshot.hasData) {
                                          return const Center(child: CircularProgressIndicator());
                                        }

                                        Player passer = Player.fromSnapshot(passerSnapshot.requireData as DocumentSnapshot);

                                        return Text(
                                          "Passe de ${passer.name}",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (goal?.time != null) Text("${goal!.time}'")
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}

class SubstitutesListPage extends StatelessWidget {
  const SubstitutesListPage({
    Key? key,
    required this.substitutesSnapshot,
    this.onSubstituteLongPress,
  }) : super(key: key);

  final List<SubstituteQueryDocumentSnapshot> substitutesSnapshot;
  final Function(Substitute? substitute)? onSubstituteLongPress;

  @override
  Widget build(BuildContext context) {
    return substitutesSnapshot.isEmpty
        ? const Center(child: Text("Aucun changement"))
        : ListView.builder(
            itemCount: substitutesSnapshot.length,
            itemBuilder: (context, index) {
              var substituteQueryDocumentSnapshot = substitutesSnapshot[index];

              return FirestoreBuilder(
                ref: substituteQueryDocumentSnapshot.reference,
                builder: (context, AsyncSnapshot<SubstituteDocumentSnapshot> substituteDocumentSnapshot, Widget? child) {
                  if (substituteDocumentSnapshot.hasError) {
                    return const Center(child: Text("Erreur"));
                  }

                  if (!substituteDocumentSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Substitute? substitute = substituteDocumentSnapshot.requireData.data;
                  Substitute? substitute = substituteQueryDocumentSnapshot.toModel();

                  return InkWell(
                    onTap: () {
                      // TODO OnSubstituteClicked
                    },
                    onLongPress: () {
                      if (onSubstituteLongPress != null) {
                        onSubstituteLongPress!(substitute);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.compare_arrows),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder(
                                    stream: substitute?.playerInRef?.snapshots(),
                                    builder: (context, scorerSnapshot) {
                                      if (scorerSnapshot.hasError) {
                                        return const Center(child: Text("Erreur"));
                                      }

                                      if (!scorerSnapshot.hasData) {
                                        return const Center(child: CircularProgressIndicator());
                                      }

                                      Player playerIn = Player.fromSnapshot(scorerSnapshot.requireData as DocumentSnapshot);

                                      return RichText(
                                        text: TextSpan(children: [
                                          const TextSpan(
                                            text: "Entrée de ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: playerIn.name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      );
                                    },
                                  ),
                                  StreamBuilder(
                                    stream: substitute?.playerOutRef?.snapshots(),
                                    builder: (context, passerSnapshot) {
                                      if (passerSnapshot.hasError) {
                                        return const Center(child: Text("Erreur"));
                                      }

                                      if (!passerSnapshot.hasData) {
                                        return const Center(child: CircularProgressIndicator());
                                      }

                                      Player playerOut = Player.fromSnapshot(passerSnapshot.requireData as DocumentSnapshot);

                                      return Text(
                                        "Sortie de ${playerOut.name}",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (substitute?.time != null) Text("${substitute!.time}'")
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}

class MatchDashboard extends StatelessWidget {
  const MatchDashboard({
    Key? key,
    this.onGoalClicked,
    this.onSubstituteClicked,
    this.onOpponentGoalClicked,
    this.onOpponentGoalLongPress,
  }) : super(key: key);

  final Function()? onGoalClicked;
  final Function()? onSubstituteClicked;
  final Function()? onOpponentGoalClicked;
  final Function()? onOpponentGoalLongPress;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        FootrackGridTile(
          icon: Icons.sports_soccer,
          title: "But",
          onTap: onGoalClicked,
        ),
        FootrackGridTile(
          icon: Icons.person_add,
          title: "Changements",
          onTap: onSubstituteClicked,
        ),
        const FootrackGridTile(
          icon: Icons.groups,
          title: "Effectif",
          enabled: false,
        ),
        FootrackGridTile(
          icon: Icons.sports_soccer,
          title: "But adverse",
          onTap: onOpponentGoalClicked,
          onLongPress: onOpponentGoalLongPress,
        ),
        const FootrackGridTile(
          icon: Icons.access_alarm,
          title: "Début du match",
          enabled: false,
        ),
        const FootrackGridTile(
          icon: Icons.alarm_off,
          title: "Temps mort",
          enabled: false,
        ),
        const FootrackGridTile(
          icon: Icons.alarm_on,
          title: "Reprise du match",
          enabled: false,
        ),
      ],
    );
  }
}
