import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/squad_player_extension.dart";
import "package:footrack_front/models/squad_player.dart";

class SquadDatatable extends ConsumerStatefulWidget {
  const SquadDatatable({
    super.key,
    required this.squad,
    this.onPlayerClick,
    this.onPlayerLongClick,
  });

  final List<SquadPlayer> squad;
  final Function(SquadPlayer)? onPlayerClick;
  final Function(SquadPlayer)? onPlayerLongClick;

  @override
  ConsumerState<SquadDatatable> createState() => _SquadDatatableState();
}

class _SquadDatatableState extends ConsumerState<SquadDatatable> {
  bool _sortAscending = true;
  int _sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    final squad = widget.squad
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

    return SingleChildScrollView(
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
            label: Text(
              "Joueur (${squad.length})",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onSort: (index, sorted) {
              setState(() {
                _sortAscending = _sortIndex == index ? !_sortAscending : true;
                _sortIndex = index;
              });
            },
          ),
          DataColumn(
            label: Text(
              "Naissance",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            numeric: true,
            onSort: (index, sorted) {
              setState(() {
                _sortAscending = _sortIndex == index ? !_sortAscending : true;
                _sortIndex = index;
              });
            },
          ),
          DataColumn(
            label: Text(
              "Status",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            numeric: true,
            onSort: (index, sorted) {
              setState(() {
                _sortAscending = _sortIndex == index ? !_sortAscending : true;
                _sortIndex = index;
              });
            },
          ),
          DataColumn(
            label: Text(
              "Rôle",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
              DataCell(
                Text(
                  player.getName(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              DataCell(
                Text(
                  player.getBirthDate().format(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              DataCell(player.getStatus().icon()),
              DataCell(player.getRole().icon()),
            ],
            onSelectChanged: (selected) {
              widget.onPlayerClick?.call(squadPlayer);
            },
            onLongPress: () {
              widget.onPlayerLongClick?.call(squadPlayer);
            } /*.takeIf(
              account.isAdminInCurrentClub(ref) || !match.getDate().hasPassed(add: const Duration(hours: 2)),
            )*/
            ,
          );
        }).toList(),
      ),
    );
  }
}
