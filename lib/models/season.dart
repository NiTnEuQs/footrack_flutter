import "package:collection/collection.dart";
import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/extensions/snapshot_extensions.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/models/player.dart';

part 'season.flamingo.dart';

class Season extends Document<Season> {
  Season({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
    CollectionReference<Map<String, dynamic>>? collectionRef,
    Ref? ref,
  }) : super(id: id, snapshot: snapshot, values: values, collectionRef: collectionRef) {
    matchs = Collection(this, SeasonKey.matchs.value);
    opponents = Collection(this, SeasonKey.opponents.value);
    players = Collection(this, SeasonKey.players.value);

    init(ref);
  }

  void init(Ref? ref) {
    firestoreInstance.collection(matchs.ref.path).snapshots().listen((snap) {
      ref?.read(matchsProvider.notifier).state = snap.map((e) => Match(snapshot: e, ref: ref));
    });

    firestoreInstance.collection(opponents.ref.path).snapshots().listen((snap) {
      ref?.read(opponentsProvider.notifier).state = snap.map((e) => Opponent(snapshot: e));
    });

    firestoreInstance.collection(players.ref.path).snapshots().listen((snap) {
      ref?.read(playersProvider.notifier).state = snap.map((e) => Player(snapshot: e));
    });
  }

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);

  // Fields

  @Field()
  String? name;

  @Field()
  String? teamName;

  @Field()
  Timestamp? from;

  @Field()
  Timestamp? to;

  @SubCollection()
  late Collection<Match> matchs;
  final matchsProvider = StateProvider<List<Match>>((_) => []);

  @SubCollection()
  late Collection<Opponent> opponents;
  final opponentsProvider = StateProvider<List<Opponent>>((_) => []);

  @SubCollection()
  late Collection<Player> players;
  final playersProvider = StateProvider<List<Player>>((_) => []);

  // Getters

  String getName({String defaultValue = "-"}) => name ?? defaultValue;

  List<Match> allMatchs(WidgetRef ref) => ref.watch(matchsProvider);

  List<Match> playedMatchs(WidgetRef ref) => allMatchs(ref).where((e) => e.date.hasPassed()).toList();

  List<Match> notPlayedMatchs(WidgetRef ref) => allMatchs(ref).where((e) => !e.date.hasPassed()).toList();

  List<Goal> allGoalsFor(WidgetRef ref) {
    return playedMatchs(ref).let((it) {
      if (it.isEmpty) return [];

      return (it.map((e) => ref.watch(e.goalsProvider)).reduce((prev, curr) => [...prev ?? [], ...curr ?? []]) ?? [])
          .toList();
    });
  }

  bool isInProgress() {
    var now = DateTime.now();
    var fromDate = from?.toDate();
    var toDate = to?.toDate();

    return switch ((fromDate, toDate)) {
      (!= null, null) => now.isAfter(fromDate!),
      (null, != null) => now.isBefore(toDate!),
      (!= null, != null) => now.isAfter(fromDate!) && now.isBefore(toDate!),
      _ => false,
    };
  }

  int nbMatchs(WidgetRef ref) => allMatchs(ref).length;

  int nbNotPlayedMatchs(WidgetRef ref) => notPlayedMatchs(ref).length;

  int nbPlayedMatchs(WidgetRef ref) => playedMatchs(ref).length;

  int nbWins(WidgetRef ref) => playedMatchs(ref).where((e) => e.isWon(ref)).length;

  int nbLosses(WidgetRef ref) => playedMatchs(ref).where((e) => e.isLoss(ref)).length;

  int nbEvens(WidgetRef ref) => playedMatchs(ref).where((e) => e.isEven(ref)).length;

  int nbPoints(WidgetRef ref) => nbWins(ref) * 3 + nbEvens(ref);

  int nbMaxPoints(WidgetRef ref) => nbPlayedMatchs(ref) * 3;

  int nbGoalsFor(WidgetRef ref) => allGoalsFor(ref).length;

  int nbGoalsAgainst(WidgetRef ref) {
    return playedMatchs(ref).let((it) {
      if (it.isEmpty) return 0;

      return it.map((e) => e.getScoreOpponent()).reduce((prev, curr) => prev + curr);
    });
  }

  double goalsForRatio(WidgetRef ref) => nbGoalsFor(ref) / nbPlayedMatchs(ref);

  double goalsAgainstRatio(WidgetRef ref) => nbGoalsAgainst(ref) / nbPlayedMatchs(ref);

  double winsPercent(WidgetRef ref) => nbWins(ref) / nbPlayedMatchs(ref) * 100;

  double pointsPercent(WidgetRef ref) => nbPoints(ref) / nbMaxPoints(ref) * 100;

  Iterable<MapEntry<DocumentReference?, int>>? scorers(WidgetRef ref) {
    var playedMatchsMapped = playedMatchs(ref).map((e) => ref.watch(e.goalsProvider));
    if (playedMatchsMapped.isEmpty) return null;

    var goals = playedMatchsMapped.reduce((prev, curr) {
          return [...prev ?? [], ...curr ?? []];
        }) ??
        [];
    if (goals.isEmpty) return null;

    var scorers = goals.groupListsBy((e) => e.scorer).map((key, value) => MapEntry(key, value.length))
      ..removeWhere((key, value) => key == null);
    if (scorers.isEmpty) return null;

    var scorersSorted = Map.fromEntries(
      scorers.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)),
    );

    return scorersSorted.entries;
  }

  Iterable<MapEntry<DocumentReference?, int>>? passers(WidgetRef ref) {
    var playedMatchsMapped = playedMatchs(ref).map((e) => ref.watch(e.goalsProvider));
    if (playedMatchsMapped.isEmpty) return null;

    var goals = (playedMatchsMapped.reduce((prev, curr) {
          return [...prev ?? [], ...curr ?? []];
        }) ??
        [])
      ..removeWhere((e) => e.passer == null || e.scorer == null);
    if (goals.isEmpty) return null;

    var passers = goals.groupListsBy((e) => e.passer).map((key, value) {
      return MapEntry(key, value.length);
    });
    if (passers.isEmpty) return null;

    var passersSorted = Map.fromEntries(
      passers.entries.toList()
        ..sort((e1, e2) {
          return e2.value.compareTo(e1.value);
        }),
    );

    return passersSorted.entries;
  }

  MapEntry<DocumentReference?, int>? bestScorer(WidgetRef ref) {
    return scorers(ref)?.first;
  }

  MapEntry<DocumentReference?, int>? bestPasser(WidgetRef ref) {
    return passers(ref)?.first;
  }

  List<Match> lastPlayedMatchs(WidgetRef ref, {int take = 1}) {
    var matchs = List.of(allMatchs(ref))
      ..removeWhere((e) => !e.date.hasPassed())
      ..sort((e1, e2) {
        if (e1.date == null || e2.date == null) return 0;

        return e2.date!.compareTo(e1.date!);
      });

    return matchs.take(take).toList();
  }

  List<Match>? nextMatchs(WidgetRef ref, {int take = 1}) {
    var matchs = List.of(allMatchs(ref))
      ..removeWhere((e) => e.date.hasPassed(add: const Duration(hours: -2)))
      ..sort((e1, e2) {
        if (e1.date == null || e2.date == null) return 0;

        return e1.date!.compareTo(e2.date!);
      });

    return matchs.isNotEmpty ? matchs.take(take).toList() : null;
  }
}
