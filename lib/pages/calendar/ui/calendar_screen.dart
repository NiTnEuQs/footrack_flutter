import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_match.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/pages/calendar/components/calendar_page_view.dart";
import "package:footrack_front/pages/match/ui/match_screen.dart";

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  var _pageIndex = 0;
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
    keepPage: true,
  );

  void _addMatch() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertMatch();
      },
    );
  }

  void _editMatch(Match match) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertMatch(
          match: match,
        );
      },
    );
  }

  void _openMatch(Match match) {
    ref.read(matchChoseProvider.notifier).state = match;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MatchScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var calendar = season.getMatchs(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Votre calendrier",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: season == null || calendar.isEmpty
          ? Center(
              child: Text(
                "Match non disponible",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          : CalendarPageView(
              calendar: calendar,
              pageController: _pageController,
              onMatchClick: _openMatch,
              onMatchLongClick: _editMatch,
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
            label: "Championnat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Coupe",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addMatch,
        label: const Text("Ajouter un match"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
