import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/goal.dart';

class MatchDashboardEventGoalContent extends ConsumerWidget {
  const MatchDashboardEventGoalContent({
    Key? key,
    required this.goal,
  }) : super(key: key);

  final Goal goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scorer = ref.watch(goal.scorerProvider)?.getName() ?? "Contre son camp";
    var passer = ref.watch(goal.passerProvider)?.getName() ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          scorer,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (goal.scorer != null && goal.passer != null)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Passe de ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: passer,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
