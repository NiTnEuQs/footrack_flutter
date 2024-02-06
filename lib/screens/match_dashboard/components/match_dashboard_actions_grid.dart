import 'package:flutter/material.dart';
import 'package:footrack_front/components/tiles/tile_action_grid.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/match.dart';

class MatchDashboardActionsGrid extends StatelessWidget {
  const MatchDashboardActionsGrid({
    Key? key,
    required this.match,
    this.onGoalClicked,
    this.onSubstituteClicked,
    this.onTeamClicked,
    this.onStartClicked,
    this.onStopClicked,
    this.onOpponentGoalClicked,
    this.onOpponentGoalLongPress,
  }) : super(key: key);

  final Match match;
  final Function()? onGoalClicked;
  final Function()? onSubstituteClicked;
  final Function()? onTeamClicked;
  final Function()? onStartClicked;
  final Function()? onStopClicked;
  final Function()? onOpponentGoalClicked;
  final Function()? onOpponentGoalLongPress;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        ActionGridTile(
          icon: Icons.sports_soccer,
          title: "But",
          color: Colors.green,
          onTap: onGoalClicked,
        ),
        ActionGridTile(
          icon: Icons.person_add,
          title: "Changements",
          color: Colors.green,
          onTap: onSubstituteClicked,
        ),
        ActionGridTile(
          icon: Icons.groups,
          title: "Effectif",
          color: Colors.blue,
          onTap: onTeamClicked,
          enabled: !match.date.hasPassed(),
        ),
        ActionGridTile(
          icon: Icons.sports_soccer,
          title: "But adverse",
          color: Colors.red,
          onTap: onOpponentGoalClicked,
          onLongPress: onOpponentGoalLongPress,
        ),
        // Will be implemented later
        // ActionGridTile(
        //   icon: !match.hasBegun() ? Icons.play_arrow : Icons.pause,
        //   title: !match.hasBegun() ? "Début" : "Temps mort",
        //   onTap: onStartClicked,
        //   enabled: !match.date.hasPassed(add: const Duration(hours: -2)),
        // ),
        // ActionGridTile(
        //   icon: !match.hasBegun() ? Icons.looks_two_rounded : Icons.stop,
        //   title: !match.hasBegun() ? "Mi-temps" : "Fin du match",
        //   onTap: onStopClicked,
        //   enabled: !match.date.hasPassed(add: const Duration(hours: -2)),
        // ),
      ],
    );
  }
}
