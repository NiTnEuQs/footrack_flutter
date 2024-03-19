import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_squad_player.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:footrack_front/enums/player_status_enum.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/squad_player.dart';

class MatchSquadPage extends ConsumerStatefulWidget {
  const MatchSquadPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchSquadPageState();
}

class _MatchSquadPageState extends ConsumerState<MatchSquadPage> {
  bool _sortAscending = false;
  int _sortIndex = 0;

  void _addSquadPlayer() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSquadPlayer(ref: ref);
      },
    );
  }

  void _editSquadPlayer(SquadPlayer player) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSquadPlayer(
          ref: ref,
          squadPlayer: player,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var match = ref.watch(matchChoseProvider);
    var squad = match != null ? ref.watch(match.squadProvider) : <SquadPlayer>[]
      ..sort((e1, e2) {
        dynamic player1;
        dynamic player2;

        switch (_sortIndex) {
          case 1:
            {
              player1 = ref.watch(e1.playerProvider)?.birthdate?.toDateTime();
              player2 = ref.watch(e2.playerProvider)?.birthdate?.toDateTime();
            }
          case 2:
            {
              player1 = ref.watch(e1.playerProvider)?.getStatus().format();
              player2 = ref.watch(e2.playerProvider)?.getStatus().format();
            }
          case 3:
            {
              player1 = ref.watch(e1.playerProvider)?.getRole().format();
              player2 = ref.watch(e2.playerProvider)?.getRole().format();
            }
          default:
            {
              player1 = ref.watch(e1.playerProvider)?.getName();
              player2 = ref.watch(e2.playerProvider)?.getName();
            }
        }

        return (_sortAscending
            ? (player2 as Comparable?).compare(player1 as Comparable?)
            : (player1 as Comparable?).compare(player2 as Comparable?));
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Votre effectif"),
      ),
      body: squad.isEmpty
          ? const Center(child: Text("Aucun joueur"))
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
                  DataColumn(
                    label: Text("Joueur (${squad.length})"),
                    onSort: (index, sorted) {
                      int columnIndex = 0;
                      setState(() {
                        _sortAscending = _sortIndex == columnIndex ? !_sortAscending : false;
                        _sortIndex = columnIndex;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Naissance"),
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
                    label: const Text("Status"),
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
                    label: const Text("Rôle"),
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
                rows: List.of(squad).map((squadPlayer) {
                  var player = ref.watch(squadPlayer.playerProvider);

                  if (player == null) {
                    return const DataRow(
                      cells: [
                        DataCell(Text("Une erreur est survenue")),
                        DataCell(Text("")),
                        DataCell(Text("")),
                        DataCell(Text("")),
                      ],
                    );
                  }

                  return DataRow(
                    cells: [
                      DataCell(Text(player.getName())),
                      DataCell(Text(player.birthdate.toDateTime().format())),
                      DataCell(player.getStatus().icon()),
                      DataCell(player.getRole().icon()),
                    ],
                    onLongPress: () {
                      _editSquadPlayer(squadPlayer);
                    },
                  );
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSquadPlayer,
        tooltip: 'Ajouter un joueur',
        child: const Icon(Icons.add),
      ),
    );
  }
}
