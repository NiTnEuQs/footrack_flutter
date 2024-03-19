import 'dart:async';

import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_season.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/managers/package_manager.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/pages/page_season_dashboard.dart';

class SeasonsListPage extends ConsumerStatefulWidget {
  const SeasonsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeasonsListPageState();
}

class _SeasonsListPageState extends ConsumerState<SeasonsListPage> {
  late StreamSubscription disposeSeasons;

  void _addSeason() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertSeason();
      },
    );
  }

  void _editSeason(Season season) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSeason(
          season: season,
        );
      },
    );
  }

  void _openSeason(Season season) {
    ref.read(seasonChoseProvider.notifier).state = season;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SeasonDashboardPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    disposeSeasons = firestoreInstance.collection("seasons").snapshots().listen((snap) {
      ref.read(seasonsProvider.notifier).state = snap.docs.map((e) => Season(snapshot: e, ref: ref)).toList();
    });
  }

  @override
  void dispose() {
    disposeSeasons.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var version = PackageManager.packageInfo.version;
    var seasons = ref.watch(seasonsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vos saisons"),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            Expanded(
              child: seasons.isEmpty
                  ? const Center(child: Text("Aucune saison"))
                  : SingleChildScrollView(
                      child: DataTable(
                          showCheckboxColumn: false,
                          headingRowHeight: 35,
                          headingTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          columnSpacing: 8,
                          columns: [
                            DataColumn(label: Text("Saison (${seasons.length})")),
                            const DataColumn(label: Text("Matchs"), numeric: true),
                            const DataColumn(label: Text("BP"), numeric: true),
                            const DataColumn(label: Text("BC"), numeric: true),
                          ],
                          rows: List.of(seasons).map((season) {
                            return DataRow(
                              cells: [
                                DataCell(seasonColumn(season)),
                                DataCell(Text("${season.nbPlayedMatchs(ref)}/${season.nbMatches(ref)}")),
                                DataCell(Text(season.nbGoalsFor(ref).toString())),
                                DataCell(Text(season.nbGoalsAgainst(ref).toString())),
                              ],
                              onSelectChanged: (selected) {
                                _openSeason(season);
                              },
                              onLongPress: () {
                                _editSeason(season);
                              },
                            );
                          }).toList()),
                    ),
            ),
            Text(
              "Version $version",
              style: const TextStyle(color: Colors.black45),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSeason,
        tooltip: 'Créer une saison',
        child: const Icon(Icons.add),
      ),
    );
  }

  Column seasonColumn(Season season) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          season.getName(),
          style: const TextStyle(
            overflow: TextOverflow.clip,
          ),
        ),
        Text(
          "${season.from.toDateTime().format()}${season.to != null ? " - " : ""}${season.to.toDateTime().format()}",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
