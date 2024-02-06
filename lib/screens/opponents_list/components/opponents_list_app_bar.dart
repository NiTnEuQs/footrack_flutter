import 'package:flutter/material.dart';

class OpponentsListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OpponentsListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Vos adversaires"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
