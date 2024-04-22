import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/season.dart";

class SeasonsDatatable extends ConsumerWidget {
  const SeasonsDatatable({
    super.key,
    required this.seasons,
    this.onSeasonClick,
    this.onSeasonLongClick,
  });

  final List<Season> seasons;
  final Function(Season)? onSeasonClick;
  final Function(Season)? onSeasonLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: DataTable(
        showCheckboxColumn: false,
        headingRowHeight: 35,
        headingTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        columnSpacing: 8,
        columns: [
          DataColumn(
            label: Text(
              "Saison (${seasons.length})",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          DataColumn(
            label: Text(
              "Matchs",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              "BP",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              "BC",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            numeric: true,
          ),
        ],
        rows: List.of(seasons).map((season) {
          return DataRow(
            cells: [
              DataCell(
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      season.getName(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                    ),
                    Text(
                      "${season.getFrom().format()}${season.getTo() != null ? " - " : ""}${season.getTo().format()}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              DataCell(
                Text(
                  "${season.nbPlayedMatchs(ref)}/${season.nbMatches(ref)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              DataCell(
                Text(
                  season.nbGoalsFor(ref).toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              DataCell(
                Text(
                  season.nbGoalsAgainst(ref).toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            onSelectChanged: (selected) {
              onSeasonClick?.call(season);
            },
            onLongPress: () {
              onSeasonLongClick?.call(season);
            },
          );
        }).toList(),
      ),
    );
  }
}
