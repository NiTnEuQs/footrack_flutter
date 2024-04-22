import "package:flutter/material.dart";
import "package:footrack_front/core/ui/spacings.dart";

class TextIcon extends StatelessWidget {
  const TextIcon({
    super.key,
    required this.text,
    required this.icon,
    this.interspace = Spacing.xs2,
    this.expanded = false,
    this.alignment = MainAxisAlignment.start,
    this.crossAlignment = CrossAxisAlignment.center,
  });

  final Widget text;
  final Widget icon;
  final double interspace;
  final bool expanded;
  final MainAxisAlignment alignment;
  final CrossAxisAlignment crossAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: alignment,
      crossAxisAlignment: crossAlignment,
      children: [icon, SizedBox(width: interspace), text],
    );
  }
}
