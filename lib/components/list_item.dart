import "package:flutter/material.dart";
import "package:footrack_front/extensions/object_extensions.dart";

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onClick,
    this.onLongClick,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Function()? onClick;
  final Function()? onLongClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: onClick,
        onLongPress: onLongClick,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: subtitle?.let(
          (it) => Text(
            it,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        leading: leading,
        trailing: trailing,
      ),
    );
  }
}
