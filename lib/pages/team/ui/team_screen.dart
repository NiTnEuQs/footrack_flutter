import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_player.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/pages/team/components/team_page_view.dart";

class TeamScreen extends ConsumerStatefulWidget {
  const TeamScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeamScreenState();
}

class _TeamScreenState extends ConsumerState<TeamScreen> {
  var _pageIndex = 0;
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );

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
    var players = season.getPlayers(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vos joueurs",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: players.isEmpty
          ? Center(
              child: Text(
                "Aucun joueur",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : TeamPageView(
              team: players,
              pageController: _pageController,
              onPlayerLongClick: _editPlayer,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
            _pageController.animateToPage(index, duration: Durations.long1, curve: Curves.ease);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: "Joueurs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: "Délégués",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPlayer,
        label: const Text("Ajouter un joueur"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
