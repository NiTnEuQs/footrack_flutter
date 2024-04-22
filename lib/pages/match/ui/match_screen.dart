import "dart:math";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_goal.dart";
import "package:footrack_front/components/alert_substitute.dart";
import "package:footrack_front/components/ft_grid_tile.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/opponent_extension.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/goal.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/models/player_event.dart";
import "package:footrack_front/models/substitute.dart";
import "package:footrack_front/pages/squad/ui/squad_screen.dart";
import "package:wakelock/wakelock.dart";

class MatchScreen extends ConsumerStatefulWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  void _addGoal() {
    showDialog(
      context: context,
      builder: (context) => const AlertGoal(),
    );
  }

  void _addSubstitute() {
    showDialog(
      context: context,
      builder: (_) => const AlertSubstitute(),
    );
  }

  void _openSquad() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SquadScreen(),
      ),
    );
  }

  void _updateOpponentGoal(int? opponentGoal) {
    ref.watch(dbProvider).updateOpponentGoal(
          ref.read(seasonChoseProvider)?.id,
          ref.read(matchChoseProvider)?.id,
          opponentGoal,
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

  Future<bool> _onWillPop(bool pop) async {
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
    var season = ref.watch(seasonChoseProvider);
    var match = ref.watch(matchChoseProvider);
    var goals = match.getGoals(ref);
    var substitutes = match.getSubstitutes(ref);
    var opponent = match.getOpponent(ref);

    return PopScope(
      onPopInvoked: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            opponent.getName(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: match == null
            ? Center(
                child: Text(
                  "Match non disponible",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.xs2),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Spacing.xs2, horizontal: Spacing.xs),
                          child: Center(
                            child: Text(
                              match.getDate().formatWithTimeAndDay(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Spacing.xs2, horizontal: Spacing.xs),
                          child: Center(
                            child: match.getDate().hasPassed()
                                ? Text(
                                    match.getResultString(ref),
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: match.getResultColor(ref),
                                          fontWeight: FontWeight.bold,
                                        ),
                                  )
                                : Text(
                                    match.getTime() != null ? "${match.getTime()}'" : "N'a pas encore débuté",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Spacing.xs2, horizontal: Spacing.xs),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 3,
                                fit: FlexFit.tight,
                                child: Center(
                                  child: Text(
                                    season.getTeamName(defaultValue: "Votre équipe"),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "${match.getTotalScoreTeam(ref)} - ${match.getScoreOpponent()}",
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                                    opponent.getName(defaultValue: "Adversaire"),
                                    style: Theme.of(context).textTheme.bodyMedium,
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
                      events: <PlayerEvent>[...goals, ...substitutes]
                        ..sort((a, b) => b.createdAt.compare(a.createdAt, nullIsFirst: true))
                        ..sort((a, b) => b.getTime().compare(a.getTime(), nullIsFirst: true)),
                      onEventLongPress: _editEvent,
                    ),
                  ),
                  MatchDashboard(
                    match: match,
                    onGoalClicked: _addGoal,
                    onSubstituteClicked: _addSubstitute,
                    onSquadClicked: _openSquad,
                    onOpponentGoalClicked: () {
                      _updateOpponentGoal(match.getScoreOpponent() + 1);
                    },
                    onOpponentGoalLongPress: () {
                      _updateOpponentGoal(max(0, match.getScoreOpponent() - 1));
                    },
                    onStartClicked: _startOrPauseMatch,
                    onStopClicked: _halfTimeOrStopMatch,
                  ),
                ],
              ),
      ),
    );
  }
}

class EventsListPage extends ConsumerWidget {
  const EventsListPage({
    super.key,
    required this.events,
    this.onEventTap,
    this.onEventLongPress,
  });

  final List<PlayerEvent> events;
  final Function(PlayerEvent? event)? onEventTap;
  final Function(PlayerEvent? event)? onEventLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return events.isEmpty
        ? Center(
            child: Text(
              "Aucun évènement",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
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
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.s),
                  child: Row(
                    children: [
                      event.getIcon() ?? Container(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              event.getTitle(ref),
                              event.getSubtitle(ref),
                            ],
                          ),
                        ),
                      ),
                      if (event.getTime() != null)
                        Text(
                          "${event.getTime()}'",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
    super.key,
    required this.match,
    this.onGoalClicked,
    this.onSubstituteClicked,
    this.onSquadClicked,
    this.onStartClicked,
    this.onStopClicked,
    this.onOpponentGoalClicked,
    this.onOpponentGoalLongPress,
  });

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
