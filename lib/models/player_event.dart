import "package:flamingo/flamingo.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/player.dart";

abstract class PlayerEvent<T> extends Document<T> {
  PlayerEvent({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
    Ref? ref,
  }) {
    init(ref);
  }

  void init(Ref? ref) {
    getPlayer1()?.path.let((path) {
      firestoreInstance.doc(path).snapshots().listen((snap) {
        ref?.read(getPlayer1Provider().notifier).state = Player(snapshot: snap);
      });
    });

    getPlayer2()?.path.let((path) {
      firestoreInstance.doc(path).snapshots().listen((snap) {
        ref?.read(getPlayer2Provider().notifier).state = Player(snapshot: snap);
      });
    });
  }

  DocumentReference? getPlayer1();

  StateProvider<Player?> getPlayer1Provider();

  DocumentReference? getPlayer2();

  StateProvider<Player?> getPlayer2Provider();

  int? getTime();

  Widget? getIcon();

  Widget getTitle(WidgetRef ref);

  Widget getSubtitle(WidgetRef ref);
}
