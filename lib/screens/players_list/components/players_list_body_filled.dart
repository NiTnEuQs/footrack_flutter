import 'package:flutter/material.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:footrack_front/enums/player_status_enum.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/player.dart';

class PlayersListBodyFilled extends StatefulWidget {
  const PlayersListBodyFilled({
    super.key,
    required this.players,
    this.onPlayerLongPress,
  });

  final List<Player> players;
  final Function(Player)? onPlayerLongPress;

  @override
  State<PlayersListBodyFilled> createState() => _PlayersListBodyFilledState();
}

class _PlayersListBodyFilledState extends State<PlayersListBodyFilled> {
  bool _sortAscending = false;
  int _sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.players.sort((e1, e2) {
      switch (_sortIndex) {
        case 0:
          {
            return (_sortAscending ? e2.getName().compareTo(e1.getName()) : e1.getName().compareTo(e2.getName()));
          }
        case 1:
          {
            var birthday1 = e1.birthdate?.toDateTime() ?? DateTime(1970);
            var birthday2 = e2.birthdate?.toDateTime() ?? DateTime(1970);
            return (_sortAscending ? birthday2.compareTo(birthday1) : birthday1.compareTo(birthday2));
          }
        case 2:
          {
            return (_sortAscending
                ? e2.getStatus().format().compareTo(e1.getStatus().format())
                : e1.getStatus().format().compareTo(e2.getStatus().format()));
          }
        case 3:
          {
            return (_sortAscending
                ? e2.getRole().format().compareTo(e1.getRole().format())
                : e1.getRole().format().compareTo(e2.getRole().format()));
          }
        default:
          return e1.getName().compareTo(e2.getName());
      }
    });

    return SingleChildScrollView(
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
            label: Text("Joueur (${widget.players.length})"),
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
        rows: List.of(widget.players).map((player) {
          return DataRow(
            cells: [
              DataCell(Text(player.getName())),
              DataCell(Text(player.birthdate.toDateTime().format())),
              DataCell(player.getStatus().icon()),
              DataCell(player.getRole().icon()),
            ],
            onLongPress: () {
              widget.onPlayerLongPress?.call(player);
            },
          );
        }).toList(),
      ),
    );
  }
}
