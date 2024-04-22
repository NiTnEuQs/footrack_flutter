import "package:flutter/material.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/extensions/widget_extensions.dart";

class GenericMessage extends StatelessWidget {
  const GenericMessage({
    super.key,
    this.title,
    required this.message,
  });

  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final hasTitle = title != null;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ).showIf(hasTitle),
          const SizedBox(height: Spacing.m).showIf(hasTitle),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
