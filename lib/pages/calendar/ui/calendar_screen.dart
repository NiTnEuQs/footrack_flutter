import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_match.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/pages/calendar/components/calendar_list.dart";
import "package:footrack_front/pages/match/ui/match_screen.dart";

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
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
      body: CalendarList(
        calendar: calendar,
        onMatchClick: _openMatch,
        onMatchLongClick: _editMatch,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addMatch,
        label: const Text("Ajouter un match"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
