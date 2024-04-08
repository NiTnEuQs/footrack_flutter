import 'package:flutter/material.dart';

enum AccountClubRoleEnum {
  admin,
  follower,
}

extension ClubRoleEnumExtension on AccountClubRoleEnum? {
  String format() {
    switch (this) {
      case AccountClubRoleEnum.admin:
        return "Administrateur";
      case AccountClubRoleEnum.follower:
        return "Follower";
      default:
        return "Pas de rôle";
    }
  }

  Icon icon() {
    switch (this) {
      case AccountClubRoleEnum.admin:
        return const Icon(Icons.shield, color: Colors.amber);
      case AccountClubRoleEnum.follower:
        return const Icon(Icons.follow_the_signs, color: Colors.lightGreen);
      default:
        return const Icon(Icons.question_mark, color: Colors.red);
    }
  }
}
