import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/ft_stat_tile.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/pages/page_passers_list.dart";
import "package:footrack_front/pages/page_scorers_list.dart";

class StatsPage extends ConsumerStatefulWidget {
  const StatsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatsPageState();
}

class _StatsPageState extends ConsumerState<StatsPage> {
  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var seasonBestScorer = season.bestScorer(ref);
    var seasonBestPasser = season.bestPasser(ref);
    var lastPlayedMatches = season.lastPlayedMatches(ref);

    var hasStats = season != null && lastPlayedMatches.isNotEmpty;

    var bestScorer = seasonBestScorer?.key;
    var bestScorerGoals = seasonBestScorer?.value;
    var bestPasser = seasonBestPasser?.key;
    var bestPasserPasses = seasonBestPasser?.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          !hasStats ? "Stats" : "Stats au ${lastPlayedMatches.firstOrNull.getDate().format()}",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: season == null
          ? Center(
              child: Text(
                "Stats non disponibles",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: [
                FTStatTile(
                  icon: const Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 40,
                  ),
                  value: "${season.winsPercent(ref).toStringAsFixed(0)}%",
                  title: "de victoires",
                  subtitle: "${season.nbWins(ref)} victoires sur ${season.nbPlayedMatchs(ref)} matchs",
                ),
                FTStatTile(
                  icon: const Icon(
                    Icons.plus_one_outlined,
                    color: Colors.blue,
                    size: 40,
                  ),
                  value: "${season.pointsPercent(ref).toStringAsFixed(0)}%",
                  title: "de points pris",
                  subtitle: "${season.nbPoints(ref)} points sur ${season.nbMaxPoints(ref)} possibles",
                ),
                FTStatTile(
                  icon: const Icon(
                    Icons.sports_soccer,
                    color: Colors.lightGreen,
                    size: 40,
                  ),
                  value: season.goalsForRatio(ref).toStringAsFixed(2),
                  title: "buts mis/match",
                  subtitle: "${season.nbGoalsFor(ref)} buts en ${season.nbPlayedMatchs(ref)} matchs",
                ),
                FTStatTile(
                  icon: const Icon(
                    Icons.sports_soccer,
                    color: Colors.red,
                    size: 40,
                  ),
                  value: season.goalsAgainstRatio(ref).toStringAsFixed(2),
                  title: "buts pris/match",
                  subtitle: "${season.nbGoalsAgainst(ref)} buts en ${season.nbPlayedMatchs(ref)} matchs",
                ),
                if (bestScorer != null && bestScorerGoals != null)
                  FTStatTile(
                    icon: const Icon(
                      Icons.sports_soccer,
                      color: Colors.amber,
                      size: 40,
                    ),
                    value: bestScorer.getName(defaultValue: "-"),
                    valueSize: 30,
                    title: "meilleur buteur",
                    subtitle: "avec $bestScorerGoals buts",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScorersListPage(),
                        ),
                      );
                    },
                  ),
                if (bestPasser != null && bestPasserPasses != null)
                  FTStatTile(
                    icon: const Icon(
                      Icons.auto_awesome,
                      color: Colors.purpleAccent,
                      size: 40,
                    ),
                    value: bestPasser.getName(),
                    valueSize: 30,
                    title: "meilleur passeur",
                    subtitle: "avec $bestPasserPasses passes",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PassersListPage(),
                        ),
                      );
                    },
                  ),
              ],
            ),
    );
  }
}
