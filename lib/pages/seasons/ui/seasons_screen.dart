import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_season.dart";
import "package:footrack_front/components/generics/generic_error.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/dummies/dummy_seasons.dart";
import "package:footrack_front/models/season.dart";
import "package:footrack_front/pages/season/ui/season_screen.dart";
import "package:footrack_front/pages/seasons/components/seasons_list.dart";

class SeasonsScreen extends ConsumerStatefulWidget {
  const SeasonsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends ConsumerState<SeasonsScreen> {
  late StreamSubscription disposeSeasons;

  void _addSeason() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertSeason();
      },
    );
  }

  void _editSeason(Season season) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertSeason(
          season: season,
        );
      },
    );
  }

  void _openSeason(Season season) {
    ref.read(seasonChoseProvider.notifier).state = season;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SeasonScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final seasonsStream = ref.watch(seasonsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vos saisons",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: Spacing.m),
        child: Column(
          children: [
            Expanded(
              child: seasonsStream.when(
                data: (seasons) => SeasonsList(
                  seasons: seasons,
                  onSeasonClick: _openSeason,
                  onSeasonLongClick: _editSeason,
                ),
                error: (e, s) => Scaffold(body: GenericError(error: e)),
                loading: () => Scaffold(
                  body: SeasonsList(
                    isLoading: true,
                    seasons: DummySeason.list,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSeason,
        label: const Text("Créer une saison"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
