import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/pages/passers/domain/models/passer.dart';

class PassersListPage extends ConsumerStatefulWidget {
  const PassersListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PassersListPageState();
}

class _PassersListPageState extends ConsumerState<PassersListPage> {
  bool _sortAscending = false;
  int _sortIndex = 1;
  final List<Passer> _listPassers = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var season = ref.watch(seasonChoseProvider);
      var seasonPassers = season?.passers(ref);

      seasonPassers?.forEach((seasonPasser) {
        firestoreInstance.doc(seasonPasser.key!.path).get().then(
          (data) {
            var passer = Player(snapshot: data);

            setState(() {
              _listPassers.add(
                Passer(
                  player: passer,
                  passes: seasonPasser.value,
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
    _listPassers.sort((e1, e2) {
      switch (_sortIndex) {
        case 0:
          {
            var e1Name = e1.player?.getName() ?? "";
            var e2Name = e2.player?.getName() ?? "";

            return _sortAscending ? e1Name.compareTo(e2Name) : e2Name.compareTo(e1Name);
          }
        default:
          {
            var e1Goals = e1.passes ?? 0;
            var e2Goals = e2.passes ?? 0;

            return _sortAscending ? e1Goals.compareTo(e2Goals) : e2Goals.compareTo(e1Goals);
          }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Passeurs"),
      ),
      body: _listPassers.isEmpty
          ? const Center(child: Text("Aucun passeur"))
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
                    label: Text("Joueur (${_listPassers.length})"),
                    onSort: (index, sorted) {
                      int columnIndex = 0;
                      setState(() {
                        _sortAscending = _sortIndex == columnIndex ? !_sortAscending : true;
                        _sortIndex = columnIndex;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Passes"),
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
                rows: List.of(_listPassers).map((passer) {
                  return DataRow(
                    cells: [
                      DataCell(Text(passer.player?.getName() ?? "")),
                      DataCell(Text(passer.passes.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
