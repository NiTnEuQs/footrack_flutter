import "package:collection/collection.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:freezed_annotation/freezed_annotation.dart";

class PlayerStatusConverter implements JsonConverter<PlayerStatusEnum?, String> {
  const PlayerStatusConverter();

  @override
  PlayerStatusEnum? fromJson(String? playerStatusString) {
    return PlayerStatusEnum.values.firstWhereOrNull((e) => e.name == playerStatusString);
  }

  @override
  String toJson(PlayerStatusEnum? playerStatus) => playerStatus.format();
}
