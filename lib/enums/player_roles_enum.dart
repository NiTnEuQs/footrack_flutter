import "package:flutter/material.dart";

enum PlayerRoleEnum {
  player,
  delegate,
}

extension PlayerRoleEnumExtension on PlayerRoleEnum? {
  String format() {
    switch (this) {
      case PlayerRoleEnum.player:
        return "Joueur";
      case PlayerRoleEnum.delegate:
        return "Délégué";
      default:
        return "Pas de rôle";
    }
  }

  Icon icon() {
    switch (this) {
      case PlayerRoleEnum.delegate:
        return const Icon(Icons.shield, color: Colors.amber);
      case PlayerRoleEnum.player:
        return const Icon(Icons.sports_soccer, color: Colors.lightGreen);
      default:
        return const Icon(Icons.question_mark, color: Colors.red);
    }
  }
}
