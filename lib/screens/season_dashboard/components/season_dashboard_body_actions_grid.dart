import 'package:flutter/material.dart';
import 'package:footrack_front/components/tiles/tile_action_grid.dart';
import 'package:footrack_front/screens/matchs_list/ui/matchs_list_page.dart';
import 'package:footrack_front/screens/opponents_list/ui/opponents_list_page.dart';
import 'package:footrack_front/screens/players_list/ui/players_list_page.dart';
import 'package:footrack_front/screens/season_stats/ui/season_stats_page.dart';

class SeasonDashboardBodyActionsGrid extends StatelessWidget {
  const SeasonDashboardBodyActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(4.0),
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
      crossAxisCount: 2,
      children: const [
        ActionGridTile(
          icon: Icons.calendar_month,
          iconSize: 50,
          title: "Calendrier",
          titleSize: 22,
          titleWeight: FontWeight.bold,
          color: Colors.blue,
          redirection: MatchsListPage(),
        ),
        ActionGridTile(
          icon: Icons.query_stats,
          iconSize: 50,
          title: "Stats",
          titleSize: 22,
          titleWeight: FontWeight.bold,
          color: Colors.lightGreen,
          redirection: StatsPage(),
          // enabled: ref.watch(remoteConfigProvider)?.getBool(Conf.statsTileEnabled) ?? false,
        ),
        ActionGridTile(
          icon: Icons.person,
          iconSize: 50,
          title: "Joueurs",
          titleSize: 22,
          titleWeight: FontWeight.bold,
          color: Colors.amber,
          redirection: PlayersListPage(),
        ),
        ActionGridTile(
          icon: Icons.groups,
          iconSize: 50,
          title: "Adversaires",
          titleSize: 22,
          titleWeight: FontWeight.bold,
          color: Colors.red,
          redirection: OpponentsListPage(),
        ),
      ],
    );
  }
}
