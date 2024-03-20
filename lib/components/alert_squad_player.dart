import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/models/squad_player.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertSquadPlayer extends ConsumerStatefulWidget {
  const AlertSquadPlayer({
    Key? key,
    this.squadPlayer,
  }) : super(key: key);

  final SquadPlayer? squadPlayer;

  @override
  ConsumerState<AlertSquadPlayer> createState() => _AlertSquadPlayerState();
}

class _AlertSquadPlayerState extends ConsumerState<AlertSquadPlayer> {
  String? _playerRefPath;

  @override
  void initState() {
    super.initState();

    _playerRefPath = widget.squadPlayer?.player?.path;
  }

  @override
  Widget build(BuildContext context) {
    var season = ref.watch(seasonChoseProvider);
    var players = season != null ? ref.watch(season.playersProvider) : <Player>[];

    List<Pair<String, String>> scorersList = players.map((e) => Pair(e.reference.path, e.name)).toList()
      ..sort(comparePairSecond);

    if (widget.squadPlayer == null) {
      _playerRefPath ??= scorersList.first.first;
    }

    return AlertDialog(
      title: Text(widget.squadPlayer != null ? "Modifier le joueur" : "Ajouter un joueur"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.sports_soccer),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  value: _playerRefPath,
                  items: scorersList.map<DropdownMenuItem<String>>((Pair<String, String> value) {
                    return DropdownMenuItem<String>(
                      value: value.first,
                      child: Text(value.second ?? ""),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _playerRefPath = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (widget.squadPlayer != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return AlertDialog(
                        title: const Text("Êtes-vous sûr de vouloir enlever ce joueur de l'effectif ?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Annuler")),
                          ElevatedButton(
                            onPressed: () {
                              ref.read(dbProvider).removeSquadPlayer(
                                    ref.watch(seasonChoseProvider)?.id,
                                    ref.watch(matchChoseProvider)?.id,
                                    widget.squadPlayer!.id,
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
                            child: const Text("Enlever"),
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
            child: const Text("Enlever"),
          ),
        ElevatedButton(
          onPressed: () {
            var match = ref.watch(matchChoseProvider);
            var squad = match != null ? ref.watch(match.squadProvider) : <SquadPlayer>[];
            var playerPaths = squad.map((e) => e.player?.id);
            var squadPlayer = SquadPlayer()..player = _playerRefPath?.let((it) => FirebaseFirestore.instance.doc(it));

            if (widget.squadPlayer != null) {
              ref.read(dbProvider).editSquadPlayer(
                    ref.watch(seasonChoseProvider)?.id,
                    ref.watch(matchChoseProvider)?.id,
                    widget.squadPlayer!.id,
                    squadPlayer,
                  );

              Navigator.pop(context);
            } else if (!playerPaths.contains(squadPlayer.player?.id)) {
              ref.read(dbProvider).addNewSquadPlayer(
                    ref.watch(seasonChoseProvider)?.id,
                    ref.watch(matchChoseProvider)?.id,
                    squadPlayer,
                  );

              Navigator.pop(context);
            } else {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text("Attention"),
                    content: Text("Ce joueur est déjà dans l'effectif"),
                  );
                },
              );
            }
          },
          child: Text(widget.squadPlayer != null ? "Modifier" : "Ajouter"),
        ),
      ],
    );
  }
}
