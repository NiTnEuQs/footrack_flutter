import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_match.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/pages/page_match_dashboard.dart';

class MatchsListPage extends ConsumerStatefulWidget {
  const MatchsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchsListPageState();
}

class _MatchsListPageState extends ConsumerState<MatchsListPage> {
  bool _sortAscending = true;
  int _sortIndex = 0;

  void _addMatch() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertMatch(ref: ref);
      },
    );
  }

  void _editMatch(Match match) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertMatch(
          ref: ref,
          match: match,
        );
      },
    );
  }

  void _openMatch(Match match) {
    ref.read(matchChoseProvider.notifier).state = match;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatchDashboardPage(match.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var matchs = seasonsRef.doc(ref.read(seasonChoseProvider)?.id).matchs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Matchs"),
      ),
      body: FirestoreBuilder(
        ref: matchs,
        builder: (context, AsyncSnapshot<MatchQuerySnapshot> matchQuerySnapshot, Widget? child) {
          if (matchQuerySnapshot.hasError) {
            debugPrint(matchQuerySnapshot.error.toString());
            return const Center(child: Text('Erreur'));
          }

          if (!matchQuerySnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = matchQuerySnapshot.requireData.docs
            ..sort((a, b) {
              switch (_sortIndex) {
                case 2:
                  {
                    int? scoreOpponentA = a.data.scoreOpponent;
                    int? scoreOpponentB = b.data.scoreOpponent;

                    return _sortAscending ? scoreOpponentB.compare(scoreOpponentA) : scoreOpponentA.compare(scoreOpponentB);
                  }
                default:
                  {
                    DateTime? dateA = a.data.date;
                    DateTime? dateB = b.data.date;

                    return _sortAscending ? dateB.compare(dateA) : dateA.compare(dateB);
                  }
              }
            });

          return docs.isEmpty
              ? const Center(child: Text("Aucun match"))
              : SingleChildScrollView(
                  child: DataTable(
                    showCheckboxColumn: false,
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
                        label: const Text("Adversaire"),
                        onSort: (index, sorted) {
                          int columnIndex = 0;
                          setState(() {
                            _sortAscending = _sortIndex == columnIndex ? !_sortAscending : true;
                            _sortIndex = columnIndex;
                          });
                        },
                      ),
                      DataColumn(
                        label: const Text("BP"),
                        numeric: true,
                        onSort: (index, sorted) {
                          int columnIndex = 1;
                          setState(() {
                            _sortAscending = _sortIndex == columnIndex ? !_sortAscending : false;
                            _sortIndex = columnIndex;
                          });
                        },
                      ),
                      DataColumn(
                        label: const Text("BC"),
                        numeric: true,
                        onSort: (index, sorted) {
                          int columnIndex = 2;
                          setState(() {
                            _sortAscending = _sortIndex == columnIndex ? !_sortAscending : false;
                            _sortIndex = columnIndex;
                          });
                        },
                      ),
                    ],
                    rows: List.of(docs).map((MatchQueryDocumentSnapshot e) {
                      Match match = e.toModel();
                      var goalsRef = seasonsRef.doc(ref.read(seasonChoseProvider)?.id).matchs.doc(match.id).goals;

                      // firstMatchNotPassed = match.date.hasPassed() ? ;

                      return DataRow(
                        onSelectChanged: (selected) {
                          _openMatch(match);
                        },
                        cells: [
                          DataCell(
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                match.opponentRef == null
                                    ? const Text("Erreur")
                                    : StreamBuilder(
                                        stream: match.opponentRef?.snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return const Center(child: Text("Erreur"));
                                          }

                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(),
                                              ),
                                            );
                                          }

                                          Opponent opponent = Opponent.fromSnapshot(snapshot.requireData! as DocumentSnapshot);

                                          return Text(opponent.name);
                                        }),
                                Text(
                                  match.date.formatWithTime(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                if (match.date.hasPassed())
                                  FirestoreBuilder(
                                    ref: goalsRef,
                                    builder: (context, AsyncSnapshot<GoalQuerySnapshot> goalQuerySnapshot, Widget? child) {
                                      if (goalQuerySnapshot.hasError) {
                                        return const Center(child: Text("Erreur"));
                                      }

                                      if (!goalQuerySnapshot.hasData) {
                                        return const SizedBox(
                                          width: 75,
                                          height: 5,
                                          child: LinearProgressIndicator(),
                                        );
                                      }

                                      int goals = goalQuerySnapshot.requireData.docs.length;
                                      match.scoreTeam = goals;

                                      return Text(
                                        match.resultString(),
                                        style: TextStyle(
                                          color: match.resultColor(),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                          DataCell(
                            FirestoreBuilder(
                              ref: goalsRef,
                              builder: (context, AsyncSnapshot<GoalQuerySnapshot> goalQuerySnapshot, Widget? child) {
                                if (goalQuerySnapshot.hasError) {
                                  return const Center(child: Text("Erreur"));
                                }

                                if (!goalQuerySnapshot.hasData) {
                                  return const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                int goals = goalQuerySnapshot.requireData.docs.length;
                                match.scoreTeam = goals;

                                return Text(goals.toString());
                              },
                            ),
                          ),
                          DataCell(Text(match.scoreOpponent.toString())),
                        ],
                        onLongPress: () {
                          _editMatch(match);
                        },
                      );
                    }).toList(),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMatch,
        tooltip: 'Ajouter un match',
        child: const Icon(Icons.add),
      ),
    );
  }
}
