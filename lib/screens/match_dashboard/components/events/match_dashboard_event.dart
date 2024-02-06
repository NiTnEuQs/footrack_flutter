import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/models/player_event.dart';

class MatchDashboardEvent extends ConsumerWidget {
  const MatchDashboardEvent({
    Key? key,
    required this.event,
    this.startContent,
    this.content,
    this.onEventPress,
    this.onEventLongPress,
  }) : super(key: key);

  final PlayerEvent event;
  final Widget? startContent;
  final Widget? content;
  final Function()? onEventPress;
  final Function()? onEventLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onEventPress,
      onLongPress: onEventLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xs),
        child: Row(
          children: [
            if (startContent != null)
              Padding(
                padding: const EdgeInsets.only(right: Spacing.xs2),
                child: startContent,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
