import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alerts/alert_match.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/notifiers/match_notifier.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/screens/match_dashboard/ui/match_dashboard_screen.dart';

class MatchsListPage extends ConsumerStatefulWidget {
  const MatchsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchsListPageState();
}

class _MatchsListPageState extends ConsumerState<MatchsListPage> {
  List<Match> _matchs = List.empty(growable: true);
  bool _sortAscending = true;
  int _sortIndex = 0;

  void _addMatch() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertMatch();
      },
    );
  }

  void _editMatch(Match match) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertMatch(
          match: match,
        );
      },
    );
  }

  void _openMatch(Match match) {
    ref.read(matchIdProvider.notifier).set(match.id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MatchDashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(selectedSeasonProvider);

    _matchs = (ref.watch(season.matchsProvider) ?? _matchs)
      ..sort((e1, e2) {
        switch (_sortIndex) {
          case 1:
            {
              int scoreA = e1.getTotalScoreTeam(ref) - e1.getScoreOpponent();
              int scoreB = e2.getTotalScoreTeam(ref) - e2.getScoreOpponent();

              return _sortAscending ? scoreB.compare(scoreA) : scoreA.compare(scoreB);
            }
          case 2:
            {
              int scoreA = e1.getTotalScoreTeam(ref);
              int scoreB = e2.getTotalScoreTeam(ref);

              return _sortAscending ? scoreB.compare(scoreA) : scoreA.compare(scoreB);
            }
          case 3:
            {
              int scoreA = e1.getScoreOpponent();
              int scoreB = e2.getScoreOpponent();

              return _sortAscending ? scoreB.compare(scoreA) : scoreA.compare(scoreB);
            }
          default:
            {
              DateTime? dateA = e1.date.toDateTime();
              DateTime? dateB = e2.date.toDateTime();

              return _sortAscending ? dateB.compare(dateA) : dateA.compare(dateB);
            }
        }
      });

    return Scaffold(
      appBar: AppBar(
        title: Text("Calendrier ${season.name ?? "Saison ${season.id}"}"),
      ),
      body: _matchs.isEmpty
          ? const Center(child: Text("Aucun match dans le calendrier"))
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
                  // const DataColumn(
                  //   label: Text(""),
                  //   numeric: true,
                  // ),
                  // const DataColumn(
                  //   label: Text("J"),
                  //   numeric: true,
                  // ),
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
                    label: const Text("R"),
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
                    label: const Text("BP"),
                    numeric: true,
                    onSort: (index, sorted) {
                      int columnIndex = 2;
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
                      int columnIndex = 3;
                      setState(() {
                        _sortAscending = _sortIndex == columnIndex ? !_sortAscending : false;
                        _sortIndex = columnIndex;
                      });
                    },
                  ),
                ],
                rows: List.of(_matchs).map(
                  (match) {
                    return DataRow(
                      onSelectChanged: (selected) {
                        _openMatch(match);
                      },
                      onLongPress: () {
                        _editMatch(match);
                      },
                      cells: [
                        // DataCell(match.getType().icon()),
                        // DataCell(Text((season.nbMatchs(ref) - matchs.indexOf(match)).toString())),
                        DataCell(
                          switch (ref.watch(match.opponentProvider)) {
                            != null => Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ref.watch(match.opponentProvider)!.getName()),
                                  Text(
                                    match.date.toDateTime().formatWithTimeAndDay(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            _ => Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Erreur"),
                                  Text(
                                    match.id,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                          },
                        ),
                        DataCell(
                          match.date.hasPassed()
                              ? Icon(
                                  Icons.circle,
                                  color: match.resultColor(ref),
                                )
                              : Container(),
                        ),
                        DataCell(Text(match.date.hasPassed() ? match.getTotalScoreTeam(ref).toString() : "")),
                        DataCell(Text(match.date.hasPassed() ? match.getScoreOpponent().toString() : "")),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMatch,
        tooltip: 'Ajouter un match',
        child: const Icon(Icons.add),
      ),
    );
  }
}
