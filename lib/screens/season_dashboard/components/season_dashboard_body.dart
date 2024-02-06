import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body_actions_grid.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body_situation.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body_next_match.dart';
import 'package:footrack_front/screens/season_dashboard/components/season_dashboard_body_health.dart';

class SeasonDashboardBody extends ConsumerWidget {
  const SeasonDashboardBody({
    super.key,
    required this.season,
    this.onNextMatchClick,
    this.onHealthClick,
    this.onSituationClick,
  });

  final Season season;
  final Function(Match)? onNextMatchClick;
  final Function()? onHealthClick;
  final Function()? onSituationClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var matchs = season.let((s) => ref.watch(s.matchsProvider));

    return SingleChildScrollView(
      child: Column(
        children: [
          SeasonDashboardBodyNextMatch(
            matchs: matchs,
            onClick: onNextMatchClick,
          ),
          SeasonDashboardBodyHealth(
            matchs: matchs,
            take: 5,
            onClick: onHealthClick,
          ),
          SeasonDashboardBodySituation(
            matchs: matchs,
            onClick: onSituationClick,
          ),
          const SeasonDashboardBodyActionsGrid(),
        ],
      ),
    );
  }
}
