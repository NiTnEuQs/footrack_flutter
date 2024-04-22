import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/squad_player_extension.dart";
import "package:footrack_front/models/squad_player.dart";
import "package:footrack_front/pages/team/components/player_list_item.dart";
import "package:skeletonizer/skeletonizer.dart";

class SquadList extends ConsumerWidget {
  const SquadList({
    super.key,
    required this.squad,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.onPlayerClick,
    this.onPlayerLongClick,
  });

  final List<SquadPlayer> squad;
  final bool isLoading;
  final bool shrinkWrap;
  final Function(SquadPlayer)? onPlayerClick;
  final Function(SquadPlayer)? onPlayerLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    squad.sort(
      (e1, e2) => e1.getPlayer(ref).getName().compare(e2.getPlayer(ref).getName()),
    );

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: squad.length,
        itemBuilder: (context, index) {
          final squadPlayer = squad[index];
          final player = squadPlayer.getPlayer(ref);

          return PlayerListItem(
            backgroundColor: player.getStatus().color().withAlpha(100),
            name: player.getName(),
            birthdate: player.getBirthDate().format(),
            status: player.getStatus().format(),
            profilePicture: CircleAvatar(
              backgroundColor: player.getStatus().color(),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            onClick: () {
              onPlayerClick?.call(squadPlayer);
            },
            onLongClick: () {
              onPlayerLongClick?.call(squadPlayer);
            },
          );
        },
      ),
    );
  }
}
