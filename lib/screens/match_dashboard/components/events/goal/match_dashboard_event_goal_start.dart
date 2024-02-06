import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/goal.dart';

class MatchDashboardEventGoalStart extends ConsumerWidget {
  const MatchDashboardEventGoalStart({
    Key? key,
    required this.goal,
  }) : super(key: key);

  final Goal goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var time = goal.getTime()?.let((it) => "$it'") ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.sports_soccer,
          color: Colors.green,
        ),
        if (goal.getTime() != null)
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall,
          )
      ],
    );
  }
}
