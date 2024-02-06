import 'package:flamingo/flamingo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/firestore_database.dart';
import 'package:footrack_front/extensions/snapshot_extensions.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/models/match.dart';

final dbProvider = Provider((_) => FirestoreDatabase());
final languageProvider = StateProvider<String?>((_) => null);

final seasonProvider = StateProvider<Season>((_) => Season());
final matchProvider = StateProvider<Match>((_) => Match());

final seasonsStreamProvider = StreamProvider<List<Season>>((ref) {
  return firestoreInstance
      .collection("seasons")
      .snapshots()
      .map((querySnap) => querySnap.map((snap) => Season(snapshot: snap, ref: ref)));
});

final seasonStreamProvider = StreamProvider<Season>((ref) {
  var season = ref.watch(seasonProvider);

  return firestoreInstance
      .collection("seasons")
      .doc(season.id)
      .snapshots()
      .map((snap) => Season(snapshot: snap, ref: ref));
});

final matchsStreamProvider = StreamProvider<List<Match>>((ref) {
  var season = ref.watch(seasonProvider);

  return firestoreInstance
      .collection("seasons")
      .doc(season.id)
      .collection("matchs")
      .snapshots()
      .map((querySnap) => querySnap.map((snap) => Match(snapshot: snap, ref: ref)));
});

final matchStreamProvider = StreamProvider<Match>((ref) {
  var season = ref.watch(seasonProvider);
  var match = ref.watch(matchProvider);

  return firestoreInstance
      .collection("seasons")
      .doc(season.id)
      .collection("matchs")
      .doc(match.id)
      .snapshots()
      .map((snap) => Match(snapshot: snap, ref: ref));
});
