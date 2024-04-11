import "package:flamingo/flamingo.dart";
import "package:flamingo_annotation/flamingo_annotation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/player.dart";

part "squad_player.flamingo.dart";

class SquadPlayer extends Document<SquadPlayer> {
  SquadPlayer({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
    Ref? ref,
  }) {
    init(ref);
  }

  void init(Ref? ref) {
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
