import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/goal.dart";
import "package:footrack_front/models/player.dart";

extension GoalExtension on Goal? {
  // Getters

  Player? getScorer(WidgetRef ref) => this?.scorerProvider.let((it) => ref.watch(it));

  Player? getPasser(WidgetRef ref) => this?.passerProvider.let((it) => ref.watch(it));
}
