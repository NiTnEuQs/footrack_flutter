import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/generics/generic_message.dart";
import "package:footrack_front/components/list_item.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/season.dart";
import "package:skeletonizer/skeletonizer.dart";

class SeasonsList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (seasons.isEmpty) {
      return const _SeasonsListEmpty();
    } else {
      return _SeasonsListFilled(
        seasons: seasons,
        isLoading: isLoading,
        shrinkWrap: shrinkWrap,
        onSeasonClick: onSeasonClick,
        onSeasonLongClick: onSeasonLongClick,
      );
    }
  }
}

class _SeasonsListEmpty extends StatelessWidget {
  const _SeasonsListEmpty();

  @override
  Widget build(BuildContext context) {
    return const GenericMessage(
      message: "La liste des saisons est vide",
    );
  }
}

class _SeasonsListFilled extends ConsumerWidget {
  const _SeasonsListFilled({
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
      (e1, e2) => e2.getFrom().compare(e1.getFrom()),
    );

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: seasons.length,
        itemBuilder: (context, index) {
          final season = seasons[index];

          return ListItem(
            title: Text(
              season.getName(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              "${season.getFrom().format()}${season.getTo() != null ? " - " : ""}${season.getTo().format()}",
              style: Theme.of(context).textTheme.labelMedium,
            ),
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
