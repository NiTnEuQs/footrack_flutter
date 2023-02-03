import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/utils/pickers.dart';

class AlertMatch extends StatefulWidget {
  AlertMatch({
    Key? key,
    required this.ref,
    this.match,
  }) : super(key: key);

  final WidgetRef ref;
  final Match? match;

  @override
  State<AlertMatch> createState() => _AlertMatchState();
}

class _AlertMatchState extends State<AlertMatch> {
  final TextEditingController _matchDateStartController = TextEditingController();

  int? _scoreOpponent = 0;

  String? _opponentRefPath;

  DateTime? _dateStartPicked;

  @override
  void initState() {
    super.initState();
    if (widget.match != null) {
      _dateStartPicked = widget.match!.date;
      _opponentRefPath = widget.match!.opponentRef?.path;
      _scoreOpponent = widget.match!.scoreOpponent;

      _matchDateStartController.text = _dateStartPicked.formatWithTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.match != null ? "Modifier le match" : "Créer un match"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _matchDateStartController,
                  decoration: const InputDecoration(
                    hintText: "Date de début",
                  ),
                  readOnly: true,
                  onTap: () {
                    dateTimePicker(context).then((value) {
                      if (value != null) {
                        _dateStartPicked = value;
                        _matchDateStartController.text = value.formatWithTime();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.groups),
              const SizedBox(width: 8),
              Expanded(
                child: FirestoreBuilder(
                    ref: seasonsRef.doc(widget.ref.read(seasonChoseProvider)?.id).opponents,
                    builder: (context, AsyncSnapshot<OpponentQuerySnapshot> snapshot, child) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      if (widget.match == null) {
                        _opponentRefPath ??= snapshot.requireData.docs.first.reference.path;
                      }

                      var opponentsList = List<OpponentQueryDocumentSnapshot>.from(snapshot.requireData.docs)
                        ..sort((a, b) {
                          return a.data.name.compareTo(b.data.name);
                        });

                      return DropdownButton(
                        isExpanded: true,
                        value: _opponentRefPath,
                        items: opponentsList.map<DropdownMenuItem<String>>((OpponentQueryDocumentSnapshot value) {
                          return DropdownMenuItem<String>(
                            value: value.reference.path,
                            child: Text(value.data.name),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _opponentRefPath = value;
                            });
                          }
                        },
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (widget.match != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Êtes-vous sûr de vouloir supprimer le match ?"),
                    content: Text(widget.match!.date.format()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          widget.ref.watch(seasonsProvider).removeMatch(widget.ref.read(seasonChoseProvider)?.id, widget.match!.id);

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
            Match match = Match(
              opponentRef: _opponentRefPath != null ? FirebaseFirestore.instance.doc(_opponentRefPath!) : null,
              date: _dateStartPicked,
              scoreOpponent: _scoreOpponent,
            );

            if (widget.match != null) {
              widget.ref.read(seasonsProvider).editMatch(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.match!.id,
                    match,
                  );
            } else {
              widget.ref.read(seasonsProvider).addNewMatch(
                    widget.ref.read(seasonChoseProvider)?.id,
                    match,
                  );
            }

            Navigator.pop(context);
          },
          child: Text(widget.match != null ? "Modifier" : "Créer"),
        ),
      ],
    );
  }
}
