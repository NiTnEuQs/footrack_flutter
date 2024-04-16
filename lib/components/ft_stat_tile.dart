import "package:flutter/material.dart";
import "package:footrack_front/core/ui/spacings.dart";

class FTStatTile extends StatelessWidget {
  const FTStatTile({
    super.key,
    required this.value,
    required this.title,
    this.subtitle,
    this.icon,
    this.valueSize,
    this.onTap,
    this.onLongPress,
  });

  final String value;
  final double? valueSize;
  final String title;
  final String? subtitle;
  final Icon? icon;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black.withAlpha(20),
            ),
            left: BorderSide(
              color: Colors.black.withAlpha(20),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xs),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (icon != null) icon!,
              Text(
                value,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
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
          ),
        ),
      ),
    );
  }
}
