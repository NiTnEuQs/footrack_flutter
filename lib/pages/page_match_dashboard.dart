import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_goal.dart';
import 'package:footrack_front/components/alert_substitute.dart';
import 'package:footrack_front/components/ft_grid_tile.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/models/player_event.dart';
import 'package:footrack_front/models/substitute.dart';
import 'package:footrack_front/pages/page_match_squad.dart';
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
        return const AlertGoal();
      },
    );
  }

  void _updateOpponentGoal(int? newOpponentGoal) {
    ref
        .watch(dbProvider)
        .updateOpponentGoal(ref.read(seasonChoseProvider)?.id, ref.read(matchChoseProvider)?.id, newOpponentGoal);
  }

  void _addSubstitute() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertSubstitute();
      },
    );
  }

  void _openSquad() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MatchSquadPage(),
      ),
    );
  }

  void _startOrPauseMatch() {}

  void _halfTimeOrStopMatch() {}

  void _editEvent(PlayerEvent? event) {
    if (event is Goal) {
      _editGoal(event);
    } else if (event is Substitute) {
      _editSubstitute(event);
    }
  }

  void _editGoal(Goal? goal) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertGoal(
          goal: goal,
        );
      },
    );
  }

  void _editSubstitute(Substitute? substitute) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSubstitute(
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
    var season = ref.watch(seasonsProvider).firstWhereOrNull((e) => e.id == ref.watch(seasonChoseProvider)?.id);
    var match = season != null
        ? ref.watch(season.matchsProvider).firstWhereOrNull((e) => e.id == ref.watch(matchChoseProvider)?.id)
        : null;
    var goals = match != null ? ref.watch(match.goalsProvider) : <Goal>[];
    var substitutes = match != null ? ref.watch(match.substitutesProvider) : <Substitute>[];
    var opponent = match != null ? ref.watch(match.opponentProvider) : Opponent();
    // var match = season != null ? ref.watch(season.matchsProvider).firstWhere((element) => element.id == ref.watch(matchChoseProvider)?.id) : null;
    // var goals = match != null ? ref.watch(match.goalsProvider) : <Goal>[];
    // var substitutes = match != null ? ref.watch(match.substitutesProvider) : <Substitute>[];
    // var opponentName = match != null ? ref.watch(match.opponentProvider)?.getName() ?? "Votre adversaire" : "Erreur";

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Match"),
        ),
        body: match == null
            ? const Center(child: Text("Match non disponible"))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          child: Center(
                            child: Text(
                              match.date.toDateTime().formatWithTimeAndDay(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          child: Center(
                            child: match.date.hasPassed()
                                ? Text(
                                    match.resultString(ref),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: match.resultColor(ref),
                                    ),
                                  )
                                : Text(match.time != null ? "${match.time}'" : "N'a pas encore débuté"),
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
                                    "${match.getTotalScoreTeam(ref).toString()} - ${match.scoreOpponent?.toString()}",
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
                                    opponent?.getName() ?? "Adversaire",
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
                    child: EventsListPage(
                      ref: ref,
                      events: <PlayerEvent>[...goals, ...substitutes]..sort((a, b) {
                          return b.getTime().compare(a.getTime(), nullIsFirst: true);
                        }),
                      onEventLongPress: _editEvent,
                    ),
                  ),
                  MatchDashboard(
                    match: match,
                    onGoalClicked: () {
                      _addGoal();
                    },
                    onSubstituteClicked: () {
                      _addSubstitute();
                    },
                    onSquadClicked: () {
                      _openSquad();
                    },
                    onStartClicked: () {
                      _startOrPauseMatch();
                    },
                    onStopClicked: () {
                      _halfTimeOrStopMatch();
                    },
                    onOpponentGoalClicked: () {
                      if (match.scoreOpponent == null) return;

                      _updateOpponentGoal(match.scoreOpponent! + 1);
                    },
                    onOpponentGoalLongPress: () {
                      if (match.scoreOpponent == null) return;

                      _updateOpponentGoal(max(0, match.scoreOpponent! - 1));
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

class EventsListPage extends StatelessWidget {
  const EventsListPage({
    Key? key,
    required this.ref,
    required this.events,
    this.onEventTap,
    this.onEventLongPress,
  }) : super(key: key);

  final WidgetRef ref;
  final List<PlayerEvent> events;
  final Function(PlayerEvent? event)? onEventTap;
  final Function(PlayerEvent? event)? onEventLongPress;

  @override
  Widget build(BuildContext context) {
    return events.isEmpty
        ? const Center(child: Text("Aucun évènement"))
        : ListView.separated(
            itemCount: events.length,
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: Colors.black.withAlpha(10),
              );
            },
            itemBuilder: (context, index) {
              var event = events[index];

              return InkWell(
                onTap: () {
                  onEventTap?.let((it) {
                    it(event);
                  });
                },
                onLongPress: () {
                  onEventLongPress?.let((it) {
                    it(event);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                  child: Row(
                    children: [
                      event.getIcon() ?? Container(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              event.getTitle(ref),
                              event.getSubtitle(ref),
                            ],
                          ),
                        ),
                      ),
                      if (event.getTime() != null) Text("${event.getTime()}'")
                    ],
                  ),
                ),
              );
            },
          );
  }
}

class MatchDashboard extends StatelessWidget {
  const MatchDashboard({
    Key? key,
    required this.match,
    this.onGoalClicked,
    this.onSubstituteClicked,
    this.onSquadClicked,
    this.onStartClicked,
    this.onStopClicked,
    this.onOpponentGoalClicked,
    this.onOpponentGoalLongPress,
  }) : super(key: key);

  final Match match;
  final Function()? onGoalClicked;
  final Function()? onSubstituteClicked;
  final Function()? onSquadClicked;
  final Function()? onStartClicked;
  final Function()? onStopClicked;
  final Function()? onOpponentGoalClicked;
  final Function()? onOpponentGoalLongPress;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        FTGridTile(
          icon: Icons.sports_soccer,
          title: "But",
          onTap: onGoalClicked,
          color: Colors.green,
        ),
        FTGridTile(
          icon: Icons.person_add,
          title: "Changements",
          onTap: onSubstituteClicked,
          color: Colors.green,
        ),
        FTGridTile(
          icon: Icons.groups,
          title: "Effectif",
          onTap: onSquadClicked,
          color: Colors.blue,
          enabled: !match.date.hasPassed(),
        ),
        FTGridTile(
          icon: Icons.sports_soccer,
          title: "But adverse",
          onTap: onOpponentGoalClicked,
          color: Colors.red,
          onLongPress: onOpponentGoalLongPress,
        ),
        // FTGridTile(
        //   icon: !match.hasBegun() ? Icons.play_arrow : Icons.pause,
        //   title: !match.hasBegun() ? "Début" : "Temps mort",
        //   onTap: onStartClicked,
        //   enabled: !match.date.hasPassed(add: const Duration(hours: -2)),
        // ),
        // FTGridTile(
        //   icon: !match.hasBegun() ? Icons.looks_two_rounded : Icons.stop,
        //   title: !match.hasBegun() ? "Mi-temps" : "Fin du match",
        //   onTap: onStopClicked,
        //   enabled: !match.date.hasPassed(add: const Duration(hours: -2)),
        // ),
      ],
    );
  }
}
