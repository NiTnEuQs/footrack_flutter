import 'package:flutter/material.dart';

class SeasonsListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SeasonsListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Vos saisons"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
