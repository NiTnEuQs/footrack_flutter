import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    if (getPlayer1() != null) {
      firestoreInstance.doc(getPlayer1()!.path).snapshots().listen((snap) {
        ref?.read(getPlayer1Provider().notifier).state = Player(snapshot: snap);
      });
    }

    if (getPlayer2() != null) {
      firestoreInstance.doc(getPlayer2()!.path).snapshots().listen((snap) {
        ref?.read(getPlayer2Provider().notifier).state = Player(snapshot: snap);
      });
    }
  }

  DocumentReference? getPlayer1();

  StateProvider<Player?> getPlayer1Provider();

  DocumentReference? getPlayer2();

  StateProvider<Player?> getPlayer2Provider();

  int? getTime();

  IconData? getIcon();

  String getTitle(WidgetRef ref);

  String getSubtitle(WidgetRef ref);
}
