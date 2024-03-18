import 'package:flamingo/flamingo.dart';
import 'package:footrack_front/extensions/snapshot_extensions.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'match_notifier.g.dart';

@Riverpod(keepAlive: true)
class MatchId extends _$MatchId {
  @override
  String build() => "";

  void set(String matchId) => state = matchId;
}

@Riverpod(keepAlive: true)
class SelectedMatch extends _$SelectedMatch {
  @override
  Match build() {
    final seasonId = ref.watch(seasonIdProvider);
    final matchId = ref.watch(matchIdProvider);
    final matchStream = ref.watch(_matchStreamProvider(seasonId: seasonId, matchId: matchId).future).asStream();
    final matchSubscription = matchStream.listen((value) {
      ref.read(_matchSelectedProvider.notifier).set(value);
    });

    ref.onDispose(matchSubscription.cancel);

    return ref.watch(_matchSelectedProvider);
  }
}

@Riverpod(keepAlive: true)
Stream<Match> _matchStream(_MatchStreamRef ref, {required String seasonId, required String matchId}) =>
    FirebaseFirestore.instance.doc("seasons/$seasonId/matchs/$matchId").snapshots().map(
          (snap) => Match(snapshot: snap, ref: ref),
        );

@Riverpod(keepAlive: true)
class _MatchSelected extends _$MatchSelected {
  @override
  Match build() => Match();

  void set(Match match) => state = match;
}

@Riverpod(keepAlive: true)
Stream<List<Match>> matchsStream(MatchsStreamRef ref, {required String seasonId}) {
  var seasonId = ref.watch(selectedSeasonProvider).id;

  return firestoreInstance.collection("seasons/$seasonId/matchs").snapshots().map(
        (querySnap) => querySnap.map(
          (snap) => Match(snapshot: snap, ref: ref),
        ),
      );
}
