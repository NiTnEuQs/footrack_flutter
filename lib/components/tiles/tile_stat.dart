import 'package:flutter/material.dart';
import 'package:footrack_front/core/ui/spacings.dart';

class StatTile extends StatelessWidget {
  const StatTile({
    Key? key,
    required this.value,
    this.title,
    this.subtitle,
    this.icon,
    this.valueSize = 38,
    this.titleSize = 16,
    this.subtitleSize = 12,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final String value;
  final double valueSize;
  final String? title;
  final double titleSize;
  final String? subtitle;
  final double subtitleSize;
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
              icon?.build(context) ?? Container(),
              Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: valueSize,
                ),
              ),
              if (title != null || subtitle != null)
                Column(
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: titleSize,
                        ),
                      ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: subtitleSize,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
