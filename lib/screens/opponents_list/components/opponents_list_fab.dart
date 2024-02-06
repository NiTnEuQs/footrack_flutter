import 'package:flutter/material.dart';

class OpponentsListFab extends StatelessWidget {
  const OpponentsListFab({
    super.key,
    this.onPress,
  });

  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      tooltip: "Ajouter un adversaire",
      child: const Icon(Icons.add),
    );
  }
}
