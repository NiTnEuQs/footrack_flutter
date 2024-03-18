import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/ft_grid_tile.dart';
import 'package:footrack_front/database/ft_config.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/pages/page_match_dashboard.dart';
import 'package:footrack_front/pages/page_matchs_list.dart';
import 'package:footrack_front/pages/page_opponents_list.dart';
import 'package:footrack_front/pages/page_players_list.dart';
import 'package:footrack_front/pages/page_stats.dart';

class SeasonDashboardPage extends ConsumerStatefulWidget {
  const SeasonDashboardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeasonDashboardPageState();
}

class _SeasonDashboardPageState extends ConsumerState<SeasonDashboardPage> {
  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var nextMatch = season?.nextMatches(ref)?.first;
    var nextMatchOpponent = nextMatch != null ? ref.watch(nextMatch.opponentProvider) : null;
    var lastPlayedMatches = season?.lastPlayedMatches(ref, take: 5)
      ?..sort((e1, e2) {
        if (e1.date == null || e2.date == null) return 0;

        return e1.date!.compareTo(e2.date!);
      });
    var nbMatches = (season?.nbMatches(ref) ?? 0);
    var nbPlayedMatches = (season?.nbPlayedMatchs(ref) ?? 0);
    var nbNotPlayedMatches = (season?.nbNotPlayedMatchs(ref) ?? 0);
    var playedMatchesRatio = nbMatches > 0 ? nbPlayedMatches / nbMatches : 0.toDouble();
    // var notPlayedMatchesRatio = nbMatches > 0 ? nbNotPlayedMatches / nbMatches : 0.toDouble();

    return season == null
        ? const Center(child: Text("Aucune saison sélectionnée"))
        : Scaffold(
            appBar: AppBar(
              title: Text(season.name ?? "Saison ${season.id}"),
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
                                builder: (_) => MatchDashboardPage(nextMatch.id),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0, bottom: 16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(text: "Prochain match contre"),
                                            TextSpan(
                                                text: " ${nextMatchOpponent?.name}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "le ${nextMatch.date.toDateTime().formatWithTimeAndDay()}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
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
                          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0, bottom: 16.0),
                          child: Text(
                            nbMatches > 0
                                ? "Il n'y a pas de match prochainement"
                                : "Ajoutez des matchs dans le calendrier pour avoir accès à toutes les stats",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                  if (lastPlayedMatches?.isNotEmpty ?? false)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MatchsListPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 16.0),
                        child: Center(
                          child: Column(
                            children: [
                              const Text(
                                "Forme",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
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
                                  const SizedBox(width: 8.0),
                                  Text(
                                    "${lastPlayedMatches.map((e) => ref.watch(e.goalsProvider).length).reduce((prev, curr) => prev + curr)}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  const Icon(
                                    Icons.sports_soccer,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    "${lastPlayedMatches.map((e) => e.getScoreOpponent()).reduce((prev, curr) => prev + curr)}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Text(
                                    "+${lastPlayedMatches.where((e) => e.isWon(ref)).length * 3 + lastPlayedMatches.where((e) => e.isEven(ref)).length} / ${lastPlayedMatches.length * 3}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (nbMatches > 0)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MatchsListPage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0, bottom: 32.0),
                        child: Column(
                          children: [
                            const Text(
                              "Situation",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "$nbPlayedMatches joués",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "$nbNotPlayedMatches restants",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(4.0),
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    crossAxisCount: 2,
                    children: [
                      // FootrackGridTile(
                      //   icon: Icons.access_alarm,
                      //   title: "Votre prochain match",
                      // ),
                      const FTGridTile(
                        icon: Icons.calendar_month,
                        iconSize: 50,
                        title: "Calendrier",
                        titleSize: 22,
                        titleWeight: FontWeight.bold,
                        color: Colors.blue,
                        redirection: MatchsListPage(),
                      ),
                      FTGridTile(
                        icon: Icons.query_stats,
                        iconSize: 50,
                        title: "Stats",
                        titleSize: 22,
                        titleWeight: FontWeight.bold,
                        color: Colors.lightGreen,
                        redirection: const StatsPage(),
                        enabled: ref.watch(remoteConfigProvider)?.getBool(Conf.statsTileEnabled) ?? false,
                      ),
                      const FTGridTile(
                        icon: Icons.person,
                        iconSize: 50,
                        title: "Joueurs",
                        titleSize: 22,
                        titleWeight: FontWeight.bold,
                        color: Colors.amber,
                        redirection: PlayersListPage(),
                      ),
                      const FTGridTile(
                        icon: Icons.groups,
                        iconSize: 50,
                        title: "Adversaires",
                        titleSize: 22,
                        titleWeight: FontWeight.bold,
                        color: Colors.red,
                        redirection: OpponentsListPage(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
