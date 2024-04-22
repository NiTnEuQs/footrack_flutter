import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/player.dart";

class PlayersDatatable extends ConsumerStatefulWidget {
  const PlayersDatatable({
    super.key,
    required this.players,
    this.onPlayerClick,
    this.onPlayerLongClick,
  });

  final List<Player> players;
  final Function(Player)? onPlayerClick;
  final Function(Player)? onPlayerLongClick;

  @override
  ConsumerState<PlayersDatatable> createState() => _PlayersDatatableState();
}

class _PlayersDatatableState extends ConsumerState<PlayersDatatable> {
  bool _sortAscending = true;
  int _sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    final players = widget.players
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
              "Joueur (${players.length})",
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
        rows: List.of(players).map((player) {
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
              widget.onPlayerClick?.call(player);
            },
            onLongPress: () {
              widget.onPlayerLongClick?.call(player);
            },
          );
        }).toList(),
      ),
    );
  }
}
