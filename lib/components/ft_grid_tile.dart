import 'package:flutter/material.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/extensions/object_extensions.dart';

class FTGridTile extends StatelessWidget {
  const FTGridTile({
    Key? key,
    required this.icon,
    required this.title,
    this.enabled = true,
    this.color,
    this.titleSize,
    this.iconSize,
    this.titleWeight,
    this.onTap,
    this.onLongPress,
    this.redirection,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final bool enabled;
  final Color? color;
  final double? titleSize;
  final double? iconSize;
  final FontWeight? titleWeight;
  final Widget? redirection;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Card(
        color: enabled ? (color ?? Theme.of(context).primaryColor) : Colors.grey,
        child: InkWell(
          onTap: enabled
              ? () {
                  if (redirection != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => redirection!,
                      ),
                    );
                  } else {
                    onTap?.let((it) {
                      it();
                    });
                  }
                }
              : null,
          onLongPress: enabled ? onLongPress : null,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.xs),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: iconSize,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: titleWeight,
                      fontSize: titleSize,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
