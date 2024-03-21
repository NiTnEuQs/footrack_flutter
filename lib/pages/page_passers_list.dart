import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/extensions/player_extension.dart';
import 'package:footrack_front/models/extensions/season_extension.dart';
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
      var seasonPassers = season.passers(ref);

      seasonPassers?.forEach((seasonPasser) {
        setState(() {
          _listPassers.add(
            Passer(
              player: seasonPasser.key,
              passes: seasonPasser.value,
            ),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _listPassers.sort((a, b) {
      dynamic first;
      dynamic second;

      switch (_sortIndex) {
        case 1:
          {
            first = a.player.getName();
            second = b.player.getName();
          }
        default:
          {
            first = a.passes;
            second = b.passes;
          }
      }

      return _sortAscending
          ? (first as Comparable?).compare(second as Comparable?)
          : (second as Comparable?).compare(first as Comparable?);
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
                headingRowHeight: Spacing.xl3,
                headingTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                columnSpacing: Spacing.xs,
                columns: [
                  DataColumn(
                    label: Text("Joueur (${_listPassers.length})"),
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : true;
                        _sortIndex = index;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Passes"),
                    numeric: true,
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : false;
                        _sortIndex = index;
                      });
                    },
                  ),
                ],
                rows: List.of(_listPassers).map((passer) {
                  return DataRow(
                    cells: [
                      DataCell(Text(passer.player.getName())),
                      DataCell(Text("${passer.passes}")),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
