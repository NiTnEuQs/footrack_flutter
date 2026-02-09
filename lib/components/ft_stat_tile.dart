import "package:flutter/material.dart";
import "package:footrack_front/app/modifiers.dart";
import "package:footrack_front/core/ui/spacings.dart";

class FTStatTile extends StatelessWidget {
  const FTStatTile({
    super.key,
    required this.value,
    required this.title,
    this.subtitle,
    this.icon,
    this.valueSize,
    this.backgroundColor,
    this.onTap,
    this.onLongPress,
  });

  final String value;
  final double? valueSize;
  final String title;
  final String? subtitle;
  final Icon? icon;
  final Color? backgroundColor;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          spacing: Spacing.xs2,
          children: [
            if (icon != null) icon!,
            Text(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: valueSize,
                  ),
            ),
            Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  subtitle ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ).padding(const EdgeInsets.all(Spacing.m)),
      ),
    );
  }
}
