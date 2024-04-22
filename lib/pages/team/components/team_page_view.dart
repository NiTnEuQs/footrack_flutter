import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/models/extensions/player_extension.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/pages/team/components/team_list.dart";

class TeamPageView extends ConsumerWidget {
  const TeamPageView({
    super.key,
    required this.team,
    this.isLoading = false,
    this.pageController,
    this.onPlayerClick,
    this.onPlayerLongClick,
  });

  final List<Player> team;
  final bool isLoading;
  final PageController? pageController;
  final Function(Player)? onPlayerClick;
  final Function(Player)? onPlayerLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = team.where((element) => element.getRole() == PlayerRoleEnum.player).toList();
    final delegates = team.where((element) => element.getRole() == PlayerRoleEnum.delegate).toList();

    return PageView(
      controller: pageController,
      children: [
        TeamList(
          players: players,
          shrinkWrap: true,
          onPlayerClick: onPlayerClick,
          onPlayerLongClick: onPlayerLongClick,
        ),
        TeamList(
          players: delegates,
          shrinkWrap: true,
          onPlayerClick: onPlayerClick,
          onPlayerLongClick: onPlayerLongClick,
        ),
      ],
    );
  }
}
