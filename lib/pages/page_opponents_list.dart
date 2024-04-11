import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_opponent.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/opponent_extension.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/opponent.dart";

class OpponentsListPage extends ConsumerStatefulWidget {
  const OpponentsListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpponentsListPageState();
}

class _OpponentsListPageState extends ConsumerState<OpponentsListPage> {
  bool _sortAscending = true;
  int _sortIndex = 0;

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
    var opponents = season.getOpponents(ref)
      ..sort((a, b) {
        dynamic first = a.getName();
        dynamic second = b.getName();

        return _sortAscending
            ? (first as Comparable?).compare(second as Comparable?)
            : (second as Comparable?).compare(first as Comparable?);
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vos adversaires"),
      ),
      body: opponents.isEmpty
          ? const Center(child: Text("Aucun adversaire"))
          : SingleChildScrollView(
              child: DataTable(
                sortAscending: _sortAscending,
                sortColumnIndex: _sortIndex,
                headingRowHeight: Spacing.xl3,
                headingTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                columnSpacing: Spacing.xs,
                columns: [
                  DataColumn(
                    label: Text("Adversaire (${opponents.length})"),
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : true;
                        _sortIndex = index;
                      });
                    },
                  ),
                ],
                rows: List.of(opponents).map((opponent) {
                  return DataRow(
                    cells: [
                      DataCell(Text(opponent.getName())),
                    ],
                    onLongPress: () {
                      _editOpponent(opponent);
                    },
                  );
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addOpponent,
        label: const Text("Ajouter un adversaire"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
