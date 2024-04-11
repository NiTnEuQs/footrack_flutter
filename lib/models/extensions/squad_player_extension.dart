import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/models/squad_player.dart";

extension SquadPlayerExtension on SquadPlayer? {
  // Getters

  Player? getPlayer(WidgetRef ref) => this?.playerProvider.let((it) => ref.watch(it));
}
