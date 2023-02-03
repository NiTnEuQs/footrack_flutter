import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_opponent.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/models/season.dart';

class OpponentsListPage extends ConsumerStatefulWidget {
  const OpponentsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpponentsListPageState();
}

class _OpponentsListPageState extends ConsumerState<OpponentsListPage> {
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
    var opponents = seasonsRef.doc(ref.read(seasonChoseProvider)?.id).opponents;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adversaires"),
      ),
      body: FirestoreBuilder(
        ref: opponents,
        builder: (context, AsyncSnapshot<OpponentQuerySnapshot> opponentQuerySnapshot, Widget? child) {
          if (opponentQuerySnapshot.hasError) {
            debugPrint(opponentQuerySnapshot.error.toString());
            return const Center(child: Text('Erreur'));
          }

          if (!opponentQuerySnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = opponentQuerySnapshot.requireData.docs
            ..sort((a, b) {
              String nameA = a.data.name;
              String nameB = b.data.name;
              return nameA.compareTo(nameB);
            });

          return docs.isEmpty
              ? const Center(child: Text("Aucun adversaire"))
              : SingleChildScrollView(
                  child: DataTable(
                      showCheckboxColumn: false,
                      headingRowHeight: 35,
                      headingTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      columns: const [
                        DataColumn(label: Text("Adversaire")),
                      ],
                      rows: List.of(docs).map((OpponentQueryDocumentSnapshot e) {
                        Opponent opponent = e.toModel();

                        return DataRow(
                          cells: [
                            DataCell(Text(opponent.name)),
                          ],
                          onLongPress: () {
                            _editOpponent(opponent);
                          },
                        );
                      }).toList()),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOpponent,
        tooltip: 'Ajouter un adversaire',
        child: const Icon(Icons.add),
      ),
    );
  }
}
