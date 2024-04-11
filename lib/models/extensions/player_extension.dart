import "package:footrack_front/converters/player_role_converter.dart";
import "package:footrack_front/converters/player_status_converter.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/player.dart";

extension PlayerExtension on Player? {
  // Getters

  String getName({String defaultValue = ""}) => this?.name ?? defaultValue;

  PlayerRoleEnum getRole({PlayerRoleEnum defaultValue = PlayerRoleEnum.player}) =>
      this?.role?.let((it) => const PlayerRoleConverter().fromJson(it)) ?? defaultValue;

  PlayerStatusEnum getStatus({PlayerStatusEnum defaultValue = PlayerStatusEnum.valid}) =>
      this?.status?.let((it) => const PlayerStatusConverter().fromJson(it)) ?? defaultValue;

  DateTime? getBirthDate({DateTime? defaultValue}) => this?.birthdate.toDateTime() ?? defaultValue;
}
