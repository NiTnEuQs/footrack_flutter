import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/models/player_event.dart';

part 'substitute.flamingo.dart';

class Substitute extends PlayerEvent<Substitute> {
  Substitute({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
    CollectionReference<Map<String, dynamic>>? collectionRef,
    Ref? ref,
  }) : super(id: id, snapshot: snapshot, values: values, collectionRef: collectionRef, ref: ref);

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);

  // Fields

  @Field()
  DocumentReference? playerIn;
  final playerInProvider = StateProvider<Player?>((_) => null);

  @Field()
  DocumentReference? playerOut;
  final playerOutProvider = StateProvider<Player?>((_) => null);

  @Field()
  int? time;

  // Getters

  @override
  DocumentReference<Object?>? getPlayer1() => playerIn;

  @override
  DocumentReference<Object?>? getPlayer2() => playerOut;

  @override
  StateProvider<Player?> getPlayer1Provider() => playerInProvider;

  @override
  StateProvider<Player?> getPlayer2Provider() => playerOutProvider;

  @override
  int? getTime() => time;

  @override
  IconData? getIcon() => Icons.compare_arrows;

  @override
  String getTitle(WidgetRef ref) {
    var playerIn = ref.watch(playerInProvider);
    if (playerIn != null) {
      return playerIn.getName();
    }

    return "";
  }

  @override
  String getSubtitle(WidgetRef ref) {
    var playerOut = ref.watch(playerOutProvider);
    if (playerOut != null) {
      return "Sortie de ${playerOut.getName()}";
    }

    return "";
  }
}
