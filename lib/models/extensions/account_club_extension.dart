import 'package:footrack_front/converters/club_role_converter.dart';
import 'package:footrack_front/enums/account_club_roles_enum.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/account_club.dart';

extension AccountClubExtension on AccountClub {
  // Getters

  String getClubId() => id;
}

extension AccountClubNullableExtension on AccountClub? {
  // Getters

  AccountClubRoleEnum getRole({AccountClubRoleEnum defaultValue = AccountClubRoleEnum.follower}) =>
      this?.role?.let((it) => const ClubRoleConverter().fromJson(it)) ?? defaultValue;
}
