import "package:flamingo/flamingo.dart";
import "package:flamingo_annotation/flamingo_annotation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/models/extensions/goal_extension.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/models/player_event.dart";

part "goal.flamingo.dart";

class Goal extends PlayerEvent<Goal> {
  Goal({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
    super.ref,
  });

  @Field()
  int? time;

  // Scorer

  @Field()
  DocumentReference? scorer;
  final scorerProvider = StateProvider<Player?>((_) => null);

  // Passer

  @Field()
  DocumentReference? passer;
  final passerProvider = StateProvider<Player?>((_) => null);

  // Overriden

  @override
  int? getTime() => time;

  @override
  DocumentReference<Object?>? getPlayer1() => scorer;

  @override
  StateProvider<Player?> getPlayer1Provider() => scorerProvider;

  @override
  DocumentReference<Object?>? getPlayer2() => passer;

  @override
  StateProvider<Player?> getPlayer2Provider() => passerProvider;

  @override
  Widget? getIcon() => const Icon(Icons.sports_soccer, color: Colors.amber);

  @override
  Widget getTitle(WidgetRef ref) {
    var scorer = getScorer(ref);

    if (scorer != null) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "But de ",
              style: Theme.of(ref.context).textTheme.bodyMedium,
            ),
            TextSpan(
              text: scorer.getName(defaultValue: "-"),
              style: Theme.of(ref.context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    }

    return const Text("Contre son camp");
  }

  @override
  Widget getSubtitle(WidgetRef ref) {
    if (scorer != null) {
      var passer = getPasser(ref);

      if (passer != null) {
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Passe de ",
                style: Theme.of(ref.context).textTheme.labelMedium,
              ),
              TextSpan(
                text: passer.getName(),
                style: Theme.of(ref.context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        );
      }
    }

    return Container();
  }

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
