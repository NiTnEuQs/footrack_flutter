import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/pages/calendar/ui/calendar_screen.dart";
import "package:footrack_front/pages/opponents/ui/opponents_screen.dart";
import "package:footrack_front/pages/season/ui/season_screen.dart";
import "package:footrack_front/pages/stats/ui/stats_screen.dart";
import "package:footrack_front/pages/team/ui/team_screen.dart";

class HomePageView extends ConsumerWidget {
  const HomePageView({
    super.key,
    this.pageController,
    this.onPageChanged,
  });

  final PageController? pageController;
  final Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      onPageChanged: onPageChanged,
      controller: pageController,
      children: const [
        SeasonScreen(),
        CalendarScreen(),
        TeamScreen(),
        OpponentsScreen(),
        StatsScreen(),
      ],
    );
  }
}
