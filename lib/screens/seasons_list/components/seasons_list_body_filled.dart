import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/season.dart';

class SeasonsListBodyFilled extends ConsumerStatefulWidget {
  const SeasonsListBodyFilled({
    super.key,
    required this.seasons,
    this.onSelectChanged,
    this.onLongPressed,
  });

  final List<Season> seasons;
  final Function(Season)? onSelectChanged;
  final Function(Season)? onLongPressed;

  @override
  ConsumerState<SeasonsListBodyFilled> createState() => _SeasonsListBodyFilledState();
}

class _SeasonsListBodyFilledState extends ConsumerState<SeasonsListBodyFilled> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
          showCheckboxColumn: false,
          headingRowHeight: 35,
          headingTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          columnSpacing: 16,
          columns: [
            DataColumn(label: Text("Saison (${widget.seasons.length})")),
            const DataColumn(label: Text(""), numeric: true),
            // const DataColumn(label: Text("Matchs"), numeric: true),
            // const DataColumn(label: Text("BP"), numeric: true),
            // const DataColumn(label: Text("BC"), numeric: true),
          ],
          rows: List.of(widget.seasons).map(
            (season) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      season.getName(),
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      season.isInProgress() ? "En cours" : "",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // DataCell(Text("${season.nbPlayedMatchs(ref)}/${season.nbMatchs(ref)}")),
                  // DataCell(Text(season.nbGoalsFor(ref).toString())),
                  // DataCell(Text(season.nbGoalsAgainst(ref).toString())),
                ],
                onSelectChanged: (selected) {
                  widget.onSelectChanged?.call(season);
                },
                onLongPress: () {
                  widget.onLongPressed?.call(season);
                },
              );
            },
          ).toList()),
    );
  }
}
