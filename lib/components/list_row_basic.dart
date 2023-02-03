import 'package:flutter/material.dart';

class ListRowBasic extends StatelessWidget {
  const ListRowBasic({
    Key? key,
    required this.title,
    this.subtitle,
    this.onClick,
    this.onLongPress,
    this.padding,
    this.centered = false,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Function()? onClick;
  final Function()? onLongPress;

  // Style
  final EdgeInsets? padding;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      onLongPress: onLongPress,
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
        child: Column(
          crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            title,
            if (subtitle != null)
                subtitle!,
          ],
        ),
      ),
    );
  }
}
