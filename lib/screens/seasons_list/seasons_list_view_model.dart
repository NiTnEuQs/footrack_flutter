import 'package:flutter/material.dart';
import 'package:footrack_front/components/alerts/alert_season.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/database/global_providers.dart';
import 'package:footrack_front/screens/season_dashboard/ui/season_dashboard_page.dart';
import 'package:footrack_front/shared/view_model.dart';

class SeasonsListViewModel extends ViewModel {
  void addSeason() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSeason(ref: ref);
      },
    );
  }

  void editSeason(Season season) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSeason(
          ref: ref,
          season: season,
        );
      },
    );
  }

  void openSeason(Season season) {
    ref.read(seasonProvider.notifier).state = season;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SeasonDashboardPage(),
      ),
    );
  }
}
