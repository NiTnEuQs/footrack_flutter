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

  Icon icon() => Icon(iconData(), color: iconColor());

  Color iconColor() {
    switch (this) {
      case PlayerRoleEnum.delegate:
        return Colors.amber;
      case PlayerRoleEnum.player:
        return Colors.blue;
      default:
        return Colors.red;
    }
  }

  IconData iconData() {
    switch (this) {
      case PlayerRoleEnum.delegate:
        return Icons.shield;
      case PlayerRoleEnum.player:
        return Icons.sports_soccer;
      default:
        return Icons.question_mark;
    }
  }
}
