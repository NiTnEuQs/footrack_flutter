import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_match.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/extensions/match_extension.dart';
import 'package:footrack_front/models/extensions/opponent_extension.dart';
import 'package:footrack_front/models/extensions/season_extension.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/pages/page_match_dashboard.dart';

class MatchsListPage extends ConsumerStatefulWidget {
  const MatchsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchsListPageState();
}

class _MatchsListPageState extends ConsumerState<MatchsListPage> {
  bool _sortAscending = false;
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
    ref.read(matchChoseProvider.notifier).state = match;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MatchDashboardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var matchs = season.getMatchs(ref)
      ..sort((a, b) {
        dynamic first;
        dynamic second;

        switch (_sortIndex) {
          case 1:
            {
              first = a.getTotalScoreTeam(ref);
              second = b.getTotalScoreTeam(ref);
            }
          case 2:
            {
              first = a.getScoreOpponent();
              second = b.getScoreOpponent();
            }
          default:
            {
              first = a.getDate();
              second = b.getDate();
            }
        }

        return _sortAscending
            ? (first as Comparable?).compare(second as Comparable?)
            : (second as Comparable?).compare(first as Comparable?);
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
                headingRowHeight: Spacing.xl3,
                headingTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                columnSpacing: Spacing.xs,
                columns: [
                  DataColumn(
                    label: Text("Match (${matchs.length})"),
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : false;
                        _sortIndex = index;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("BP"),
                    numeric: true,
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : false;
                        _sortIndex = index;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("BC"),
                    numeric: true,
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : false;
                        _sortIndex = index;
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
                      DataCell(
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(match.getOpponent(ref).getName()),
                            Text(
                              match.getDate().formatWithTimeAndDay(),
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
                          match.getDate().hasPassed() ? match.getTotalScoreTeam(ref).toString() : "",
                          style: TextStyle(
                            color: match.resultColor(ref),
                            fontWeight: match.teamFontWeight(ref),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          match.getDate().hasPassed() ? match.getScoreOpponent().toString() : "",
                          style: TextStyle(
                            color: match.resultColor(ref),
                            fontWeight: match.opponentFontWeight(ref),
                          ),
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
        tooltip: "Ajouter un match",
        child: const Icon(Icons.add),
      ),
    );
  }
}
