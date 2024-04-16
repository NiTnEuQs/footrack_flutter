import "package:flutter/material.dart";
import "package:footrack_front/core/ui/spacings.dart";

class GenericLoading extends StatelessWidget {
  const GenericLoading({
    super.key,
    this.text = "",
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: Spacing.xs),
          Text(text),
        ],
      ),
    );
  }
}
