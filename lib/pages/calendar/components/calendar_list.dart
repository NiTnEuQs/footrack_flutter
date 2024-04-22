import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/opponent_extension.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/pages/calendar/components/calendar_list_item.dart";
import "package:skeletonizer/skeletonizer.dart";

class CalendarList extends ConsumerWidget {
  const CalendarList({
    super.key,
    required this.calendar,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.onMatchClick,
    this.onMatchLongClick,
  });

  final List<Match> calendar;
  final bool isLoading;
  final bool shrinkWrap;
  final Function(Match)? onMatchClick;
  final Function(Match)? onMatchLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final season = ref.watch(seasonChoseProvider);

    calendar.sort(
      (e1, e2) => e2.getDate().compare(e1.getDate()),
    );

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: calendar.length,
        itemBuilder: (context, index) {
          final match = calendar[index];

          return CalendarListItem(
            scoreTeamLeft: match.getTotalScoreTeam(ref),
            scoreTeamRight: match.getScoreOpponent(),
            nameTeamLeft: season.getTeamName(),
            nameTeamRight: match.getOpponent(ref).getName(),
            date: match.getDate(),
            backgroundColor: match.resultColor(ref)?.withAlpha(100),
            onClick: () {
              onMatchClick?.call(match);
            },
            onLongClick: () {
              onMatchLongClick?.call(match);
            },
          );
        },
      ),
    );
  }
}
