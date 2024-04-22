import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_opponent.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/opponent.dart";
import "package:footrack_front/pages/opponents/components/opponents_list.dart";

class OpponentsScreen extends ConsumerStatefulWidget {
  const OpponentsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpponentsScreenState();
}

class _OpponentsScreenState extends ConsumerState<OpponentsScreen> {
  void _addOpponent() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertOpponent();
      },
    );
  }

  void _editOpponent(Opponent opponent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertOpponent(
          opponent: opponent,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var opponents = season.getOpponents(ref);

    return Scaffold(
      body: OpponentsList(
        opponents: opponents,
        onOpponentLongClick: _editOpponent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addOpponent,
        label: const Text("Ajouter un adversaire"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
