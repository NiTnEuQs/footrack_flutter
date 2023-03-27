import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/enums/match_type_enum.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/pickers.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertMatch extends StatefulWidget {
  const AlertMatch({
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

  MatchTypeEnum? _matchType = MatchTypeEnum.championship;
  int? _scoreOpponent = 0;
  String? _opponentRefPath;
  DateTime? _dateStartPicked;

  @override
  void initState() {
    super.initState();
    if (widget.match != null) {
      _matchType = widget.match!.getType();
      _dateStartPicked = widget.match!.date.toDateTime();
      _opponentRefPath = widget.match!.opponent?.path;
      _scoreOpponent = widget.match!.scoreOpponent;

      _matchDateStartController.text = _dateStartPicked.formatWithTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    var opponents = widget.ref.read(seasonChoseProvider)?.opponents;

    return AlertDialog(
      title: Text(widget.match != null ? "Modifier le match" : "Créer un match"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   children: [
          //     const Icon(Icons.military_tech, color: Colors.amber),
          //     const SizedBox(width: 8),
          //     Expanded(
          //       child: DropdownButton(
          //         isExpanded: true,
          //         value: _matchType,
          //         items: List<MatchTypeEnum>.from(MatchTypeEnum.values).map<DropdownMenuItem<MatchTypeEnum>>((MatchTypeEnum value) {
          //           return DropdownMenuItem<MatchTypeEnum>(
          //             value: value,
          //             child: Text(value.format()),
          //           );
          //         }).toList(),
          //         onChanged: (MatchTypeEnum? value) {
          //           setState(() {
          //             _matchType = value;
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.blue),
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
              const Icon(Icons.groups, color: Colors.lightGreen),
              const SizedBox(width: 8),
              Expanded(
                child: opponents == null
                    ? const Text("Une erreur est survenue")
                    : FutureBuilder(
                        future: firestoreInstance.collection(opponents.path).get(),
                        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(child: Text("Erreur"));
                          }

                          if (!snapshot.hasData) {
                            return const Center(child: Text("Loading ..."));
                          }

                          if (widget.match == null) {
                            _opponentRefPath ??= snapshot.requireData.docs.first.reference.path;
                          }

                          List<Pair<String, String>>? opponentsList = snapshot.data?.docs
                              .map((e) => Opponent(snapshot: e))
                              .map((e) => Pair(e.reference.path, e.name))
                              .toList()
                            ?..sort(comparePairSecond);

                          return DropdownButton(
                            isExpanded: true,
                            value: _opponentRefPath,
                            items: opponentsList?.map<DropdownMenuItem<String>>((Pair<String, String> value) {
                              return DropdownMenuItem<String>(
                                value: value.first,
                                child: Text(value.second ?? ""),
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
                    content: Text(widget.match!.date.toDateTime().format()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          widget.ref.read(dbProvider).removeMatch(widget.ref.read(seasonChoseProvider)?.id, widget.match!.id);

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
            var value = Match()
              ..type = _matchType?.name
              ..opponent = _opponentRefPath != null ? FirebaseFirestore.instance.doc(_opponentRefPath!) : null
              ..date = _dateStartPicked.toTimestamp()
              ..scoreOpponent = _scoreOpponent;

            if (widget.match != null) {
              widget.ref.read(dbProvider).editMatch(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.match!.id,
                    value,
                  );
            } else {
              widget.ref.read(dbProvider).addNewMatch(
                    widget.ref.read(seasonChoseProvider)?.id,
                    value,
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
