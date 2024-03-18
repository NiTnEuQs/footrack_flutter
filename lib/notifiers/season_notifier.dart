import 'package:flamingo/flamingo.dart';
import 'package:footrack_front/extensions/snapshot_extensions.dart';
import 'package:footrack_front/models/season.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'season_notifier.g.dart';

@Riverpod(keepAlive: true)
class SeasonId extends _$SeasonId {
  @override
  String build() => "";

  void set(String seasonId) => state = seasonId;
}

@Riverpod(keepAlive: true)
class SelectedSeason extends _$SelectedSeason {
  @override
  Season build() {
    final seasonId = ref.watch(seasonIdProvider);
    final seasonStream = ref.watch(_seasonStreamProvider(seasonId: seasonId).future).asStream();
    final seasonSubscription = seasonStream.listen((value) {
      ref.read(_seasonSelectedProvider.notifier).set(value);
    });

    ref.onDispose(seasonSubscription.cancel);

    return ref.watch(_seasonSelectedProvider);
  }
}

@Riverpod(keepAlive: true)
Stream<Season> _seasonStream(_SeasonStreamRef ref, {required String seasonId}) =>
    FirebaseFirestore.instance.doc("seasons/$seasonId").snapshots().map(
          (snap) => Season(snapshot: snap, ref: ref),
        );

@Riverpod(keepAlive: true)
class _SeasonSelected extends _$SeasonSelected {
  @override
  Season build() => Season();

  void set(Season season) => state = season;
}

@Riverpod(keepAlive: true)
Stream<List<Season>> seasonsStream(SeasonsStreamRef ref) => firestoreInstance.collection("seasons").snapshots().map(
      (querySnap) => querySnap.map(
        (snap) => Season(snapshot: snap, ref: ref),
      ),
    );
