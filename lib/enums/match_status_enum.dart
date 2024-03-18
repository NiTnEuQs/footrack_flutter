import 'package:flutter/material.dart';

enum MatchStatusEnum {
  none,
  playingFirst,
  pausedFirst,
  playingSecond,
  pausedSecond,
  finished,
}

extension MatchStatusEnumExtension on MatchStatusEnum? {
  String format() {
    switch (this) {
      case MatchStatusEnum.playingFirst:
        return "1ère mi-temps";
      case MatchStatusEnum.pausedFirst:
        return "1ère mi-temps - Temps mort";
      case MatchStatusEnum.playingSecond:
        return "2ème mi-temps";
      case MatchStatusEnum.pausedSecond:
        return "2ème mi-temps - Temps mort";
      default:
        return "Non débuté";
    }
  }

  Icon icon() {
    switch (this) {
      case MatchStatusEnum.playingFirst:
        return const Icon(Icons.hourglass_bottom, color: Colors.lightGreen);
      case MatchStatusEnum.pausedFirst:
        return const Icon(Icons.hourglass_bottom, color: Colors.red);
      case MatchStatusEnum.playingSecond:
        return const Icon(Icons.hourglass_full, color: Colors.lightGreen);
      case MatchStatusEnum.pausedSecond:
        return const Icon(Icons.hourglass_full, color: Colors.red);
      default:
        return const Icon(Icons.question_mark, color: Colors.red);
    }
  }
}
