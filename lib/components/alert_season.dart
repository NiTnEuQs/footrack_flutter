import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/utils/pickers.dart';

class AlertSeason extends StatelessWidget {
  AlertSeason({
    Key? key,
    required this.ref,
    this.season,
  }) : super(key: key);

  final WidgetRef ref;
  final Season? season;

  final TextEditingController _seasonNameController = TextEditingController();
  final TextEditingController _seasonTeamNameController = TextEditingController();
  final TextEditingController _seasonDateStartController = TextEditingController();
  final TextEditingController _seasonDateEndController = TextEditingController();

  DateTime? dateStartPicked;
  DateTime? dateEndPicked;

  _initState() {
    if (season != null) {
      _seasonNameController.text = season!.name;
      _seasonTeamNameController.text = season!.teamName ?? "";
      _seasonDateStartController.text = season!.from.format();
      _seasonDateEndController.text = season!.to.format();

      dateStartPicked = season!.from;
      dateEndPicked = season!.to;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initState();

    return AlertDialog(
      title: Text(season != null ? "Modifier votre saison" : "Créer votre saison"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _seasonNameController,
            decoration: const InputDecoration(
              hintText: "Nom de la saison",
            ),
          ),
          TextFormField(
            controller: _seasonTeamNameController,
            decoration: const InputDecoration(
              hintText: "Nom du club",
            ),
          ),
          TextFormField(
            controller: _seasonDateStartController,
            decoration: const InputDecoration(
              hintText: "Date de début",
            ),
            readOnly: true,
            onTap: () {
              datePicker(context).then(
                (value) => {
                  if (value != null)
                    {
                      dateStartPicked = value,
                      _seasonDateStartController.text = value.format(),
                    }
                },
              );
            },
          ),
          TextFormField(
            controller: _seasonDateEndController,
            decoration: const InputDecoration(
              hintText: "Date de fin",
            ),
            readOnly: true,
            onTap: () {
              datePicker(context).then(
                (value) => {
                  if (value != null)
                    {
                      dateEndPicked = value,
                      _seasonDateEndController.text = value.format(),
                    }
                },
              );
            },
          ),
        ],
      ),
      actions: [
        if (season != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Êtes-vous sûr de vouloir supprimer la saison ?"),
                    content: Text(season!.name),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          ref.watch(seasonsProvider).removeSeason(season!.id);

                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return Colors.red;
                            },
                          ),
                        ),
                        child: const Text("Supprimer"),
                      ),
                    ],
                  );
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return Colors.red;
                },
              ),
            ),
            child: const Text("Supprimer"),
          ),
        ElevatedButton(
          onPressed: () {
            if (season != null) {
              ref.read(seasonsProvider).editSeason(
                    Season(
                      name: _seasonNameController.value.text,
                      teamName: _seasonTeamNameController.value.text,
                      from: dateStartPicked,
                      to: dateEndPicked,
                    ),
                    season!.id,
                  );
            } else {
              ref.read(seasonsProvider).addNewSeason(
                    Season(
                      name: _seasonNameController.value.text,
                      teamName: _seasonTeamNameController.value.text,
                      from: dateStartPicked,
                      to: dateEndPicked,
                    ),
                  );
            }

            Navigator.pop(context);
          },
          child: Text(season != null ? "Modifier" : "Créer"),
        ),
      ],
    );
  }
}
