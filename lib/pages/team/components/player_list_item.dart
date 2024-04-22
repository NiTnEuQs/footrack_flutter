import "package:flutter/material.dart";
import "package:footrack_front/components/list_item.dart";
import "package:footrack_front/extensions/object_extensions.dart";

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({
    super.key,
    required this.name,
    this.birthdate,
    this.profilePicture,
    this.status,
    this.backgroundColor,
    this.onClick,
    this.onLongClick,
  });

  final String name;
  final String? birthdate;
  final Widget? profilePicture;
  final String? status;
  final Color? backgroundColor;
  final Function()? onClick;
  final Function()? onLongClick;

  @override
  Widget build(BuildContext context) {
    return ListItem(
      backgroundColor: backgroundColor,
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: status?.let(
        (it) => Text(
          it,
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
      onClick: onClick,
      onLongClick: onLongClick,
    );
  }
}
