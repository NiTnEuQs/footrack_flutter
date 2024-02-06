import 'package:flutter/material.dart';

class PlayersListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PlayersListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Vos joueurs"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
