import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/match.dart';

extension MatchsExtensions on List<Match> {
  List<Match> sortedByDate() {
    sort((e1, e2) {
      var e1Date = e1.date;
      var e2Date = e2.date;

      if (e1Date != null && e2Date != null) {
        return e1Date.compareTo(e2Date);
      }

      return 0;
    });

    return this;
  }

  List<Match> played() {
    return sortedByDate().where((match) => (match.date?.toDateTime()?.compareTo(DateTime.now()) ?? 0) < 0).toList();
  }

  List<Match> notPlayed() {
    return sortedByDate().where((match) => (match.date?.toDateTime()?.compareTo(DateTime.now()) ?? 0) > 0).toList();
  }

  List<Match> firstPlayed(int take) {
    return played().take(take).toList();
  }

  List<Match> lastPlayed(int take) {
    return played().reversed.take(take).toList();
  }

  Match? lastMatch() {
    return lastPlayed(1).firstOrNull;
  }

  Match? nextMatch() {
    return notPlayed().firstOrNull;
  }

  int nbPlayedMatchs() {
    return played().length;
  }

  int nbNotPlayedMatchs() {
    return notPlayed().length;
  }

  double playedMatchsRatio() {
    if (length <= 0) {
      return 0.0;
    }

    return nbPlayedMatchs() / length;
  }

  int nbGoals(WidgetRef ref) {
    if (isEmpty) {
      return 0;
    }

    return map((e) => ref.watch(e.goalsProvider).length).reduce((prev, curr) => prev + curr);
  }

  int nbGoalsOpponents(WidgetRef ref) {
    if (isEmpty) {
      return 0;
    }

    return map((e) => e.getScoreOpponent()).reduce((prev, curr) => prev + curr);
  }

  int nbPoints(WidgetRef ref) {
    if (isEmpty) {
      return 0;
    }

    return where((e) => e.isWon(ref)).length * 3 + where((e) => e.isEven(ref)).length;
  }
}
