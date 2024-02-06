import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/goal/match_dashboard_event_goal_content.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/goal/match_dashboard_event_goal_start.dart';
import 'package:footrack_front/screens/match_dashboard/components/events/match_dashboard_event.dart';

class MatchDashboardEventGoal extends ConsumerWidget {
  const MatchDashboardEventGoal({
    Key? key,
    required this.goal,
    this.onGoalPress,
    this.onGoalLongPress,
  }) : super(key: key);

  final Goal goal;
  final Function(Goal goal)? onGoalPress;
  final Function(Goal goal)? onGoalLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MatchDashboardEvent(
      event: goal,
      startContent: MatchDashboardEventGoalStart(goal: goal),
      content: MatchDashboardEventGoalContent(goal: goal),
      onEventPress: () {
        onGoalPress?.call(goal);
      },
      onEventLongPress: () {
        onGoalLongPress?.call(goal);
      },
    );
  }
}
