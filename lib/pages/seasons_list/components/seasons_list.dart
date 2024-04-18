import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/list_item.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/season.dart";
import "package:skeletonizer/skeletonizer.dart";

class SeasonsList extends ConsumerWidget {
  const SeasonsList({
    super.key,
    required this.seasons,
    this.isLoading = false,
    this.onSeasonClick,
    this.onSeasonLongClick,
  });

  final List<Season> seasons;
  final bool isLoading;
  final Function(Season)? onSeasonClick;
  final Function(Season)? onSeasonLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
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
