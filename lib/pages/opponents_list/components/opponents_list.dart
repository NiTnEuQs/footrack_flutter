import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/list_item.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/opponent_extension.dart";
import "package:footrack_front/models/opponent.dart";
import "package:skeletonizer/skeletonizer.dart";

class OpponentsList extends ConsumerWidget {
  const OpponentsList({
    super.key,
    required this.opponents,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.onOpponentClick,
    this.onOpponentLongClick,
  });

  final List<Opponent> opponents;
  final bool isLoading;
  final bool shrinkWrap;
  final Function(Opponent)? onOpponentClick;
  final Function(Opponent)? onOpponentLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    opponents.sort(
      (e1, e2) => e1.getName().compare(e2.getName()),
    );

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: opponents.length,
        itemBuilder: (context, index) {
          final opponent = opponents[index];

          return ListItem(
            title: opponent.getName(),
            onClick: () {
              onOpponentClick?.call(opponent);
            },
            onLongClick: () {
              onOpponentLongClick?.call(opponent);
            },
          );
        },
      ),
    );
  }
}
