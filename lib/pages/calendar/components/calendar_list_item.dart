import "package:flutter/material.dart";
import "package:footrack_front/components/match_result_display.dart";
import "package:footrack_front/components/text_icon.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/enums/match_type_enum.dart";

class CalendarListItem extends StatelessWidget {
  const CalendarListItem({
    super.key,
    required this.scoreTeamLeft,
    required this.scoreTeamRight,
    required this.nameTeamLeft,
    required this.nameTeamRight,
    this.type,
    this.date,
    this.backgroundColor,
    this.onClick,
    this.onLongClick,
  });

  final int scoreTeamLeft;
  final int scoreTeamRight;
  final String nameTeamLeft;
  final String nameTeamRight;
  final MatchTypeEnum? type;
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
          child: Column(
            children: [
              TextIcon(
                icon: type.icon(),
                text: Text(type.format(), style: Theme.of(context).textTheme.bodySmall),
                expanded: true,
                alignment: MainAxisAlignment.start,
              ),
              MatchResultDisplay(
                nameTeamLeft: nameTeamLeft,
                nameTeamRight: nameTeamRight,
                scoreTeamLeft: scoreTeamLeft,
                scoreTeamRight: scoreTeamRight,
                date: date,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
