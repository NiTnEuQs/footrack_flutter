import 'package:async/async.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/alert_season.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/pages/page_season_dashboard.dart';

class SeasonsListPage extends ConsumerStatefulWidget {
  const SeasonsListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeasonsListPageState();
}

class _SeasonsListPageState extends ConsumerState<SeasonsListPage> {
  void _addSeason() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSeason(ref: ref);
      },
    );
  }

  void _editSeason(Season season) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSeason(
          ref: ref,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saisons"),
      ),
      body: FirestoreBuilder(
        ref: seasonsRef.orderByFrom(descending: true),
        builder: (context, AsyncSnapshot<SeasonQuerySnapshot> seasonQuerySnapshot, Widget? child) {
          if (seasonQuerySnapshot.hasError) {
            debugPrint(seasonQuerySnapshot.error.toString());
            return const Center(child: Text('Erreur'));
          }

          if (!seasonQuerySnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = seasonQuerySnapshot.requireData.docs;

          return docs.isEmpty
              ? const Center(child: Text("Aucune saison"))
              : SingleChildScrollView(
                  child: DataTable(
                      showCheckboxColumn: false,
                      headingRowHeight: 35,
                      headingTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      columns: const [
                        DataColumn(label: Text("Saison")),
                        DataColumn(label: Text("Buts"), numeric: true),
                      ],
                      rows: List.of(docs).map((SeasonQueryDocumentSnapshot e) {
                        Season season = e.toModel();
                        var matchsRef = seasonsRef.doc(season.id).matchs;

                        return DataRow(
                          cells: [
                            DataCell(
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(season.name),
                                  Text(
                                    "${season.from.format()}${season.to != null ? " - " : ""}${season.to.format()}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            DataCell(
                              FirestoreBuilder(
                                ref: matchsRef,
                                builder: (context, AsyncSnapshot<MatchQuerySnapshot> matchQuerySnapshot, Widget? child) {
                                  if (matchQuerySnapshot.hasError) {
                                    debugPrint(matchQuerySnapshot.error.toString());
                                    return const Center(child: Text("Erreur"));
                                  }

                                  if (!matchQuerySnapshot.hasData) {
                                    return const Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  var matchDocs = matchQuerySnapshot.requireData.docs;

                                  if (matchDocs.isEmpty) return const Text("0");

                                  var goalsStream = StreamZip(matchDocs.map(
                                    (e) => e.reference.goals.snapshots(),
                                  ));

                                  return StreamBuilder(
                                    stream: goalsStream,
                                    builder: (context, AsyncSnapshot<List<GoalQuerySnapshot>> goalsQuerySnapshot) {
                                      if (goalsQuerySnapshot.hasError) {
                                        debugPrint(goalsQuerySnapshot.error.toString());
                                        return const Center(child: Text("Erreur"));
                                      }

                                      if (!goalsQuerySnapshot.hasData) {
                                        return const Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }

                                      int goals = 0;

                                      for (var goalQuerySnapshot in goalsQuerySnapshot.requireData) {
                                        goals += goalQuerySnapshot.docs.length;
                                      }

                                      return Text(goals.toString());
                                    },
                                  );
                                },
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
                      }).toList()),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSeason,
        tooltip: 'Créer une saison',
        child: const Icon(Icons.add),
      ),
    );
  }
}
