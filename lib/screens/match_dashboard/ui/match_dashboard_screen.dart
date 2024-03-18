import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/models/player_event.dart';
import 'package:footrack_front/models/substitute.dart';
import 'package:footrack_front/notifiers/match_notifier.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/screens/match_dashboard/components/match_dashboard_actions_grid.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/match_dashboard_events_list.dart';
import 'package:footrack_front/screens/match_dashboard/match_dashboard_view_model.dart';
import 'package:footrack_front/shared/view_model_consumer_state.dart';

class MatchDashboardScreen extends ConsumerStatefulWidget {
  const MatchDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchDashboardScreenState();
}

class _MatchDashboardScreenState extends ViewModelConsumerState<MatchDashboardScreen, MatchDashboardViewModel> {
  var _goals = List<Goal>.empty(growable: true);
  var _substitutes = List<Substitute>.empty(growable: true);
  var _opponent = Opponent();

  @override
  Widget build(BuildContext context) {
    var match = ref.watch(selectedMatchProvider);

    _goals = (ref.watch(match.goalsProvider) ?? _goals);
    _substitutes = (ref.watch(match.substitutesProvider) ?? _substitutes);
    _opponent = (ref.watch(match.opponentProvider) ?? _opponent);

    return WillPopScope(
      onWillPop: viewModel.onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: switch (_opponent) {
            != null => Text(_opponent.getName()),
            _ => const Text("Match"),
          },
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
                        match.date.toDateTime().formatWithTimeAndDay(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Center(
                      child: match.date.hasPassed()
                          ? Text(
                              match.resultString(ref),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: match.resultColor(ref),
                                  ),
                            )
                          : Text(
                              match.time != null ? "${match.time}'" : "N'a pas encore débuté",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
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
                              ref.watch(selectedSeasonProvider).teamName ?? "Votre équipe",
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "${_goals.length} - ${match.scoreOpponent?.toString()}",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Center(
                            child: Text(
                              _opponent.getName(),
                              style: Theme.of(context).textTheme.titleSmall,
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
              child: MatchDashboardEventsList(
                events: <PlayerEvent>[..._goals, ..._substitutes]
                  ..sort((a, b) {
                    var playerA = a.createdAt;
                    var playerB = b.createdAt;

                    return playerB.compare(playerA);
                  })
                  ..sort((a, b) {
                    var playerA = ref.watch(a.getPlayer1Provider())?.getName();
                    var playerB = ref.watch(b.getPlayer1Provider())?.getName();

                    return playerA.compare(playerB);
                  })
                  ..sort((a, b) {
                    var playerA = a.getTime();
                    var playerB = b.getTime();

                    return playerB.compare(playerA, nullIsFirst: true);
                  }),
                onEventLongPress: viewModel.editEvent,
              ),
            ),
            MatchDashboardActionsGrid(
              match: match,
              onGoalClicked: viewModel.addGoal,
              onSubstituteClicked: viewModel.addSubstitute,
              onTeamClicked: viewModel.openTeam,
              onStartClicked: viewModel.startOrPauseMatch,
              onStopClicked: viewModel.halfTimeOrStopMatch,
              onOpponentGoalClicked: viewModel.increaseOpponentGoal,
              onOpponentGoalLongPress: viewModel.decreaseOpponentGoal,
            ),
          ],
        ),
      ),
    );
  }
}
