import "package:flutter/material.dart";
import "package:footrack_front/components/list_item.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/enums/player_roles_enum.dart";
import "package:footrack_front/enums/player_status_enum.dart";
import "package:footrack_front/extensions/object_extensions.dart";

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({
    super.key,
    required this.name,
    this.birthdate,
    this.profilePicture,
    this.status,
    this.role,
    this.backgroundColor,
    this.onClick,
    this.onLongClick,
  });

  final String name;
  final String? birthdate;
  final Widget? profilePicture;
  final PlayerStatusEnum? status;
  final PlayerRoleEnum? role;
  final Color? backgroundColor;
  final Function()? onClick;
  final Function()? onLongClick;

  @override
  Widget build(BuildContext context) {
    final role = this.role;

    return ListItem(
      backgroundColor: backgroundColor,
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: status?.let(
        (it) => Text(
          it.format(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.black87,
              ),
        ),
      ),
      leading: profilePicture,
      trailing: birthdate?.let(
        (it) => Text(
          it,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      backgroundIcon: role != null
          ? Positioned(
              right: -Spacing.xs,
              bottom: -Spacing.xs,
              child: Icon(
                role.iconData(),
                color: role.iconColor().withAlpha(150),
                size: Spacing.xl3,
              ),
            )
          : null,
      onClick: onClick,
      onLongClick: onLongClick,
    );
  }
}
