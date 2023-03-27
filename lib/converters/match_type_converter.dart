import 'package:collection/collection.dart';
import 'package:footrack_front/enums/match_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class MatchTypeConverter implements JsonConverter<MatchTypeEnum, String> {
  const MatchTypeConverter();

  @override
  MatchTypeEnum fromJson(String? matchStatusString) {
    return MatchTypeEnum.values.firstWhereOrNull((e) => e.name == matchStatusString) ?? MatchTypeEnum.championship;
  }

  @override
  String toJson(MatchTypeEnum matchStatus) => matchStatus.format();
}
