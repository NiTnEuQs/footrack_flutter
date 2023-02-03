import 'package:flutter/material.dart';

class FootrackGridTile extends StatelessWidget {
  const FootrackGridTile({
    Key? key,
    required this.icon,
    required this.title,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.redirection,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final bool enabled;
  final Widget? redirection;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Card(
        color: enabled ? Colors.blue : Colors.grey,
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
                  } else if (onTap != null) {
                    onTap!();
                  }
                }
              : null,
          onLongPress: enabled
              ? () {
                  if (onLongPress != null) {
                    onLongPress!();
                  }
                }
              : null,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
