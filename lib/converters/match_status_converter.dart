import 'package:collection/collection.dart';
import 'package:footrack_front/enums/match_status_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class MatchStatusConverter implements JsonConverter<MatchStatusEnum, String> {
  const MatchStatusConverter();

  @override
  MatchStatusEnum fromJson(String? matchStatusString) {
    return MatchStatusEnum.values.firstWhereOrNull((e) => e.name == matchStatusString) ?? MatchStatusEnum.none;
  }

  @override
  String toJson(MatchStatusEnum matchStatus) => matchStatus.format();
}
