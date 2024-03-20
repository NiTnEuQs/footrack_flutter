import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/enums/match_type_enum.dart';
import 'package:footrack_front/extensions/date_extensions.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/pickers.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertMatch extends ConsumerStatefulWidget {
  const AlertMatch({
    Key? key,
    this.match,
  }) : super(key: key);

  final Match? match;

  @override
  ConsumerState<AlertMatch> createState() => _AlertMatchState();
}

class _AlertMatchState extends ConsumerState<AlertMatch> {
  final TextEditingController _matchDateStartController = TextEditingController();

  MatchTypeEnum? _matchType;
  int? _scoreOpponent;
  String? _opponentRefPath;
  DateTime? _dateStartPicked;

  @override
  void initState() {
    super.initState();

    _matchType = widget.match?.getType() ?? MatchTypeEnum.championship;
    _dateStartPicked = widget.match?.date.toDateTime();
    _opponentRefPath = widget.match?.opponent?.path;
    _scoreOpponent = widget.match?.scoreOpponent ?? 0;

    _matchDateStartController.text = _dateStartPicked.formatWithTime();
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var opponents = season != null ? ref.watch(season.opponentsProvider) : <Opponent>[];

    List<Pair<String, String>> opponentsList = opponents.map((e) => Pair(e.reference.path, e.name)).toList()
      ..sort(comparePairSecond);

    if (widget.match == null) {
      _opponentRefPath ??= opponentsList.firstOrNull?.first;
    }

    return opponents.isEmpty
        ? const AlertDialog(
            title: Text("Attention"),
            content: Text("Veuillez remplir vos adversaires avant d'ajouter un match"),
          )
        : AlertDialog(
            title: Text(widget.match != null ? "Modifier le match" : "Créer un match"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        value: _matchType,
                        items: List<MatchTypeEnum>.from(MatchTypeEnum.values)
                            .map<DropdownMenuItem<MatchTypeEnum>>((MatchTypeEnum value) {
                          return DropdownMenuItem<MatchTypeEnum>(
                            value: value,
                            child: Text(value.format()),
                          );
                        }).toList(),
                        onChanged: (MatchTypeEnum? value) {
                          setState(() {
                            _matchType = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
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
                          ref.read(dateTimePicker(context).future).then((d) {
                            if (d != null) {
                              _dateStartPicked = d;
                              _matchDateStartController.text = d.formatWithTime();
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
                      child: DropdownButton(
                        isExpanded: true,
                        value: _opponentRefPath,
                        items: opponentsList.map<DropdownMenuItem<String>>((Pair<String, String> value) {
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
                      ),
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
                        return Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
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
                                    ref.read(dbProvider).removeMatch(
                                          ref.watch(seasonChoseProvider)?.id,
                                          widget.match!.id,
                                        );

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
                  var match = Match()
                    ..type = _matchType?.name
                    ..opponent = _opponentRefPath?.let((it) => FirebaseFirestore.instance.doc(it))
                    ..date = _dateStartPicked.toTimestamp()
                    ..scoreOpponent = _scoreOpponent;

                  if (widget.match != null) {
                    ref.read(dbProvider).editMatch(
                          ref.watch(seasonChoseProvider)?.id,
                          widget.match!.id,
                          match,
                        );
                  } else {
                    ref.read(dbProvider).addNewMatch(
                          ref.watch(seasonChoseProvider)?.id,
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
