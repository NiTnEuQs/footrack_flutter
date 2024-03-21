import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/player.dart';

part 'squad_player.flamingo.dart';

class SquadPlayer extends Document<SquadPlayer> {
  SquadPlayer({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
    CollectionReference<Map<String, dynamic>>? collectionRef,
    WidgetRef? ref,
  }) : super(id: id, snapshot: snapshot, values: values, collectionRef: collectionRef) {
    init(ref);
  }

  void init(WidgetRef? ref) {
    player?.path.let((path) {
      firestoreInstance.doc(path).snapshots().listen((snap) {
        ref?.read(playerProvider.notifier).state = Player(snapshot: snap);
      });
    });
  }

  // Player

  @Field()
  DocumentReference? player;
  final playerProvider = StateProvider<Player?>((_) => null);

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
