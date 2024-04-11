import "package:flamingo/flamingo.dart";
import "package:flamingo_annotation/flamingo_annotation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/snapshot_extensions.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/models/opponent.dart";
import "package:footrack_front/models/player.dart";

part "season.flamingo.dart";

class Season extends Document<Season> {
  Season({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
    Ref? ref,
  }) {
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

  @Field()
  String? name;

  @Field()
  String? teamName;

  @Field()
  Timestamp? from;

  @Field()
  Timestamp? to;

  // Matchs

  @SubCollection()
  late Collection<Match> matchs;
  final matchsProvider = StateProvider<List<Match>>((_) => []);

  // Opponents

  @SubCollection()
  late Collection<Opponent> opponents;
  final opponentsProvider = StateProvider<List<Opponent>>((_) => []);

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
