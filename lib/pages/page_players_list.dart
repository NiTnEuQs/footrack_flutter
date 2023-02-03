import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_player.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:footrack_front/models/season.dart';

class PlayersListPage extends ConsumerStatefulWidget {
  const PlayersListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayersListPageState();
}

class _PlayersListPageState extends ConsumerState<PlayersListPage> {
  bool _sortAscending = false;
  int _sortIndex = 0;

  void _addPlayer() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertPlayer(ref: ref);
      },
    );
  }

  void _editPlayer(Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertPlayer(
          ref: ref,
          player: player,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var players = seasonsRef.doc(ref.read(seasonChoseProvider)?.id).players;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Joueurs"),
      ),
      body: FirestoreBuilder(
        ref: players,
        builder: (context, AsyncSnapshot<PlayerQuerySnapshot> playerQuerySnapshot, Widget? child) {
          if (playerQuerySnapshot.hasError) {
            debugPrint(playerQuerySnapshot.error.toString());
            return const Center(child: Text('Erreur'));
          }

          if (!playerQuerySnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = playerQuerySnapshot.requireData.docs
            ..sort((a, b) {
              String nameA = a.data.name;
              String nameB = b.data.name;

              switch (_sortIndex) {
                case 0:
                  {
                    return _sortAscending ? nameB.compareTo(nameA) : nameA.compareTo(nameB);
                  }
                default:
                  return nameB.compareTo(nameA);
              }
            });

          return docs.isEmpty
              ? const Center(child: Text("Aucun joueur"))
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
                        label: const Text("Joueur"),
                        onSort: (index, sorted) {
                          setState(() {
                            _sortAscending = _sortIndex == 0 ? !_sortAscending : false;
                            _sortIndex = 0;
                          });
                        },
                      ),
                      const DataColumn(
                        label: Text("A"),
                        numeric: true,
                        // onSort: (index, sorted) {
                        //   setState(() {
                        //     _sortAscending = _sortIndex == 1 ? !_sortAscending : false;
                        //     _sortIndex = 1;
                        //   });
                        // },
                      ),
                      const DataColumn(
                        label: Text("B"),
                        numeric: true,
                        // onSort: (index, sorted) {
                        //   setState(() {
                        //     _sortAscending = _sortIndex == 2 ? !_sortAscending : false;
                        //     _sortIndex = 2;
                        //   });
                        // },
                      ),
                      const DataColumn(
                        label: Text("P"),
                        numeric: true,
                        // onSort: (index, sorted) {
                        //   setState(() {
                        //     _sortAscending = _sortIndex == 3 ? !_sortAscending : false;
                        //     _sortIndex = 3;
                        //   });
                        // },
                      ),
                    ],
                    rows: List.of(docs).map((PlayerQueryDocumentSnapshot e) {
                      Player player = e.toModel();

                      return DataRow(
                        cells: [
                          DataCell(
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(player.name),
                                Text(
                                  player.role.format(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          DataCell(Text(player.name.length.toString())),
                          DataCell(Text((player.name.length - 1).toString())),
                          DataCell(Text((player.name.length - 2).toString())),
                        ],
                        onLongPress: () {
                          _editPlayer(player);
                        },
                      );
                    }).toList(),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPlayer,
        tooltip: 'Ajouter un joueur',
        child: const Icon(Icons.add),
      ),
    );
  }
}
