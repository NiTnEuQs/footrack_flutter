import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/components/generics/generic_message.dart";
import "package:footrack_front/components/list_item.dart";
import "package:footrack_front/models/club.dart";
import "package:footrack_front/models/extensions/club_extension.dart";
import "package:skeletonizer/skeletonizer.dart";

class ClubsList extends StatelessWidget {
  const ClubsList({
    super.key,
    required this.clubs,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.onClubClick,
    this.onClubLongClick,
  });

  final List<Club> clubs;
  final bool isLoading;
  final bool shrinkWrap;
  final Function(Club)? onClubClick;
  final Function(Club)? onClubLongClick;

  @override
  Widget build(BuildContext context) {
    if (clubs.isEmpty) {
      return const _ClubsListEmpty();
    } else {
      return _ClubsListFilled(
        clubs: clubs,
        isLoading: isLoading,
        shrinkWrap: shrinkWrap,
        onClubClick: onClubClick,
        onClubLongClick: onClubLongClick,
      );
    }
  }
}

class _ClubsListEmpty extends StatelessWidget {
  const _ClubsListEmpty();

  @override
  Widget build(BuildContext context) {
    return const GenericMessage(
      message: "La liste des clubs est vide",
    );
  }
}

class _ClubsListFilled extends ConsumerWidget {
  const _ClubsListFilled({
    required this.clubs,
    this.isLoading = false,
    this.shrinkWrap = false,
    this.onClubClick,
    this.onClubLongClick,
  });

  final List<Club> clubs;
  final bool isLoading;
  final bool shrinkWrap;
  final Function(Club)? onClubClick;
  final Function(Club)? onClubLongClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    clubs.sort(
      (e1, e2) => e1.getTeamName().compareTo(e2.getTeamName()),
    );

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];

          return ListItem(
            title: Text(
              club.getTeamName(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onClick: () {
              onClubClick?.call(club);
            },
            onLongClick: () {
              onClubLongClick?.call(club);
            },
          );
        },
      ),
    );
  }
}

