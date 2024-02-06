import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/generics/separator.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/player_event.dart';
import 'package:footrack_front/models/substitute.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/goal/match_dashboard_event_goal.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/substitute/match_dashboard_event_substitute.dart';

class MatchDashboardEventsListFilled extends ConsumerWidget {
  const MatchDashboardEventsListFilled({
    Key? key,
    required this.events,
    this.onEventPress,
    this.onEventLongPress,
  }) : super(key: key);

  final List<PlayerEvent> events;
  final Function(PlayerEvent event)? onEventPress;
  final Function(PlayerEvent event)? onEventLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: events.length,
      separatorBuilder: (context, index) => const Separator.horizontal(),
      itemBuilder: (context, index) {
        var event = events[index];

        return switch (event) {
          Goal() => MatchDashboardEventGoal(
              goal: event,
              onGoalPress: onEventPress,
              onGoalLongPress: onEventLongPress,
            ),
          Substitute() => MatchDashboardEventSubstitute(
              substitute: event,
              onSubstitutePress: onEventPress,
              onSubstituteLongPress: onEventLongPress,
            ),
          _ => null,
        };
      },
    );
  }
}
