import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/matchs_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body_next_match_empty.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body_next_match_filled.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body_next_match_no_match.dart';

class SeasonDashboardBodyNextMatch extends ConsumerWidget {
  const SeasonDashboardBodyNextMatch({
    super.key,
    required this.matchs,
    this.onClick,
  });

  final List<Match> matchs;
  final Function(Match)? onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var nextMatch = matchs.nextMatch();
    var nextMatchOpponent = nextMatch?.let((match) => ref.watch(match.opponentProvider));

    if (nextMatch != null && nextMatchOpponent != null) {
      return SeasonDashboardBodyNextMatchFilled(
        ref: ref,
        nextMatch: nextMatch,
        nextMatchOpponent: nextMatchOpponent,
        onClick: onClick,
      );
    } else if (matchs.isNotEmpty) {
      return const SeasonDashboardBodyNextMatchNoMatch();
    } else {
      return const SeasonDashboardBodyNextMatchEmpty();
    }
  }
}
