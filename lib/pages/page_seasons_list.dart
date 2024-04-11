import "dart:async";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_season.dart";
import "package:footrack_front/components/generics/generic_error.dart";
import "package:footrack_front/components/generics/generic_loading.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/season.dart";
import "package:footrack_front/pages/page_season_dashboard.dart";

class SeasonsListPage extends ConsumerStatefulWidget {
  const SeasonsListPage({super.key});

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
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final version = ref.watch(packageInfoProvider)?.version;
    final seasonsStream = ref.watch(seasonsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vos saisons",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: Spacing.m),
        child: Column(
          children: [
            Expanded(
              child: seasonsStream.when(
                data: (seasons) {
                  return seasons.isEmpty
                      ? Center(
                          child: Text(
                            "Aucune saison",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
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
                              DataColumn(
                                label: Text(
                                  "Saison (${seasons.length})",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Matchs",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  "BP",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                numeric: true,
                              ),
                              DataColumn(
                                label: Text(
                                  "BC",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                numeric: true,
                              ),
                            ],
                            rows: List.of(seasons).map((season) {
                              return DataRow(
                                cells: [
                                  DataCell(seasonColumn(season)),
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
                                  _openSeason(season);
                                },
                                onLongPress: () {
                                  _editSeason(season);
                                },
                              );
                            }).toList(),
                          ),
                        );
                },
                error: (e, s) => Scaffold(body: GenericError(error: e)),
                loading: () => const Scaffold(body: GenericLoading()),
              ),
            ),
            if (version != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs2),
                child: Text(
                  "Version $version",
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            if (user != null)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs2),
                    child: Text(
                      "Connecté en tant que ${user.email}",
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs2),
                    child: ElevatedButton(
                      child: const Text("Déconnexion"),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        ref.read(userProvider.notifier).state = null;
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSeason,
        tooltip: "Créer une saison",
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
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 1,
        ),
        Text(
          "${season.getFrom().format()}${season.getTo() != null ? " - " : ""}${season.getTo().format()}",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
