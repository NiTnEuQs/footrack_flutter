import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_goal.dart';
import 'package:footrack_front/components/alert_substitute.dart';
import 'package:footrack_front/components/ft_grid_tile.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/enums/match_status_enum.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/models/player_event.dart';
import 'package:footrack_front/models/substitute.dart';
import 'package:wakelock/wakelock.dart';

final elapsedTimeProvider = StateProvider<int?>((_) => null);

class MatchDashboardPage extends ConsumerStatefulWidget {
  const MatchDashboardPage(this.matchId, {Key? key}) : super(key: key);

  final String matchId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchDashboardPageState();
}

class _MatchDashboardPageState extends ConsumerState<MatchDashboardPage> {
  final Stopwatch _stopwatch = Stopwatch();

  void _addGoal() {
    var season = ref.watch(seasonsProvider).firstWhereOrNull((e) => e.id == ref.watch(seasonChoseProvider)?.id);
    var match = season != null ? ref.watch(season.matchsProvider).firstWhereOrNull((e) => e.id == ref.watch(matchChoseProvider)?.id) : null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertGoal(
          ref: ref,
          time: ((match?.getTime() ?? 0) ~/ 60) + 1,
        );
      },
    );
  }

  void _updateOpponentGoal(int? newOpponentGoal) {
    ref.watch(dbProvider).updateOpponentGoal(ref.read(seasonChoseProvider)?.id, ref.read(matchChoseProvider)?.id, newOpponentGoal);
  }

  void _addSubstitute() {
    var season = ref.watch(seasonsProvider).firstWhereOrNull((e) => e.id == ref.watch(seasonChoseProvider)?.id);
    var match = season != null ? ref.watch(season.matchsProvider).firstWhereOrNull((e) => e.id == ref.watch(matchChoseProvider)?.id) : null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertSubstitute(
          ref: ref,
          time: ((match?.getTime() ?? 0) ~/ 60) + 1,
        );
      },
    );
  }

  void _openTeam() {}

  void _startOrPauseMatch() {
    var season = ref.watch(seasonsProvider).firstWhereOrNull((e) => e.id == ref.watch(seasonChoseProvider)?.id);
    var match = season != null ? ref.watch(season.matchsProvider).firstWhereOrNull((e) => e.id == ref.watch(matchChoseProvider)?.id) : null;

    var isMatchPlaying = _stopwatch.isRunning;

    if (isMatchPlaying) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }

    ref.watch(dbProvider).updateMatchStatus(
      ref.read(seasonChoseProvider)?.id,
      ref.read(matchChoseProvider)?.id,
      match?.let((it) {
        switch (it.getStatus()) {
          case MatchStatusEnum.pausedFirst:
            return MatchStatusEnum.playingFirst.name;
          case MatchStatusEnum.playingFirst:
            return MatchStatusEnum.pausedFirst.name;
          case MatchStatusEnum.pausedSecond:
            return MatchStatusEnum.playingSecond.name;
          case MatchStatusEnum.playingSecond:
            return MatchStatusEnum.pausedSecond.name;
          default:
            return MatchStatusEnum.finished.name;
        }
      }),
    );
  }

  void _halfTimeOrStopMatch() {
    var season = ref.watch(seasonsProvider).firstWhereOrNull((e) => e.id == ref.watch(seasonChoseProvider)?.id);
    var match = season != null ? ref.watch(season.matchsProvider).firstWhereOrNull((e) => e.id == ref.watch(matchChoseProvider)?.id) : null;

    match?.let((currentMatch) {
      switch (currentMatch.getStatus()) {
        case MatchStatusEnum.none:
          {
            _stopwatch.reset();
            _stopwatch.start();
            break;
          }
        case MatchStatusEnum.playingFirst:
        case MatchStatusEnum.pausedFirst:
          {
            _stopwatch.stop();

            (25 * 60).let((matchTime) {
              ref.read(elapsedTimeProvider.notifier).state = matchTime;
              // ref.read(dbProvider).updateMatchElapsedTime(
              //       ref.read(seasonChoseProvider)?.id,
              //       ref.read(matchChoseProvider)?.id,
              //       matchTime,
              //     );
            });

            _stopwatch.reset();
            _stopwatch.start();
            break;
          }
        default:
          {
            // Do nothing
            break;
          }
      }

      currentMatch.let((it) {
        switch (it.getStatus()) {
          case MatchStatusEnum.none:
            return MatchStatusEnum.playingFirst.name;
          case MatchStatusEnum.pausedFirst:
          case MatchStatusEnum.playingFirst:
            return MatchStatusEnum.playingSecond.name;
          case MatchStatusEnum.pausedSecond:
          case MatchStatusEnum.playingSecond:
          case MatchStatusEnum.finished:
            return MatchStatusEnum.finished.name;
        }
      }).let((status) {
        ref.read(dbProvider).updateMatchStatus(
              ref.read(seasonChoseProvider)?.id,
              ref.read(matchChoseProvider)?.id,
              status,
            );
      });
    });
  }

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
        return AlertSubstitute(
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
    var season = ref.watch(seasonsProvider).firstWhereOrNull((e) => e.id == ref.watch(seasonChoseProvider)?.id);
    var match = season != null ? ref.watch(season.matchsProvider).firstWhereOrNull((e) => e.id == ref.watch(matchChoseProvider)?.id) : null;
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
                        !match.date.hasPassed()
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                child: Text(
                                  match.resultString(ref),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: match.resultColor(ref),
                                  ),
                                ),
                              ),
                        MatchElapsedTime(stopwatch: _stopwatch),
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
                    onTeamClicked: () {
                      _openTeam();
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

class MatchElapsedTime extends ConsumerStatefulWidget {
  const MatchElapsedTime({super.key, required this.stopwatch});

  final Stopwatch stopwatch;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchElapsedTimeState();
}

class _MatchElapsedTimeState extends ConsumerState<MatchElapsedTime> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var season = ref.watch(seasonsProvider).firstWhereOrNull((e) => e.id == ref.watch(seasonChoseProvider)?.id);
      var match = season != null ? ref.watch(season.matchsProvider).firstWhereOrNull((e) => e.id == ref.watch(matchChoseProvider)?.id) : null;

      match?.let(
        (baseMatch) {
          ref.read(elapsedTimeProvider.notifier).state = baseMatch.time;

          if (baseMatch.isPlaying()) {
            widget.stopwatch.start();
          }

          Timer.periodic(const Duration(seconds: 1), (Timer t) {
            var season = ref.watch(seasonsProvider).firstWhereOrNull((e) => e.id == ref.watch(seasonChoseProvider)?.id);
            var match = season != null ? ref.watch(season.matchsProvider).firstWhereOrNull((e) => e.id == ref.watch(matchChoseProvider)?.id) : null;

            match?.let((it) {
              if (it.isPlaying() && widget.stopwatch.isRunning) {
                ref.watch(elapsedTimeProvider)?.let((elapsedTime) {
                  (elapsedTime + 1).let((newElapsedTime) {
                    ref.read(elapsedTimeProvider.notifier).state = newElapsedTime;

                    // updateMatchElapsedTime(newElapsedTime);
                  });
                });
              }
            });
          });
        },
      );
    });
  }

  void updateMatchElapsedTime(int newElapsedTime) async {
    ref.read(dbProvider).updateMatchElapsedTime(
          ref.read(seasonChoseProvider)?.id,
          ref.read(matchChoseProvider)?.id,
          newElapsedTime,
        );
  }

  @override
  Widget build(BuildContext context) {
    final elapsedTime = ref.watch(elapsedTimeProvider);
    final match = ref.watch(matchChoseProvider);
    var matchMinutes = (elapsedTime ?? 0) ~/ 60;
    var matchSeconds = (elapsedTime ?? 0) % 60;

    return match == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  match.getStatus().icon(),
                  const SizedBox(width: 16),
                  Text(match.hasBegun() ? "${matchMinutes.toString().padLeft(2, "0")}:${matchSeconds.toString().padLeft(2, "0")}" : "N'a pas encore débuté"),
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
                      Icon(event.getIcon()),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (event.getTitle(ref).isNotEmpty)
                                Text(
                                  event.getTitle(ref),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (event.getSubtitle(ref).isNotEmpty)
                                Text(
                                  event.getSubtitle(ref),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
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
    this.onTeamClicked,
    this.onStartClicked,
    this.onStopClicked,
    this.onOpponentGoalClicked,
    this.onOpponentGoalLongPress,
  }) : super(key: key);

  final Match match;
  final Function()? onGoalClicked;
  final Function()? onSubstituteClicked;
  final Function()? onTeamClicked;
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
          enabled: match.hasBegun(),
        ),
        FTGridTile(
          icon: Icons.person_add,
          title: "Changements",
          onTap: onSubstituteClicked,
          enabled: match.hasBegun(),
        ),
        FTGridTile(
          icon: Icons.groups,
          title: "Effectif",
          onTap: onTeamClicked,
          enabled: false,
          // enabled: !match.date.hasPassed(),
        ),
        FTGridTile(
          icon: Icons.sports_soccer,
          title: "But adverse",
          onTap: onOpponentGoalClicked,
          onLongPress: onOpponentGoalLongPress,
          enabled: match.hasBegun(),
        ),
        FTGridTile(
          icon: !match.isPlaying() ? Icons.play_arrow : Icons.pause,
          title: !match.isPlaying() ? "Reprise" : "Temps mort",
          onTap: onStartClicked,
          enabled: match.isPlaying() || match.isPaused(),
        ),
        FTGridTile(
          icon: match.let((it) {
            switch (it.getStatus()) {
              case MatchStatusEnum.none:
                return Icons.looks_one_rounded;
              case MatchStatusEnum.pausedFirst:
              case MatchStatusEnum.playingFirst:
                return Icons.looks_two_rounded;
              case MatchStatusEnum.pausedSecond:
              case MatchStatusEnum.playingSecond:
                return Icons.stop_circle;
              case MatchStatusEnum.finished:
                return Icons.dnd_forwardslash;
            }
          }),
          title: match.let((it) {
            switch (it.getStatus()) {
              case MatchStatusEnum.none:
                return "Début du match";
              case MatchStatusEnum.pausedFirst:
              case MatchStatusEnum.playingFirst:
                return "2ème mi-temps";
              case MatchStatusEnum.pausedSecond:
              case MatchStatusEnum.playingSecond:
                return "Fin du match";
              case MatchStatusEnum.finished:
                return "Match terminé";
            }
          }),
          onTap: onStopClicked,
          enabled: match.isNotFinished(),
        ),
      ],
    );
  }
}
