import "package:flutter/material.dart";

enum MatchTypeEnum {
  championship,
  cup,
}

extension MatchTypeEnumExtension on MatchTypeEnum? {
  String format() {
    switch (this) {
      case MatchTypeEnum.cup:
        return "Coupe";
      case MatchTypeEnum.championship:
      default:
        return "Championnat";
    }
  }

  Icon icon() => Icon(iconData(), color: iconColor());

  Color iconColor() {
    switch (this) {
      case MatchTypeEnum.cup:
        return Colors.amber;
      case MatchTypeEnum.championship:
      default:
        return Colors.blue;
    }
  }

  IconData iconData() {
    switch (this) {
      case MatchTypeEnum.cup:
        return Icons.emoji_events;
      case MatchTypeEnum.championship:
      default:
        return Icons.military_tech;
    }
  }
}
