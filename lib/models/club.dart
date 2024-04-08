import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/snapshot_extensions.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/player.dart';

part 'club.flamingo.dart';

class Club extends Document<Club> {
  Club({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
    WidgetRef? ref,
  }) {
    seasons = Collection(this, ClubKey.seasons.value);
    players = Collection(this, ClubKey.players.value);

    init(ref);
  }

  void init(WidgetRef? ref) {
    firestoreInstance.collection(seasons.ref.path).snapshots().listen((snap) {
      ref?.read(seasonsProvider.notifier).state = snap.map((e) => Match(snapshot: e, ref: ref));
    });

    firestoreInstance.collection(players.ref.path).snapshots().listen((snap) {
      ref?.read(playersProvider.notifier).state = snap.map((e) => Player(snapshot: e));
    });
  }

  @Field()
  String? teamName;

  // Matchs

  @SubCollection()
  late Collection<Match> seasons;
  final seasonsProvider = StateProvider<List<Match>>((_) => []);

  // Players

  @SubCollection()
  late Collection<Player> players;
  final playersProvider = StateProvider<List<Player>>((_) => []);

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
