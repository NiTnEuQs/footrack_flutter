import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/footrack_grid_tile.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/models/season.dart';
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
    Season? season = ref.watch(seasonChoseProvider);

    return (season == null)
        ? const Center(
            child: Text("Aucune saison sélectionnée"),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(season.name),
            ),
            body: GridView.count(
              crossAxisCount: 2,
              children: const [
                FootrackGridTile(
                  icon: Icons.access_alarm,
                  title: "Prochain match",
                ),
                FootrackGridTile(
                  icon: Icons.calendar_month,
                  title: "Calendrier",
                  redirection: MatchsListPage(),
                ),
                FootrackGridTile(
                  icon: Icons.person,
                  title: "Joueurs",
                  redirection: PlayersListPage(),
                ),
                FootrackGridTile(
                  icon: Icons.groups,
                  title: "Adversaires",
                  redirection: OpponentsListPage(),
                ),
                FootrackGridTile(
                  icon: Icons.query_stats,
                  title: "Stats",
                  redirection: StatsPage(),
                ),
              ],
            ),
          );
  }
}
