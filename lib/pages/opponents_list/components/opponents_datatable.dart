import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/opponent_extension.dart";
import "package:footrack_front/models/opponent.dart";

class OpponentsDatatable extends ConsumerStatefulWidget {
  const OpponentsDatatable({
    super.key,
    required this.opponents,
    this.onOpponentClick,
    this.onOpponentLongClick,
  });

  final List<Opponent> opponents;
  final Function(Opponent)? onOpponentClick;
  final Function(Opponent)? onOpponentLongClick;

  @override
  ConsumerState<OpponentsDatatable> createState() => _OpponentsDatatableState();
}

class _OpponentsDatatableState extends ConsumerState<OpponentsDatatable> {
  bool _sortAscending = true;
  int _sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    final opponents = widget.opponents
      ..sort((a, b) {
        dynamic first = a.getName();
        dynamic second = b.getName();

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
              "Adversaire (${opponents.length})",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onSort: (index, sorted) {
              setState(() {
                _sortAscending = _sortIndex == index ? !_sortAscending : true;
                _sortIndex = index;
              });
            },
          ),
        ],
        rows: List.of(opponents).map((opponent) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  opponent.getName(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            onSelectChanged: (selected) {
              widget.onOpponentClick?.call(opponent);
            },
            onLongPress: () {
              widget.onOpponentLongClick?.call(opponent);
            },
          );
        }).toList(),
      ),
    );
  }
}
