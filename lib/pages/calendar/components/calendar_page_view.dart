import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/enums/match_type_enum.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/pages/calendar/components/calendar_list.dart";

class CalendarPageView extends ConsumerWidget {
  const CalendarPageView({
    super.key,
    required this.calendar,
    this.isLoading = false,
    this.pageController,
    this.onMatchClick,
    this.onMatchLongClick,
  });

  final List<Match> calendar;
  final bool isLoading;
  final PageController? pageController;
  final Function(Match)? onMatchClick;
  final Function(Match)? onMatchLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final championships = calendar.where((element) => element.getType() == MatchTypeEnum.championship).toList();
    final cups = calendar.where((element) => element.getType() == MatchTypeEnum.cup).toList();

    return PageView(
      controller: pageController,
      children: [
        CalendarList(
          calendar: championships,
          shrinkWrap: true,
          onMatchClick: onMatchClick,
          onMatchLongClick: onMatchLongClick,
        ),
        CalendarList(
          calendar: cups,
          shrinkWrap: true,
          onMatchClick: onMatchClick,
          onMatchLongClick: onMatchLongClick,
        ),
      ],
    );
  }
}
