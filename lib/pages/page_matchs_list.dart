import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_match.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/enums/match_type_enum.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/match.dart';
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
    var season = ref.watch(seasonChoseProvider);
    var matchs = season != null ? ref.watch(season.matchsProvider) : <Match>[]
      ..sort((e1, e2) {
        switch (_sortIndex) {
          case 1:
            {
              int? scoreA = e1.getTotalScoreTeam(ref);
              int? scoreB = e2.getTotalScoreTeam(ref);

              return _sortAscending ? scoreB.compare(scoreA) : scoreA.compare(scoreB);
            }
          case 2:
            {
              int? scoreA = e1.getScoreOpponent();
              int? scoreB = e2.getScoreOpponent();

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
        title: const Text("Votre calendrier"),
      ),
      body: season == null || matchs.isEmpty
          ? const Center(child: Text("Match non disponible"))
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
                columnSpacing: 8,
                columns: [
                  const DataColumn(
                    label: Text(""),
                    numeric: true,
                  ),
                  DataColumn(
                    label: Text("Match (${matchs.length})"),
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
                rows: List.of(matchs).map((match) {
                  return DataRow(
                    onSelectChanged: (selected) {
                      _openMatch(match);
                    },
                    cells: [
                      DataCell(match.getType().icon()),
                      DataCell(
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ref.watch(match.opponentProvider)?.getName() ?? "Erreur"),
                            Text(
                              match.date.toDateTime().formatWithTimeAndDay(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Text(
                          match.date.hasPassed() ? match.getTotalScoreTeam(ref).toString() : "",
                          style: TextStyle(color: match.resultColor(ref), fontWeight: match.teamFontWeight(ref)),
                        ),
                      ),
                      DataCell(
                        Text(
                          match.date.hasPassed() ? match.getScoreOpponent().toString() : "",
                          style: TextStyle(color: match.resultColor(ref), fontWeight: match.opponentFontWeight(ref)),
                        ),
                      ),
                    ],
                    onLongPress: () {
                      _editMatch(match);
                    },
                  );
                }).toList(),
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
