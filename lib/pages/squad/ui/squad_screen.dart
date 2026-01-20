import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_squad_player.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/squad_player.dart";
import "package:footrack_front/pages/squad/components/squad_page_view.dart";

class SquadScreen extends ConsumerStatefulWidget {
  const SquadScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SquadScreenState();
}

class _SquadScreenState extends ConsumerState<SquadScreen> {
  var _pageIndex = 0;
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );

  void _addSquadPlayer() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertSquadPlayer();
      },
    );
  }

  void _editSquadPlayer(SquadPlayer player) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSquadPlayer(
          squadPlayer: player,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var match = ref.watch(matchChoseProvider);
    var squad = match.getSquad(ref);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Votre effectif",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SquadPageView(
          squad: squad,
          pageController: _pageController,
          onPlayerLongClick: _editSquadPlayer,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: (index) {
            setState(() {
              _pageIndex = index;
              _pageController.animateToPage(index,
                  duration: Durations.long1, curve: Curves.ease);
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
          onPressed: _addSquadPlayer,
          label: const Text("Ajouter un joueur"),
          icon: const Icon(Icons.add),
        ));
  }
}
