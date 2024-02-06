import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/global_providers.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/utils/pickers.dart';

class AlertSeason extends StatefulWidget {
  const AlertSeason({
    Key? key,
    required this.ref,
    this.season,
  }) : super(key: key);

  final WidgetRef ref;
  final Season? season;

  @override
  State<AlertSeason> createState() => _AlertSeasonState();
}

class _AlertSeasonState extends State<AlertSeason> {
  final TextEditingController _seasonNameController = TextEditingController();
  final TextEditingController _seasonTeamNameController = TextEditingController();
  final TextEditingController _seasonDateStartController = TextEditingController();
  final TextEditingController _seasonDateEndController = TextEditingController();

  DateTime? _dateStartPicked;
  DateTime? _dateEndPicked;

  _initState() {
    if (widget.season != null) {
      _seasonNameController.text = widget.season!.getName();
      _seasonTeamNameController.text = widget.season!.teamName ?? "";
      _seasonDateStartController.text = widget.season!.from.toDateTime().format();
      _seasonDateEndController.text = widget.season!.to.toDateTime().format();

      _dateStartPicked = widget.season!.from.toDateTime();
      _dateEndPicked = widget.season!.to.toDateTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    _initState();

    return AlertDialog(
      title: Text(widget.season != null ? "Modifier votre saison" : "Créer votre saison"),
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
                      _dateStartPicked = value,
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
                      _dateEndPicked = value,
                      _seasonDateEndController.text = value.format(),
                    }
                },
              );
            },
          ),
        ],
      ),
      actions: [
        if (widget.season != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Êtes-vous sûr de vouloir supprimer la saison ?"),
                    content: Text(widget.season!.getName()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          widget.ref.read(dbProvider).removeSeason(widget.season!.id);

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
            var value = Season()
              ..name = _seasonNameController.value.text
              ..teamName = _seasonTeamNameController.value.text
              ..from = _dateStartPicked.toTimestamp()
              ..to = _dateEndPicked.toTimestamp();

            if (widget.season != null) {
              widget.ref.read(dbProvider).editSeason(
                    value,
                    widget.season!.id,
                  );
            } else {
              widget.ref.read(dbProvider).addNewSeason(value);
            }

            Navigator.pop(context);
          },
          child: Text(widget.season != null ? "Modifier" : "Créer"),
        ),
      ],
    );
  }
}
