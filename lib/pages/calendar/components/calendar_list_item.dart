import "package:flutter/material.dart";
import "package:footrack_front/components/match_result_display.dart";
import "package:footrack_front/core/ui/spacings.dart";

class CalendarListItem extends StatelessWidget {
  const CalendarListItem({
    super.key,
    required this.scoreTeamLeft,
    required this.scoreTeamRight,
    required this.nameTeamLeft,
    required this.nameTeamRight,
    this.date,
    this.backgroundColor,
    this.onClick,
    this.onLongClick,
  });

  final int scoreTeamLeft;
  final int scoreTeamRight;
  final String nameTeamLeft;
  final String nameTeamRight;
  final DateTime? date;
  final Color? backgroundColor;
  final Function()? onClick;
  final Function()? onLongClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onClick,
        onLongPress: onLongClick,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.m),
          child: MatchResultDisplay(
            nameTeamLeft: nameTeamLeft,
            nameTeamRight: nameTeamRight,
            scoreTeamLeft: scoreTeamLeft,
            scoreTeamRight: scoreTeamRight,
            date: date,
          ),
        ),
      ),
    );
  }
}
