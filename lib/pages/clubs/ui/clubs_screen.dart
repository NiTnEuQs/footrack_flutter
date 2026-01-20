import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/alert_club.dart";
import "package:footrack_front/components/generics/generic_error.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/dummies/dummy_clubs.dart";
import "package:footrack_front/models/club.dart";
import "package:footrack_front/pages/clubs/components/clubs_list.dart";
import "package:footrack_front/pages/seasons/ui/seasons_screen.dart";

class ClubsScreen extends ConsumerStatefulWidget {
  const ClubsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends ConsumerState<ClubsScreen> {
  void _addClub() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertClub();
      },
    );
  }

  void _editClub(Club club) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertClub(
          club: club,
        );
      },
    );
  }

  void _openClub(Club club) {
    ref.read(clubChoseProvider.notifier).state = club;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SeasonsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clubsStream = ref.watch(clubsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vos clubs",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: Spacing.m),
        child: clubsStream.when(
          data: (clubs) => ClubsList(
            clubs: clubs,
            onClubClick: _openClub,
            onClubLongClick: _editClub,
          ),
          error: (e, s) => Scaffold(body: GenericError(error: e)),
          loading: () => Scaffold(
            body: ClubsList(
              isLoading: true,
              clubs: DummyClub.list,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addClub,
        label: const Text("Créer un club"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
