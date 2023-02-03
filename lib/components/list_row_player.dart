import 'package:flutter/material.dart';

class ListRowPlayer extends StatelessWidget {
  const ListRowPlayer({
    Key? key,
    required this.title,
    this.subtitle,
    this.apparitions = const Text("0"),
    this.goals = const Text("0"),
    this.passes = const Text("0"),
    this.onClick,
    this.onLongPress,
    this.padding,
    this.centered = false,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget apparitions;
  final Widget goals;
  final Widget passes;
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  title,
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),
            SizedBox(
              width: 25,
              child: apparitions,
            ),
            SizedBox(
              width: 25,
              child: goals,
            ),
            SizedBox(
              width: 25,
              child: passes,
            ),
          ],
        ),
      ),
    );
  }
}
