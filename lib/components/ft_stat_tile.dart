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
    this.titleSize,
    this.subtitleSize,
    this.onTap,
    this.onLongPress,
  });

  final String value;
  final double? valueSize;
  final String title;
  final double? titleSize;
  final String? subtitle;
  final double? subtitleSize;
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
                style: TextStyle(
                  fontSize: valueSize ?? 38,
                ),
              ),
              Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleSize ?? 16,
                    ),
                  ),
                  Text(
                    subtitle ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: subtitleSize ?? 12,
                      color: Colors.grey,
                    ),
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
