import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_squad_player.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/account_extension.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/squad_player_extension.dart";
import "package:footrack_front/models/squad_player.dart";

class MatchSquadPage extends ConsumerStatefulWidget {
  const MatchSquadPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchSquadPageState();
}

class _MatchSquadPageState extends ConsumerState<MatchSquadPage> {
  bool _sortAscending = true;
  int _sortIndex = 0;

  void _addSquadPlayer() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertSquadPlayer();
      },
    );
  }

  void _editSquadPlayer(SquadPlayer player) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSquadPlayer(
          squadPlayer: player,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var account = ref.watch(accountProvider);
    var match = ref.watch(matchChoseProvider);
    var squad = match.getSquad(ref)
      ..sort((a, b) {
        dynamic first;
        dynamic second;

        switch (_sortIndex) {
          case 1:
            {
              first = a.getPlayer(ref).getBirthDate();
              second = b.getPlayer(ref).getBirthDate();
            }
          case 2:
            {
              first = a.getPlayer(ref).getStatus().index;
              second = b.getPlayer(ref).getStatus().index;
            }
          case 3:
            {
              first = a.getPlayer(ref).getRole().index;
              second = b.getPlayer(ref).getRole().index;
            }
          default:
            {
              first = a.getPlayer(ref).getName();
              second = b.getPlayer(ref).getName();
            }
        }

        return _sortAscending
            ? (first as Comparable?).compare(second as Comparable?)
            : (second as Comparable?).compare(first as Comparable?);
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
                headingRowHeight: Spacing.xl3,
                headingTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                columnSpacing: Spacing.xs,
                columns: [
                  DataColumn(
                    label: Text("Joueur (${squad.length})"),
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
                rows: List.of(squad).map((squadPlayer) {
                  var player = squadPlayer.getPlayer(ref);

                  return DataRow(
                    cells: [
                      DataCell(Text(player.getName())),
                      DataCell(Text(player.getBirthDate().format())),
                      DataCell(player.getStatus().icon()),
                      DataCell(player.getRole().icon()),
                    ],
                    onLongPress: () {
                      _editSquadPlayer(squadPlayer);
                    }.takeIf(
                      account.isAdminInCurrentClub(ref) || !match.getDate().hasPassed(add: const Duration(hours: 2)),
                    ),
                  );
                }).toList(),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSquadPlayer,
        label: const Text("Ajouter un joueur"),
        icon: const Icon(Icons.add),
      ).takeIf(
        account.isAdminInCurrentClub(ref) || !match.getDate().hasPassed(add: const Duration(hours: 2)),
      ),
    );
  }
}
