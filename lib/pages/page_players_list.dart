import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_player.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/player.dart";

class PlayersListPage extends ConsumerStatefulWidget {
  const PlayersListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayersListPageState();
}

class _PlayersListPageState extends ConsumerState<PlayersListPage> {
  bool _sortAscending = true;
  int _sortIndex = 0;

  void _addPlayer() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertPlayer();
      },
    );
  }

  void _editPlayer(Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertPlayer(
          player: player,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var players = season.getPlayers(ref)
      ..sort((a, b) {
        dynamic first;
        dynamic second;

        switch (_sortIndex) {
          case 1:
            {
              first = a.getBirthDate();
              second = b.getBirthDate();
            }
          case 2:
            {
              first = a.getStatus().index;
              second = b.getStatus().index;
            }
          case 3:
            {
              first = a.getRole().index;
              second = b.getRole().index;
            }
          default:
            {
              first = a.getName();
              second = b.getName();
            }
        }

        return _sortAscending
            ? (first as Comparable?).compare(second as Comparable?)
            : (second as Comparable?).compare(first as Comparable?);
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vos joueurs"),
      ),
      body: players.isEmpty
          ? const Center(child: Text("Aucun joueur"))
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
                    label: Text("Joueur (${players.length})"),
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : true;
                        _sortIndex = index;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Naissance"),
                    numeric: true,
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : true;
                        _sortIndex = index;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Status"),
                    numeric: true,
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : true;
                        _sortIndex = index;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Rôle"),
                    numeric: true,
                    onSort: (index, sorted) {
                      setState(() {
                        _sortAscending = _sortIndex == index ? !_sortAscending : true;
                        _sortIndex = index;
                      });
                    },
                  ),
                ],
                rows: List.of(players).map((player) {
                  return DataRow(
                    cells: [
                      DataCell(Text(player.getName())),
                      DataCell(Text(player.getBirthDate().format())),
                      DataCell(player.getStatus().icon()),
                      DataCell(player.getRole().icon()),
                    ],
                    onLongPress: () {
                      _editPlayer(player);
                    },
                  );
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPlayer,
        label: const Text("Ajouter un joueur"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
