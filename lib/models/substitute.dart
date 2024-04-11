import "package:flamingo/flamingo.dart";
import "package:flamingo_annotation/flamingo_annotation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/substitute_extension.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/models/player_event.dart";

part "substitute.flamingo.dart";

class Substitute extends PlayerEvent<Substitute> {
  Substitute({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
    super.ref,
  });

  @Field()
  int? time;

  @Field()
  DocumentReference? playerIn;
  final playerInProvider = StateProvider<Player?>((_) => null);

  @Field()
  DocumentReference? playerOut;
  final playerOutProvider = StateProvider<Player?>((_) => null);

  // Overridden

  @override
  int? getTime() => time;

  @override
  DocumentReference<Object?>? getPlayer1() => playerIn;

  @override
  StateProvider<Player?> getPlayer1Provider() => playerInProvider;

  @override
  DocumentReference<Object?>? getPlayer2() => playerOut;

  @override
  StateProvider<Player?> getPlayer2Provider() => playerOutProvider;

  @override
  Widget? getIcon() => const Icon(Icons.compare_arrows, color: Colors.blue);

  @override
  Widget getTitle(WidgetRef ref) {
    var playerIn = getPlayerIn(ref);

    if (playerIn != null) {
      return Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: "Entrée de "),
            TextSpan(
              text: playerIn.getName(defaultValue: "-"),
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container();
  }

  @override
  Widget getSubtitle(WidgetRef ref) {
    var playerOut = getPlayerOut(ref);

    if (playerOut != null) {
      return Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: "Sortie de "),
            TextSpan(
              text: playerOut.getName(),
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container();
  }

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
