import 'package:collection/collection.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class PlayerRoleConverter implements JsonConverter<PlayerRoleEnum, String> {
  const PlayerRoleConverter();

  @override
  PlayerRoleEnum fromJson(String? playerRoleString) {
    return PlayerRoleEnum.values.firstWhereOrNull((e) => e.name == playerRoleString) ?? PlayerRoleEnum.none;
  }

  @override
  String toJson(PlayerRoleEnum playerRole) => playerRole.format();
}
