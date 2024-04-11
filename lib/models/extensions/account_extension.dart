import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/enums/account_club_roles_enum.dart";
import "package:footrack_front/models/account.dart";
import "package:footrack_front/models/extensions/account_club_extension.dart";

extension AccountExtension on Account {
  // Getters

  bool isAdminInCurrentClub(WidgetRef ref) {
    var currentClubId = ref.watch(clubChoseProvider)?.id ?? "";
    var clubRoles = ref.watch(accountClubsProvider);

    return clubRoles
        .where((e) => e.getRole() == AccountClubRoleEnum.admin)
        .map((e) => e.getClubId())
        .contains(currentClubId);
  }
}

extension AccountNullableExtension on Account? {
  // Getters

  bool isAdminInCurrentClub(WidgetRef ref) => this?.isAdminInCurrentClub(ref) ?? false;
}
