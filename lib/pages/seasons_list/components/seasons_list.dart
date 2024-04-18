import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/list_item.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/season.dart";
import "package:skeletonizer/skeletonizer.dart";

class SeasonsList extends ConsumerWidget {
  const SeasonsList({
    super.key,
    required this.seasons,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.onSeasonClick,
    this.onSeasonLongClick,
  });

  final List<Season> seasons;
  final bool isLoading;
  final bool shrinkWrap;
  final Function(Season)? onSeasonClick;
  final Function(Season)? onSeasonLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    seasons.sort(
        (e1, e2) => e1.getFrom().compare(e2.getFrom()),
    );

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: seasons.length,
        itemBuilder: (context, index) {
          final season = seasons[index];

          return ListItem(
            title: season.getName(),
            subtitle: "${season.getFrom().format()}${season.getTo() != null ? " - " : ""}${season.getTo().format()}",
            onClick: () {
              onSeasonClick?.call(season);
            },
            onLongClick: () {
              onSeasonLongClick?.call(season);
            },
          );
        },
      ),
    );
  }
}
