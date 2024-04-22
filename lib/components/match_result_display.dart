import "package:flutter/material.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";

class MatchResultDisplay extends StatelessWidget {
  const MatchResultDisplay({
    super.key,
    required this.scoreTeamLeft,
    required this.scoreTeamRight,
    required this.nameTeamLeft,
    required this.nameTeamRight,
    this.displayDate = true,
    this.date,
  });

  final int scoreTeamLeft;
  final int scoreTeamRight;
  final String nameTeamLeft;
  final String nameTeamRight;
  final bool displayDate;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                nameTeamLeft,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(width: Spacing.xs),
            Text(
              "${date.hasPassed() ? scoreTeamLeft : ""} - ${date.hasPassed() ? scoreTeamRight : ""}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(width: Spacing.xs),
            Expanded(
              child: Text(
                nameTeamRight,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        if (date != null && displayDate)
          Text(
            date.formatLanguage(),
            style: Theme.of(context).textTheme.labelMedium?.let((it) {
              if (date.hasPassed()) {
                return it.copyWith(
                  color: Colors.black87,
                );
              }

              return it;
            }),
          ),
      ],
    );
  }
}
