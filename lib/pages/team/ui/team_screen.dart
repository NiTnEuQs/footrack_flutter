import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_player.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/pages/team/components/team_list.dart";

class TeamScreen extends ConsumerStatefulWidget {
  const TeamScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeamScreenState();
}

class _TeamScreenState extends ConsumerState<TeamScreen> {
  void _addPlayer() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertPlayer();
      },
    );
  }

  void _editPlayer(Player player) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertPlayer(
          player: player,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var team = season.getPlayers(ref);

    return Scaffold(
      body: TeamList(
        team: team,
        onPlayerLongClick: _editPlayer,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPlayer,
        label: const Text("Ajouter un joueur"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
