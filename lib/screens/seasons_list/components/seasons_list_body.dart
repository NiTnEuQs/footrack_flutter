import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/generics/generic_loading.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';
import 'package:footrack_front/screens/seasons_list/components/seasons_list_body_bottom.dart';
import 'package:footrack_front/components/generics/generic_error.dart';
import 'package:footrack_front/screens/seasons_list/components/seasons_list_body_empty.dart';
import 'package:footrack_front/screens/seasons_list/components/seasons_list_body_filled.dart';

class SeasonsListBody extends ConsumerWidget {
  const SeasonsListBody({
    Key? key,
    this.onSeasonPress,
    this.onSeasonLongPress,
  }) : super(key: key);

  final Function(Season)? onSeasonPress;
  final Function(Season)? onSeasonLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var seasonsStream = ref.watch(seasonsStreamProvider);

    return Column(
      children: [
        Expanded(
          child: seasonsStream.when(
            data: (seasons) => seasons.isEmpty
                ? const SeasonsListBodyEmpty()
                : SeasonsListBodyFilled(
                    seasons: seasons,
                    onSelectChanged: onSeasonPress,
                    onLongPressed: onSeasonLongPress,
                  ),
            error: (error, stacktrace) => GenericError(error: error),
            loading: () => const GenericLoading(),
          ),
          // child:
        ),
        const SeasonsListBodyBottom()
      ],
    );
  }
}
