import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/opponent_extension.dart";
import "package:footrack_front/models/match.dart";

class CalendarDatatable extends ConsumerStatefulWidget {
  const CalendarDatatable({
    super.key,
    required this.calendar,
    this.onMatchClick,
    this.onMatchLongClick,
  });

  final List<Match> calendar;
  final Function(Match)? onMatchClick;
  final Function(Match)? onMatchLongClick;

  @override
  ConsumerState<CalendarDatatable> createState() => _CalendarDatatableState();
}

class _CalendarDatatableState extends ConsumerState<CalendarDatatable> {
  bool _sortAscending = false;
  int _sortIndex = 0;

  @override
  Widget build(BuildContext context) {
    final calendar = widget.calendar
      ..sort((a, b) {
        dynamic first;
        dynamic second;

        switch (_sortIndex) {
          case 1:
            {
              first = a.getTotalScoreTeam(ref);
              second = b.getTotalScoreTeam(ref);
            }
          case 2:
            {
              first = a.getScoreOpponent();
              second = b.getScoreOpponent();
            }
          default:
            {
              first = a.getDate();
              second = b.getDate();
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
              "Match (${calendar.length})",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onSort: (index, sorted) {
              setState(() {
                _sortAscending = _sortIndex == index ? !_sortAscending : false;
                _sortIndex = index;
              });
            },
          ),
          DataColumn(
            label: Text(
              "BP",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            numeric: true,
            onSort: (index, sorted) {
              setState(() {
                _sortAscending = _sortIndex == index ? !_sortAscending : false;
                _sortIndex = index;
              });
            },
          ),
          DataColumn(
            label: Text(
              "BC",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            numeric: true,
            onSort: (index, sorted) {
              setState(() {
                _sortAscending = _sortIndex == index ? !_sortAscending : false;
                _sortIndex = index;
              });
            },
          ),
        ],
        rows: List.of(calendar).map((match) {
          return DataRow(
            cells: [
              DataCell(
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.getOpponent(ref).getName(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      match.getDate().formatLanguage(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              DataCell(
                Text(
                  match.getDate().hasPassed() ? match.getTotalScoreTeam(ref).toString() : "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: match.resultColor(ref),
                        fontWeight: match.teamFontWeight(ref),
                      ),
                ),
              ),
              DataCell(
                Text(
                  match.getDate().hasPassed() ? match.getScoreOpponent().toString() : "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: match.resultColor(ref),
                        fontWeight: match.opponentFontWeight(ref),
                      ),
                ),
              ),
            ],
            onSelectChanged: (selected) {
              widget.onMatchClick?.call(match);
            },
            onLongPress: () {
              widget.onMatchLongClick?.call(match);
            },
          );
        }).toList(),
      ),
    );
  }
}
