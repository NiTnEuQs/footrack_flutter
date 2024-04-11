import "package:collection/collection.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/list_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/goal_extension.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/goal.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/models/opponent.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/models/season.dart";

extension SeasonExtension on Season? {
  // Getters

  String getName({String defaultValue = ""}) => this?.name ?? defaultValue;

  String getTeamName({String defaultValue = ""}) => this?.teamName ?? defaultValue;

  DateTime? getFrom({DateTime? defaultValue}) => this?.from.toDateTime() ?? defaultValue;

  DateTime? getTo({DateTime? defaultValue}) => this?.to.toDateTime() ?? defaultValue;

  List<Match> getMatchs(WidgetRef ref) => this?.matchsProvider.let((it) => ref.watch(it)) ?? [];

  List<Opponent> getOpponents(WidgetRef ref) => this?.opponentsProvider.let((it) => ref.watch(it)) ?? [];

  List<Player> getPlayers(WidgetRef ref) => this?.playersProvider.let((it) => ref.watch(it)) ?? [];

  // Others

  List<Match> playedMatchs(WidgetRef ref) => getMatchs(ref).where((e) => e.getDate().hasPassed()).toList();

  List<Match> notPlayedMatchs(WidgetRef ref) => getMatchs(ref).where((e) => !e.getDate().hasPassed()).toList();

  List<Goal> allGoalsFor(WidgetRef ref) {
    var playedMatchs = this.playedMatchs(ref);

    return playedMatchs.isNotEmpty ? playedMatchs.map((e) => e.getGoals(ref)).reduceMerge() : [];
  }

  int nbMatches(WidgetRef ref) => getMatchs(ref).length;

  int nbNotPlayedMatchs(WidgetRef ref) => notPlayedMatchs(ref).length;

  int nbPlayedMatchs(WidgetRef ref) => playedMatchs(ref).length;

  int nbWins(WidgetRef ref) => playedMatchs(ref).where((e) => e.isWon(ref)).length;

  int nbLosses(WidgetRef ref) => playedMatchs(ref).where((e) => e.isLoss(ref)).length;

  int nbEvens(WidgetRef ref) => playedMatchs(ref).where((e) => e.isEven(ref)).length;

  int nbPoints(WidgetRef ref) => nbWins(ref) * 3 + nbEvens(ref);

  int nbMaxPoints(WidgetRef ref) => nbPlayedMatchs(ref) * 3;

  int nbGoalsFor(WidgetRef ref) => allGoalsFor(ref).length;

  int nbGoalsAgainst(WidgetRef ref) {
    var playedMatchs = this.playedMatchs(ref);

    return playedMatchs.isNotEmpty ? playedMatchs.map((e) => e.getScoreOpponent()).reduceAdd() : 0;
  }

  double goalsForRatio(WidgetRef ref) => nbGoalsFor(ref) / nbPlayedMatchs(ref);

  double goalsAgainstRatio(WidgetRef ref) => nbGoalsAgainst(ref) / nbPlayedMatchs(ref);

  double winsPercent(WidgetRef ref) => nbWins(ref) / nbPlayedMatchs(ref) * 100;

  double pointsPercent(WidgetRef ref) => nbPoints(ref) / nbMaxPoints(ref) * 100;

  Iterable<MapEntry<Player?, int>>? scorers(WidgetRef ref) {
    var playedMatchsMapped = playedMatchs(ref).map((e) => e.getGoals(ref));
    if (playedMatchsMapped.isEmpty) return null;

    var goals = playedMatchsMapped.reduceMerge()..removeWhere((e) => e.scorer == null);
    if (goals.isEmpty) return null;

    var scorers = goals.groupListsBy((e) => e.getScorer(ref)).map((k, v) => MapEntry(k, v.length));
    if (scorers.isEmpty) return null;

    var scorersSorted = Map.fromEntries(
      scorers.entries.toList()..sort((a, b) => b.value.compare(a.value)),
    );

    return scorersSorted.entries;
  }

  Iterable<MapEntry<Player?, int>>? passers(WidgetRef ref) {
    var playedMatchsMapped = playedMatchs(ref).map((e) => e.getGoals(ref));
    if (playedMatchsMapped.isEmpty) return null;

    var goals = playedMatchsMapped.reduceMerge()..removeWhere((e) => e.passer == null || e.scorer == null);
    if (goals.isEmpty) return null;

    var passers = goals.groupListsBy((e) => e.getPasser(ref)).map((k, v) => MapEntry(k, v.length));
    if (passers.isEmpty) return null;

    var passersSorted = Map.fromEntries(
      passers.entries.toList()..sort((a, b) => b.value.compare(a.value)),
    );

    return passersSorted.entries;
  }

  MapEntry<Player?, int>? bestScorer(WidgetRef ref) => scorers(ref)?.firstOrNull;

  MapEntry<Player?, int>? bestPasser(WidgetRef ref) => passers(ref)?.firstOrNull;

  List<Match> lastPlayedMatches(WidgetRef ref, {int take = 1}) {
    var matchs = List.of(getMatchs(ref))
      ..removeWhere((e) => !e.getDate().hasPassed())
      ..sort((a, b) => b.getDate().compare(a.getDate()));

    return matchs.isNotEmpty ? matchs.take(take).toList() : [];
  }

  List<Match> nextMatches(WidgetRef ref, {int take = 1}) {
    var matchs = List.of(getMatchs(ref))
      ..removeWhere((e) => e.getDate().hasPassed(add: const Duration(hours: 2)))
      ..sort((a, b) => a.getDate().compare(b.getDate()));

    return matchs.isNotEmpty ? matchs.take(take).toList() : [];
  }
}
