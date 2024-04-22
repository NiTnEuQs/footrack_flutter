import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/extensions/squad_player_extension.dart";
import "package:footrack_front/models/squad_player.dart";
import "package:footrack_front/pages/squad/components/squad_list.dart";

class SquadPageView extends ConsumerWidget {
  const SquadPageView({
    super.key,
    required this.squad,
    this.isLoading = false,
    this.pageController,
    this.onPlayerClick,
    this.onPlayerLongClick,
  });

  final List<SquadPlayer> squad;
  final bool isLoading;
  final PageController? pageController;
  final Function(SquadPlayer)? onPlayerClick;
  final Function(SquadPlayer)? onPlayerLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = squad.where((element) => element.getPlayer(ref).getRole() == PlayerRoleEnum.player).toList();
    final delegates = squad.where((element) => element.getPlayer(ref).getRole() == PlayerRoleEnum.delegate).toList();

    return PageView(
      controller: pageController,
      children: [
        SquadList(
          squad: players,
          shrinkWrap: true,
          onPlayerClick: onPlayerClick,
          onPlayerLongClick: onPlayerLongClick,
        ),
        SquadList(
          squad: delegates,
          shrinkWrap: true,
          onPlayerClick: onPlayerClick,
          onPlayerLongClick: onPlayerLongClick,
        ),
      ],
    );
  }
}
