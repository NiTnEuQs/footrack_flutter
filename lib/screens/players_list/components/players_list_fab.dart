import 'package:flutter/material.dart';

class PlayersListFab extends StatelessWidget {
  const PlayersListFab({
    super.key,
    this.onPress,
  });

  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      tooltip: "Ajouter un joueur",
      child: const Icon(Icons.add),
    );
  }
}
