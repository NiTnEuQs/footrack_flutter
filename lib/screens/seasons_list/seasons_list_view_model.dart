import 'package:flutter/material.dart';
import 'package:footrack_front/components/alerts/alert_season.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/screens/season_dashboard/ui/season_dashboard_screen.dart';
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
    ref.read(seasonIdProvider.notifier).set(season.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SeasonDashboardScreen(),
      ),
    );
  }
}
