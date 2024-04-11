import "package:collection/collection.dart";
import "package:footrack_front/enums/account_club_roles_enum.dart";
import "package:freezed_annotation/freezed_annotation.dart";

class ClubRoleConverter implements JsonConverter<AccountClubRoleEnum?, String> {
  const ClubRoleConverter();

  @override
  AccountClubRoleEnum? fromJson(String? clubRoleString) {
    return AccountClubRoleEnum.values.firstWhereOrNull((e) => e.name == clubRoleString);
  }

  @override
  String toJson(AccountClubRoleEnum? clubRole) => clubRole.format();
}
