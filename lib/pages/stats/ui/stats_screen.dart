import "package:flutter/material.dart";
import "package:flutter_layout_grid/flutter_layout_grid.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/app/modifiers.dart";
import "package:footrack_front/components/ft_stat_tile.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/pages/ranking_passers/ui/ranking_passers_screen.dart";
import "package:footrack_front/pages/ranking_scorers/ui/ranking_scorers_screen.dart";

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
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

    return season == null
        ? Text(
            "Stats non disponibles",
            style: Theme.of(context).textTheme.bodyMedium,
          ).centered()
        : Column(
            spacing: Spacing.xs3,
            children: [
              Text(
                !hasStats
                    ? "Stats"
                    : "Stats arrêtées au ${lastPlayedMatches.firstOrNull.getDate().format()}",
                style: Theme.of(context).textTheme.bodyMedium,
              ).padding(EdgeInsets.symmetric(vertical: Spacing.xs)),
              LayoutGrid(
                columnSizes: [1.fr, 1.fr],
                rowSizes: const [auto, auto],
                columnGap: Spacing.xs3,
                rowGap: Spacing.xs3,
                children: [
                  FTStatTile(
                    icon: const Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                      size: 40,
                    ),
                    value: "${season.winsPercent(ref).toStringAsFixed(0)}%",
                    title: "de victoires",
                    subtitle:
                        "${season.nbWins(ref)} victoires sur ${season.nbPlayedMatchs(ref)} matchs",
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ).fillMaxWidth().clipRRect(
                        BorderRadius.only(
                          topLeft: Radius.circular(Spacing.m),
                        ),
                      ),
                  FTStatTile(
                    icon: const Icon(
                      Icons.plus_one_outlined,
                      color: Colors.blue,
                      size: 40,
                    ),
                    value: "${season.pointsPercent(ref).toStringAsFixed(0)}%",
                    title: "de points pris",
                    subtitle:
                        "${season.nbPoints(ref)} points sur ${season.nbMaxPoints(ref)} possibles",
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ).fillMaxWidth().clipRRect(
                        BorderRadius.only(
                          topRight: Radius.circular(Spacing.m),
                        ),
                      ),
                  FTStatTile(
                    icon: const Icon(
                      Icons.sports_soccer,
                      color: Colors.lightGreen,
                      size: 40,
                    ),
                    value: season.goalsForRatio(ref).toStringAsFixed(2),
                    title: "buts mis/match",
                    subtitle:
                        "${season.nbGoalsFor(ref)} buts en ${season.nbPlayedMatchs(ref)} matchs",
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ).fillMaxWidth(),
                  FTStatTile(
                    icon: const Icon(
                      Icons.sports_soccer,
                      color: Colors.red,
                      size: 40,
                    ),
                    value: season.goalsAgainstRatio(ref).toStringAsFixed(2),
                    title: "buts pris/match",
                    subtitle:
                        "${season.nbGoalsAgainst(ref)} buts en ${season.nbPlayedMatchs(ref)} matchs",
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainer,
                  ).fillMaxWidth(),
                ],
              ),
              if (bestScorer != null && bestScorerGoals != null)
                FTStatTile(
                  icon: const Icon(
                    Icons.sports_soccer,
                    color: Colors.amber,
                    size: 40,
                  ),
                  value: bestScorer.getName(defaultValue: "-"),
                  title: "meilleur buteur",
                  subtitle: "avec $bestScorerGoals buts",
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainer,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RankingScorersScreen(),
                      ),
                    );
                  },
                ).fillMaxWidth(),
              if (bestPasser != null && bestPasserPasses != null)
                FTStatTile(
                  icon: const Icon(
                    Icons.auto_awesome,
                    color: Colors.purpleAccent,
                    size: 40,
                  ),
                  value: bestPasser.getName(),
                  title: "meilleur passeur",
                  subtitle: "avec $bestPasserPasses passes",
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainer,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RankingPassersScreen(),
                      ),
                    );
                  },
                ).fillMaxWidth().clipRRect(
                      BorderRadius.only(
                        bottomLeft: Radius.circular(Spacing.m),
                        bottomRight: Radius.circular(Spacing.m),
                      ),
                    ),
            ],
          ).scrollableVertical().padding(
              EdgeInsets.only(
                left: Spacing.m,
                right: Spacing.m,
                top: Spacing.m,
              ),
            );
  }
}
