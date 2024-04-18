import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/list_item.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/player.dart";
import "package:skeletonizer/skeletonizer.dart";

class PlayersList extends ConsumerWidget {
  const PlayersList({
    super.key,
    required this.players,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.onPlayerClick,
    this.onPlayerLongClick,
  });

  final List<Player> players;
  final bool isLoading;
  final bool shrinkWrap;
  final Function(Player)? onPlayerClick;
  final Function(Player)? onPlayerLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    players.sort(
      (e1, e2) => e1.getName().compare(e2.getName()),
    );

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];

          return ListItem(
            title: player.getName(),
            subtitle: player.getBirthDate().format(),
            leading: CircleAvatar(
              backgroundColor: player.getStatus().color(),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            // trailing: player.getStatus().icon(),
            onClick: () {
              onPlayerClick?.call(player);
            },
            onLongClick: () {
              onPlayerLongClick?.call(player);
            },
          );
        },
      ),
    );
  }
}
