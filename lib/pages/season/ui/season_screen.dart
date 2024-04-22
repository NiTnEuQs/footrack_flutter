import "package:collection/collection.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/ft_grid_tile.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_config.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/list_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/opponent_extension.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/pages/page_match_dashboard.dart";
import "package:footrack_front/pages/page_matchs_list.dart";
import "package:footrack_front/pages/page_opponents_list.dart";
import "package:footrack_front/pages/page_players_list.dart";
import "package:footrack_front/pages/page_stats.dart";

class SeasonDashboardPage extends ConsumerStatefulWidget {
  const SeasonDashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeasonDashboardPageState();
}

class _SeasonDashboardPageState extends ConsumerState<SeasonDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final version = ref.watch(packageInfoProvider)?.version;

    var season = ref.watch(seasonChoseProvider);
    var nextMatch = season.nextMatches(ref).firstOrNull;
    var nextMatchOpponent = nextMatch.getOpponent(ref);
    var lastPlayedMatches = season?.lastPlayedMatches(ref, take: 5)?..sort((a, b) => a.getDate().compare(b.getDate()));
    var nbMatches = season.nbMatches(ref);
    var nbPlayedMatches = season.nbPlayedMatchs(ref);
    var nbNotPlayedMatches = season.nbNotPlayedMatchs(ref);
    double playedMatchesRatio = nbMatches > 0 ? nbPlayedMatches / nbMatches : 0;

    return season == null
        ? Center(
            child: Text(
              "Aucune saison sélectionnée",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                season.getName(defaultValue: "Saison ${season.id}"),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  (nextMatch != null)
                      ? InkWell(
                          onTap: () {
                            ref.read(matchChoseProvider.notifier).state = nextMatch;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MatchScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Prochain match contre ",
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                            TextSpan(
                                              text: nextMatchOpponent.getName(),
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        nextMatch.getDate().formatLanguage(),
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: Spacing.xl2,
                            right: Spacing.xl2,
                            top: Spacing.xl2,
                            bottom: Spacing.m,
                          ),
                          child: Text(
                            nbMatches > 0
                                ? "Il n'y a pas de match prochainement"
                                : "Ajoutez des matchs dans le calendrier pour avoir accès à toutes les stats",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                  if (lastPlayedMatches?.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Forme",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: lastPlayedMatches!
                                  .mapIndexed(
                                    (i, e) => Icon(
                                      Icons.circle,
                                      color: e.resultColor(ref),
                                      size: (16 + (2 * i)).toDouble(),
                                    ),
                                  )
                                  .toList(),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.sports_soccer,
                                  color: Colors.lightGreen,
                                ),
                                const SizedBox(width: Spacing.xs),
                                Text(
                                  "${lastPlayedMatches.map((e) => e.getTotalScoreTeam(ref)).reduceAdd()}",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.lightGreen),
                                ),
                                const SizedBox(width: Spacing.m),
                                const Icon(
                                  Icons.sports_soccer,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: Spacing.xs),
                                Text(
                                  "${lastPlayedMatches.map((e) => e.getScoreOpponent()).reduceAdd()}",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.red,
                                      ),
                                ),
                                const SizedBox(width: Spacing.m),
                                Text(
                                  "+${lastPlayedMatches.where((e) => e.isWon(ref)).length * 3 + lastPlayedMatches.where((e) => e.isEven(ref)).length} / ${lastPlayedMatches.length * 3}",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.blue,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (nbMatches > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                      child: Column(
                        children: [
                          Text(
                            "Situation",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(25)),
                                child: LinearProgressIndicator(
                                  value: playedMatchesRatio,
                                  minHeight: 24,
                                  color: Colors.lightGreen,
                                  backgroundColor: Colors.lightGreen.withAlpha(100),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "$nbPlayedMatches joués",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Text(
                                      "$nbNotPlayedMatches restants",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.s),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: Spacing.xs2,
                      mainAxisSpacing: Spacing.xs2,
                      crossAxisCount: 2,
                      children: [
                        const FTGridTile(
                          icon: Icons.calendar_month,
                          iconSize: 50,
                          title: "Calendrier",
                          titleSize: 22,
                          titleWeight: FontWeight.bold,
                          color: Colors.blue,
                          redirection: CalendarScreen(),
                        ),
                        FTGridTile(
                          icon: Icons.query_stats,
                          iconSize: 50,
                          title: "Stats",
                          titleSize: 22,
                          titleWeight: FontWeight.bold,
                          color: Colors.lightGreen,
                          redirection: const StatsScreen(),
                          enabled: ref.watch(remoteConfigProvider)?.getBool(Conf.statsTileEnabled) ?? false,
                        ),
                        const FTGridTile(
                          icon: Icons.person,
                          iconSize: 50,
                          title: "Joueurs",
                          titleSize: 22,
                          titleWeight: FontWeight.bold,
                          color: Colors.amber,
                          redirection: TeamScreen(),
                        ),
                        const FTGridTile(
                          icon: Icons.groups,
                          iconSize: 50,
                          title: "Adversaires",
                          titleSize: 22,
                          titleWeight: FontWeight.bold,
                          color: Colors.red,
                          redirection: OpponentsScreen(),
                        ),
                      ],
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
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
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
          );
  }
}
