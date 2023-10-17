import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/models/player.dart';
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
      var seasonScorers = season?.scorers(ref);

      seasonScorers?.forEach((seasonScorer) {
        firestoreInstance.doc(seasonScorer.key!.path).get().then(
          (data) {
            var scorer = Player(snapshot: data);

            setState(() {
              _listScorers.add(
                Scorer(
                  player: scorer,
                  goals: seasonScorer.value,
                ),
              );
            });
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _listScorers.sort((e1, e2) {
      switch (_sortIndex) {
        case 0:
          {
            var e1Name = e1.player?.getName() ?? "";
            var e2Name = e2.player?.getName() ?? "";

            return _sortAscending ? e1Name.compareTo(e2Name) : e2Name.compareTo(e1Name);
          }
        default:
          {
            var e1Goals = e1.goals ?? 0;
            var e2Goals = e2.goals ?? 0;

            return _sortAscending ? e1Goals.compareTo(e2Goals) : e2Goals.compareTo(e1Goals);
          }
      }
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
                headingRowHeight: 35,
                headingTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                columnSpacing: 16,
                columns: [
                  DataColumn(
                    label: Text("Joueur (${_listScorers.length})"),
                    onSort: (index, sorted) {
                      int columnIndex = 0;
                      setState(() {
                        _sortAscending = _sortIndex == columnIndex ? !_sortAscending : true;
                        _sortIndex = columnIndex;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Buts"),
                    numeric: true,
                    onSort: (index, sorted) {
                      int columnIndex = 1;
                      setState(() {
                        _sortAscending = _sortIndex == columnIndex ? !_sortAscending : false;
                        _sortIndex = columnIndex;
                      });
                    },
                  ),
                ],
                rows: List.of(_listScorers).map((scorer) {
                  return DataRow(
                    cells: [
                      DataCell(Text(scorer.player?.getName() ?? "")),
                      DataCell(Text(scorer.goals.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
