import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_opponent.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/opponent.dart";
import "package:footrack_front/pages/opponents_list/components/opponents_list.dart";

class OpponentsListPage extends ConsumerStatefulWidget {
  const OpponentsListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpponentsListPageState();
}

class _OpponentsListPageState extends ConsumerState<OpponentsListPage> {
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
      appBar: AppBar(
        title: Text(
          "Vos adversaires",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: opponents.isEmpty
          ? Center(
              child: Text(
                "Aucun adversaire",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : OpponentsList(
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
