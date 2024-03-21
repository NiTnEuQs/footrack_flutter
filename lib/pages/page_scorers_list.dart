import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/extensions/player_extension.dart';
import 'package:footrack_front/models/extensions/season_extension.dart';
import 'package:footrack_front/pages/scorers/domain/models/scorer.dart';

class ScorersListPage extends ConsumerStatefulWidget {
  const ScorersListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScorersListPageState();
}

class _ScorersListPageState extends ConsumerState<ScorersListPage> {
  bool _sortAscending = false;
  int _sortIndex = 1;
  final List<Scorer> _listScorers = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var season = ref.watch(seasonChoseProvider);
      var seasonScorers = season.scorers(ref);

      seasonScorers?.forEach((seasonScorer) {
        setState(() {
          _listScorers.add(
            Scorer(
              player: seasonScorer.key,
              goals: seasonScorer.value,
            ),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _listScorers.sort((a, b) {
      dynamic first;
      dynamic second;

      switch (_sortIndex) {
        case 0:
          {
            first = a.player.getName();
            second = b.player.getName();
          }
        default:
          {
            first = a.goals;
            second = b.goals;
          }
      }

      return _sortAscending
          ? (first as Comparable?).compare(second as Comparable?)
          : (second as Comparable?).compare(first as Comparable?);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buteurs"),
      ),
      body: _listScorers.isEmpty
          ? const Center(child: Text("Aucun buteur"))
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
                    label: Text("Joueur (${_listScorers.length})"),
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : true;
                        _sortIndex = index;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Buts"),
                    numeric: true,
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : false;
                        _sortIndex = index;
                      });
                    },
                  ),
                ],
                rows: List.of(_listScorers).map((scorer) {
                  return DataRow(
                    cells: [
                      DataCell(Text(scorer.player.getName())),
                      DataCell(Text("${scorer.goals}")),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
