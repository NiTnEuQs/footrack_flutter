import "package:flutter/material.dart";
import "package:flutter/widget_previews.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/models/club.dart";
import "package:footrack_front/models/extensions/club_extension.dart";

@Preview(
  name: "Club modal",
)
Widget clubModalPreview() => ProviderScope(child: const AlertClub());

class AlertClub extends ConsumerStatefulWidget {
  const AlertClub({
    super.key,
    this.club,
  });

  final Club? club;

  @override
  ConsumerState<AlertClub> createState() => _AlertClubState();
}

class _AlertClubState extends ConsumerState<AlertClub> {
  final TextEditingController _clubTeamNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _clubTeamNameController.text = widget.club.getTeamName();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          widget.club != null ? "Modifier votre club" : "Créer votre club"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _clubTeamNameController,
            decoration: const InputDecoration(
              hintText: "Nom du club",
            ),
          ),
        ],
      ),
      actions: [
        if (widget.club != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return AlertDialog(
                        title: const Text(
                            "Êtes-vous sûr de vouloir supprimer le club ?"),
                        content: Text(widget.club.getTeamName()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Annuler"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref.read(dbProvider).removeClub(widget.club!.id);

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                            ),
                            child: const Text("Supprimer"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.redAccent,
            ),
            child: const Text("Supprimer"),
          ),
        ElevatedButton(
          onPressed: () {
            var club = Club()..teamName = _clubTeamNameController.value.text;

            if (widget.club != null) {
              ref.read(dbProvider).editClub(
                    widget.club!.id,
                    club,
                  );
            } else {
              final user = ref.read(userProvider);
              if (user != null) {
                ref.read(dbProvider).addNewClub(club, user.uid);
              }
            }

            Navigator.pop(context);
          },
          child: Text(widget.club != null ? "Modifier" : "Créer"),
        ),
      ],
    );
  }
}
