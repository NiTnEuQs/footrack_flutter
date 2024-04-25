import "package:flutter/material.dart";

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.backgroundIcon,
    this.backgroundColor,
    this.onClick,
    this.onLongClick,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Widget? backgroundIcon;
  final Color? backgroundColor;
  final Function()? onClick;
  final Function()? onLongClick;

  @override
  Widget build(BuildContext context) {
    final backgroundIcon = this.backgroundIcon;

    return Card(
      color: backgroundColor,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          ListTile(
            onTap: onClick,
            onLongPress: onLongClick,
            title: title,
            subtitle: subtitle,
            leading: leading,
            trailing: trailing,
          ),
          if (backgroundIcon != null) backgroundIcon,
        ],
      ),
    );
  }
}
