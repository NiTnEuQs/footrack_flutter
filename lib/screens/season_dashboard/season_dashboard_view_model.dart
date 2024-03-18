import 'package:flutter/material.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/notifiers/match_notifier.dart';
import 'package:footrack_front/screens/match_dashboard/ui/match_dashboard_screen.dart';
import 'package:footrack_front/screens/matchs_list/ui/matchs_list_page.dart';
import 'package:footrack_front/shared/view_model.dart';

class SeasonDashboardViewModel extends ViewModel {
  void openNextMatch(Match match) {
    ref.read(matchIdProvider.notifier).set(match.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MatchDashboardScreen(),
      ),
    );
  }

  void openMatchsListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MatchsListPage(),
      ),
    );
  }
}
