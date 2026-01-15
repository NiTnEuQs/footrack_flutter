import "package:flamingo/flamingo.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/core/ui/spacings.dart";
import "package:footrack_front/database/ft_providers.dart";
import "package:footrack_front/enums/match_type_enum.dart";
import "package:footrack_front/extensions/date_extensions.dart";
import "package:footrack_front/extensions/object_extensions.dart";
import "package:footrack_front/models/extensions/match_extension.dart";
import "package:footrack_front/models/extensions/opponent_extension.dart";
import "package:footrack_front/models/extensions/season_extension.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/utils/comparables.dart";
import "package:footrack_front/utils/pickers.dart";
import "package:footrack_front/utils/tuples.dart";

class AlertMatch extends ConsumerStatefulWidget {
  const AlertMatch({
    super.key,
    this.match,
  });

  final Match? match;

  @override
  ConsumerState<AlertMatch> createState() => _AlertMatchState();
}

class _AlertMatchState extends ConsumerState<AlertMatch> {
  final TextEditingController _dateStartController = TextEditingController();

  MatchTypeEnum? _type;
  DateTime? _dateStartPicked;
  String? _opponentRefPath;

  @override
  void initState() {
    super.initState();

    _type = widget.match.getType();
    _dateStartPicked = widget.match.getDate();
    _opponentRefPath = widget.match?.opponent?.path;

    _dateStartController.text = _dateStartPicked.formatWithTime();
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var opponents = season.getOpponents(ref);
    var opponentsList = opponents.map((e) => Pair(e.reference.path, e.getName())).toList()..sort(comparePairSecondAsc);

    if (widget.match == null) {
      _opponentRefPath ??= opponentsList.firstOrNull?.first;
    }

    return AlertDialog(
      title: Text(widget.match != null ? "Modifier le match" : "Créer un match"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.emoji_events, color: Colors.amber),
              const SizedBox(width: Spacing.xs),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  value: _type,
                  items: List<MatchTypeEnum>.from(MatchTypeEnum.values)
                      .map<DropdownMenuItem<MatchTypeEnum>>((MatchTypeEnum value) {
                    return DropdownMenuItem<MatchTypeEnum>(
                      value: value,
                      child: Text(value.format()),
                    );
                  }).toList(),
                  onChanged: (MatchTypeEnum? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.blue),
              const SizedBox(width: Spacing.xs),
              Expanded(
                child: TextFormField(
                  controller: _dateStartController,
                  decoration: const InputDecoration(
                    hintText: "Date de début",
                  ),
                  readOnly: true,
                  onTap: () {
                    ref.read(dateTimePicker(context).future).then((d) {
                      if (d != null) {
                        _dateStartPicked = d;
                        _dateStartController.text = d.formatWithTime();
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
              const SizedBox(width: Spacing.xs),
              Expanded(
                child: opponents.isEmpty
                    ? Container(
                        height: Spacing.xl4,
                        alignment: Alignment.centerLeft,
                        child: const Text("Pas d'adversaire"),
                      )
                    : DropdownButton(
                        isExpanded: true,
                        value: _opponentRefPath,
                        items: opponentsList.map<DropdownMenuItem<String>>(
                          (Pair<String?, String> value) {
                            return DropdownMenuItem<String>(
                              value: value.first,
                              child: Text(value.second ?? ""),
                            );
                          },
                        ).toList(),
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
                        content: Text(widget.match.getDate().format()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Annuler"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref.read(dbProvider).removeMatch(
                                    ref.watch(clubChoseProvider)?.id,
                                    ref.watch(seasonChoseProvider)?.id,
                                    widget.match!.id,
                                  );

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
            var match = Match()
              ..type = _type?.name
              ..date = _dateStartPicked.toTimestamp()
              ..opponent = _opponentRefPath?.let((it) => FirebaseFirestore.instance.doc(it))
              ..scoreOpponent = widget.match.getScoreOpponent();

            if (widget.match != null) {
              ref.read(dbProvider).editMatch(
                    ref.watch(clubChoseProvider)?.id,
                    ref.watch(seasonChoseProvider)?.id,
                    widget.match!.id,
                    match,
                  );
            } else {
              ref.read(dbProvider).addNewMatch(
                    ref.watch(clubChoseProvider)?.id,
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
