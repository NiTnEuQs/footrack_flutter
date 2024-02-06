import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  const TextIcon({
    super.key,
    this.text,
    this.textStyle,
    this.icon,
    this.iconColor,
    this.iconSize,
  });

  final String? text;
  final TextStyle? textStyle;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        if (text != null)
          Text(
            text!,
            style: textStyle,
          ),
      ],
    );
  }
}
