import 'package:flutter/material.dart';
import 'package:footrack_front/models/opponent.dart';

class OpponentsListBodyFilled extends StatefulWidget {
  const OpponentsListBodyFilled({
    super.key,
    required this.opponents,
    this.onOpponentLongPress,
  });

  final List<Opponent> opponents;
  final Function(Opponent)? onOpponentLongPress;

  @override
  State<OpponentsListBodyFilled> createState() => _OpponentsListBodyFilledState();
}

class _OpponentsListBodyFilledState extends State<OpponentsListBodyFilled> {
  bool _sortAscending = false;
  int _sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    widget.opponents.sort((e1, e2) {
      switch (_sortIndex) {
        case 0:
          {
            return (_sortAscending ? e2.getName().compareTo(e1.getName()) : e1.getName().compareTo(e2.getName()));
          }
        default:
          return e1.getName().compareTo(e2.getName());
      }
    });

    return SingleChildScrollView(
      child: DataTable(
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
              label: Text("Adversaire (${widget.opponents.length})"),
              onSort: (index, sorted) {
                setState(() {
                  _sortAscending = _sortIndex == 0 ? !_sortAscending : false;
                  _sortIndex = 0;
                });
              },
            ),
          ],
          rows: List.of(widget.opponents).map((opponent) {
            return DataRow(
              cells: [
                DataCell(Text(opponent.getName())),
              ],
              onLongPress: () {
                widget.onOpponentLongPress?.call(opponent);
              },
            );
          }).toList()),
    );
  }
}
