import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/extensions/season_extension.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/utils/pickers.dart';

class AlertSeason extends ConsumerStatefulWidget {
  const AlertSeason({
    Key? key,
    this.season,
  }) : super(key: key);

  final Season? season;

  @override
  ConsumerState<AlertSeason> createState() => _AlertSeasonState();
}

class _AlertSeasonState extends ConsumerState<AlertSeason> {
  final TextEditingController _seasonNameController = TextEditingController();
  final TextEditingController _seasonTeamNameController = TextEditingController();
  final TextEditingController _seasonDateStartController = TextEditingController();
  final TextEditingController _seasonDateEndController = TextEditingController();

  DateTime? _dateStartPicked;
  DateTime? _dateEndPicked;

  @override
  void initState() {
    super.initState();

    _dateStartPicked = widget.season.getFrom();
    _dateEndPicked = widget.season.getTo();

    _seasonNameController.text = widget.season.getName();
    _seasonTeamNameController.text = widget.season.getTeamName();
    _seasonDateStartController.text = _dateStartPicked.format();
    _seasonDateEndController.text = _dateEndPicked.format();
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: () async {
              ref.read(datePicker(context).future).then((d) {
                if (d != null) {
                  _dateStartPicked = d;
                  _seasonDateStartController.text = d.format();
                }
              });
            },
          ),
          TextFormField(
            controller: _seasonDateEndController,
            decoration: const InputDecoration(
              hintText: "Date de fin",
            ),
            readOnly: true,
            onTap: () {
              ref.read(datePicker(context).future).then((d) {
                if (d != null) {
                  _dateEndPicked = d;
                  _seasonDateEndController.text = d.format();
                }
              });
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
                  return Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return AlertDialog(
                        title: const Text("Êtes-vous sûr de vouloir supprimer la saison ?"),
                        content: Text(widget.season.getName()),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Annuler")),
                          ElevatedButton(
                            onPressed: () {
                              ref.read(dbProvider).removeSeason(widget.season!.id);

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
            var season = Season()
              ..name = _seasonNameController.value.text
              ..teamName = _seasonTeamNameController.value.text
              ..from = _dateStartPicked.toTimestamp()
              ..to = _dateEndPicked.toTimestamp();

            if (widget.season != null) {
              ref.read(dbProvider).editSeason(
                    widget.season!.id,
                    season,
                  );
            } else {
              ref.read(dbProvider).addNewSeason(
                    season,
                  );
            }

            Navigator.pop(context);
          },
          child: Text(widget.season != null ? "Modifier" : "Créer"),
        ),
      ],
    );
  }
}
