import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/screens/players_list/components/players_list_body_empty.dart';
import 'package:footrack_front/screens/players_list/components/players_list_body_filled.dart';

class PlayersListBody extends ConsumerWidget {
  const PlayersListBody({
    super.key,
    this.onPlayerLongPress,
  });

  final Function(Player)? onPlayerLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var season = ref.watch(selectedSeasonProvider);
    var players = ref.watch(season.playersProvider);

    return players.isEmpty
        ? const PlayersListBodyEmpty()
        : PlayersListBodyFilled(
            players: players,
            onPlayerLongPress: onPlayerLongPress,
          );
  }
}
