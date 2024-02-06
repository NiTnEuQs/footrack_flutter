import 'package:flutter/material.dart';
import 'package:footrack_front/components/alerts/alert_opponent.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/shared/view_model.dart';

class OpponentsListViewModel extends ViewModel {
  void addOpponent() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertOpponent();
      },
    );
  }

  void editOpponent(Opponent opponent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertOpponent(
          opponent: opponent,
        );
      },
    );
  }
}
