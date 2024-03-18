import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alerts/alert_goal.dart';
import 'package:footrack_front/components/alerts/alert_substitute.dart';
import 'package:footrack_front/database/firestore_providers.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/player_event.dart';
import 'package:footrack_front/models/substitute.dart';
import 'package:footrack_front/notifiers/match_notifier.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/shared/view_model.dart';
import 'package:wakelock/wakelock.dart';

class MatchDashboardViewModel extends ViewModel {
  @override
  void init(BuildContext context, WidgetRef ref) {
    super.init(context, ref);

    Wakelock.enable();
  }

  Future<bool> onWillPop() async {
    Wakelock.disable();
    return true;
  }

  void addGoal() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertGoal(
          onAddPressed: (newGoal) async {
            ref.read(dbProvider).addNewGoal(
                  ref.read(selectedSeasonProvider).id,
                  ref.read(selectedMatchProvider).id,
                  newGoal,
                );

            Navigator.pop(context);
          },
        );
      },
    );
  }

  void increaseOpponentGoal() {
    ref.read(increaseOpponentGoalProvider);
  }

  void decreaseOpponentGoal() {
    ref.read(decreaseOpponentGoalProvider);
  }

  void addSubstitute() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertSubstitute(
          onAddPressed: (newSubstitute) async {
            ref.read(dbProvider).addNewSubstitute(
                  ref.read(selectedSeasonProvider).id,
                  ref.read(selectedMatchProvider).id,
                  newSubstitute,
                );

            Navigator.pop(context);
          },
        );
      },
    );
  }

  void openTeam() {}

  void startOrPauseMatch() {}

  void halfTimeOrStopMatch() {}

  void editEvent(PlayerEvent event) {
    switch (event) {
      case Goal():
        editGoal(event);
      case Substitute():
        editSubstitute(event);
    }
  }

  void editGoal(Goal goal) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertGoal(
          goal: goal,
          onEditPressed: (newGoal) async {
            ref.read(dbProvider).editGoal(
                  ref.read(selectedSeasonProvider).id,
                  ref.read(selectedMatchProvider).id,
                  goal.id,
                  newGoal,
                );

            Navigator.pop(context);
          },
          onDeletePressed: () async {
            ref.read(dbProvider).removeGoal(
                  ref.read(selectedSeasonProvider).id,
                  ref.read(selectedMatchProvider).id,
                  goal.id,
                );

            Navigator.pop(context);
          },
        );
      },
    );
  }

  void editSubstitute(Substitute substitute) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertSubstitute(
          substitute: substitute,
          onEditPressed: (newSubstitute) async {
            ref.read(dbProvider).editSubstitute(
                  ref.read(selectedSeasonProvider).id,
                  ref.read(selectedMatchProvider).id,
                  substitute.id,
                  newSubstitute,
                );

            Navigator.pop(context);
          },
          onDeletePressed: () async {
            ref.read(dbProvider).removeSubstitute(
                  ref.read(selectedSeasonProvider).id,
                  ref.read(selectedMatchProvider).id,
                  substitute.id,
                );

            Navigator.pop(context);
          },
        );
      },
    );
  }
}
