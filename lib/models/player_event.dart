import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/player.dart';

abstract class PlayerEvent<T> extends Document<T> {
  PlayerEvent({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
    CollectionReference<Map<String, dynamic>>? collectionRef,
    WidgetRef? ref,
  }) : super(id: id, snapshot: snapshot, values: values, collectionRef: collectionRef) {
    init(ref);
  }

  void init(WidgetRef? ref) {
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
