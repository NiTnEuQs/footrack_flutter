import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/models/substitute.dart";

extension SubstituteExtension on Substitute? {
  // Getters

  Player? getPlayerIn(WidgetRef ref) => this?.playerInProvider.let((it) => ref.watch(it));

  Player? getPlayerOut(WidgetRef ref) => this?.playerOutProvider.let((it) => ref.watch(it));
}
