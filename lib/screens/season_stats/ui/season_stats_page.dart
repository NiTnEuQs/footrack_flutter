import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/tiles/tile_stat.dart';
import 'package:footrack_front/database/global_providers.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/screens/passers_list/ui/passers_list_page.dart';
import 'package:footrack_front/screens/scorers_list/ui/scorers_list_page.dart';

class StatsPage extends ConsumerStatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatsPageState();
}

class _StatsPageState extends ConsumerState<StatsPage> {
  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonProvider);
    var seasonBestScorer = season.bestScorer(ref);
    var seasonBestPasser = season.bestPasser(ref);
    var lastPlayedMatchs = season.lastPlayedMatchs(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            !lastPlayedMatchs.isNotEmpty ? "Stats" : "Stats au ${lastPlayedMatchs.first.date.toDateTime().format()}"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          StatTile(
            icon: const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 40,
            ),
            value: "${season.winsPercent(ref).toStringAsFixed(0)}%",
            title: "de victoires",
            subtitle: "${season.nbWins(ref)} victoires sur ${season.nbPlayedMatchs(ref)} matchs",
          ),
          StatTile(
            icon: const Icon(
              Icons.plus_one_outlined,
              color: Colors.blue,
              size: 40,
            ),
            value: "${season.pointsPercent(ref).toStringAsFixed(0)}%",
            title: "de points pris",
            subtitle: "${season.nbPoints(ref)} points sur ${season.nbMaxPoints(ref)} possibles",
          ),
          StatTile(
            icon: const Icon(
              Icons.sports_soccer,
              color: Colors.lightGreen,
              size: 40,
            ),
            value: season.goalsForRatio(ref).toStringAsFixed(2),
            title: "buts mis/match",
            subtitle: "${season.nbGoalsFor(ref)} buts en ${season.nbPlayedMatchs(ref)} matchs",
          ),
          StatTile(
            icon: const Icon(
              Icons.sports_soccer,
              color: Colors.red,
              size: 40,
            ),
            value: season.goalsAgainstRatio(ref).toStringAsFixed(2),
            title: "buts pris/match",
            subtitle: "${season.nbGoalsAgainst(ref)} buts en ${season.nbPlayedMatchs(ref)} matchs",
          ),
          if (seasonBestScorer?.key != null)
            FutureBuilder(
                future: firestoreInstance.doc(seasonBestScorer!.key!.path).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
                  var bestScorer = Player(snapshot: snap.data);

                  return StatTile(
                    icon: const Icon(
                      Icons.sports_soccer,
                      color: Colors.amber,
                      size: 40,
                    ),
                    value: "${bestScorer.name}",
                    valueSize: 30,
                    title: "meilleur buteur",
                    subtitle: "avec ${seasonBestScorer.value} buts",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScorersListPage(),
                        ),
                      );
                    },
                  );
                }),
          if (seasonBestPasser?.key != null)
            FutureBuilder(
                future: firestoreInstance.doc(seasonBestPasser!.key!.path).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snap) {
                  var bestPasser = Player(snapshot: snap.data);

                  return StatTile(
                    icon: const Icon(
                      Icons.auto_awesome,
                      color: Colors.purpleAccent,
                      size: 40,
                    ),
                    value: "${bestPasser.name}",
                    valueSize: 30,
                    title: "meilleur passeur",
                    subtitle: "avec ${seasonBestPasser.value} passes",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PassersListPage(),
                        ),
                      );
                    },
                  );
                }),
        ],
      ),
    );
  }
}
