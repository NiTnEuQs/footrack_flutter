import "package:flutter/material.dart";

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.onClick,
    this.onLongClick,
  });

  final String title;
  final String subtitle;
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
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
