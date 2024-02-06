import 'package:flutter/material.dart';

class SeasonsListFab extends StatelessWidget {
  const SeasonsListFab({
    super.key,
    this.onPress,
  });

  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      tooltip: "Créer une saison",
      child: const Icon(Icons.add),
    );
  }
}
