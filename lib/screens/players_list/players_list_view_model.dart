import 'package:flutter/material.dart';
import 'package:footrack_front/components/alerts/alert_player.dart';
import 'package:footrack_front/database/firestore_providers.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/shared/view_model.dart';

class PlayersListViewModel extends ViewModel {
  void addPlayer() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertPlayer(
          onAddPressed: (newPlayer) async {
            ref.read(dbProvider).addNewPlayer(
                  ref.read(selectedSeasonProvider).id,
                  newPlayer,
                );

            Navigator.pop(context);
          },
        );
      },
    );
  }

  void editPlayer(Player player) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertPlayer(
          player: player,
          onEditPressed: (newPlayer) async {
            ref.read(dbProvider).editPlayer(
                  ref.read(selectedSeasonProvider).id,
                  player.id,
                  newPlayer,
                );

            Navigator.pop(context);
          },
          onDeletePressed: () async {
            ref.read(dbProvider).removePlayer(
                  ref.read(selectedSeasonProvider).id,
                  player.id,
                );

            Navigator.pop(context);
          },
        );
      },
    );
  }
}
