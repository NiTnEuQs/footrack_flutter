import 'package:flutter/material.dart';

enum PlayerStatusEnum {
  none,
  valid,
  injured,
  suspended,
  unavailable,
}

extension PlayerStatusEnumExtension on PlayerStatusEnum? {
  String format() {
    switch (this) {
      case PlayerStatusEnum.valid:
        return "Disponible";
      case PlayerStatusEnum.injured:
        return "Blessé";
      case PlayerStatusEnum.suspended:
        return "Suspendu";
      case PlayerStatusEnum.unavailable:
        return "Indisponible";
      default:
        return "Pas de status";
    }
  }

  Icon icon() {
    switch (this) {
      case PlayerStatusEnum.valid:
        return const Icon(Icons.noise_control_off, color: Colors.lightGreen);
      case PlayerStatusEnum.injured:
        return const Icon(Icons.medical_services, color: Colors.red);
      case PlayerStatusEnum.suspended:
        return const Icon(Icons.square_rounded, color: Colors.red);
      case PlayerStatusEnum.unavailable:
        return const Icon(Icons.block, color: Colors.red);
      default:
        return const Icon(Icons.question_mark, color: Colors.red);
    }
  }
}
