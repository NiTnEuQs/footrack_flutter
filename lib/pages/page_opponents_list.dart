import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_opponent.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/models/opponent.dart';

class OpponentsListPage extends ConsumerStatefulWidget {
  const OpponentsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpponentsListPageState();
}

class _OpponentsListPageState extends ConsumerState<OpponentsListPage> {
  bool _sortAscending = false;
  int _sortIndex = 0;

  void _addOpponent() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertOpponent(ref: ref);
      },
    );
  }

  void _editOpponent(Opponent opponent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertOpponent(
          ref: ref,
          opponent: opponent,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var opponents = season != null ? ref.watch(season.opponentsProvider) : <Opponent>[]
      ..sort((e1, e2) {
        switch (_sortIndex) {
          case 0:
            {
              return (_sortAscending ? e2.getName().compareTo(e1.getName()) : e1.getName().compareTo(e2.getName()));
            }
          default:
            return e1.getName().compareTo(e2.getName());
        }
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
                  headingRowHeight: 35,
                  headingTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  columnSpacing: 16,
                  columns: [
                    DataColumn(
                      label: Text("Adversaire (${opponents.length})"),
                      onSort: (index, sorted) {
                        setState(() {
                          _sortAscending = _sortIndex == 0 ? !_sortAscending : false;
                          _sortIndex = 0;
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
                  }).toList()),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOpponent,
        tooltip: 'Ajouter un adversaire',
        child: const Icon(Icons.add),
      ),
    );
  }
}
