import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/extensions/snapshot_extensions.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/models/squad_player.dart';
import 'package:footrack_front/models/substitute.dart';

part 'match.flamingo.dart';

class Match extends Document<Match> {
  Match({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
    CollectionReference<Map<String, dynamic>>? collectionRef,
    WidgetRef? ref,
  }) : super(id: id, snapshot: snapshot, values: values, collectionRef: collectionRef) {
    goals = Collection(this, MatchKey.goals.value);
    substitutes = Collection(this, MatchKey.substitutes.value);
    squad = Collection(this, MatchKey.squad.value);

    init(ref);
  }

  void init(WidgetRef? ref) {
    firestoreInstance.collection(goals.ref.path).snapshots().listen((snap) {
      ref?.read(goalsProvider.notifier).state = snap.map((e) => Goal(snapshot: e, ref: ref));
    });

    firestoreInstance.collection(substitutes.ref.path).snapshots().listen((snap) {
      ref?.read(substitutesProvider.notifier).state = snap.map((e) => Substitute(snapshot: e, ref: ref));
    });

    firestoreInstance.collection(squad.ref.path).snapshots().listen((snap) {
      ref?.read(squadProvider.notifier).state = snap.map((e) => SquadPlayer(snapshot: e, ref: ref));
    });

    opponent?.path.let((path) {
      firestoreInstance.doc(path).snapshots().listen((snap) {
        ref?.read(opponentProvider.notifier).state = Opponent(snapshot: snap);
      });
    });
  }

  @Field()
  String? type;

  @Field()
  Timestamp? date;

  @Field()
  String? status;

  @Field()
  int? time;

  @Field()
  int? scoreOpponent;

  // Opponent

  @Field()
  DocumentReference? opponent;
  final opponentProvider = StateProvider<Opponent?>((_) => null);

  // Goals

  @SubCollection()
  late Collection<Goal> goals;
  final goalsProvider = StateProvider<List<Goal>>((_) => []);

  // Substitutes

  @SubCollection()
  late Collection<Substitute> substitutes;
  final substitutesProvider = StateProvider<List<Substitute>>((_) => []);

  // Squad

  @SubCollection()
  late Collection<SquadPlayer> squad;
  final squadProvider = StateProvider<List<SquadPlayer>>((_) => []);

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
