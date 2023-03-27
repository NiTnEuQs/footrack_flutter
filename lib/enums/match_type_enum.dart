import 'package:flutter/material.dart';

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

  Icon icon() {
    switch (this) {
      case MatchTypeEnum.cup:
        return const Icon(Icons.military_tech, color: Colors.amber);
      case MatchTypeEnum.championship:
      default:
        return const Icon(Icons.military_tech, color: Colors.blue);
    }
  }
}
