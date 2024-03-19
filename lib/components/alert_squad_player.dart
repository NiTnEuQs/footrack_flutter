import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/models/squad_player.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertSquadPlayer extends StatefulWidget {
  const AlertSquadPlayer({
    Key? key,
    required this.ref,
    this.squadPlayer,
  }) : super(key: key);

  final WidgetRef ref;
  final SquadPlayer? squadPlayer;

  @override
  State<AlertSquadPlayer> createState() => _AlertSquadPlayerState();
}

class _AlertSquadPlayerState extends State<AlertSquadPlayer> {
  String? _playerRefPath;

  @override
  void initState() {
    super.initState();

    _playerRefPath = widget.squadPlayer?.player?.path;
  }

  @override
  Widget build(BuildContext context) {
    var season = widget.ref.watch(seasonChoseProvider);
    var players = season?.players;

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
                child: players == null
                    ? const Text("Une erreur est survenue")
                    : FutureBuilder(
                        future: firestoreInstance.collection(players.path).get(),
                        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(child: Text("Erreur"));
                          }

                          if (!snapshot.hasData) {
                            return const Center(child: Text("Loading ..."));
                          }

                          List<Pair<String, String>>? scorersList = snapshot.data?.docs
                              .map((e) => Player(snapshot: e))
                              .map((e) => Pair(e.reference.path, e.name))
                              .toList()
                            ?..sort(comparePairSecond);

                          if (widget.squadPlayer == null) {
                            _playerRefPath ??= scorersList?.first.first;
                          }

                          return DropdownButton(
                            isExpanded: true,
                            value: _playerRefPath,
                            items: scorersList?.map<DropdownMenuItem<String>>((Pair<String, String> value) {
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
                          );
                        }),
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
                          widget.ref.read(dbProvider).removeSquadPlayer(
                                widget.ref.read(seasonChoseProvider)?.id,
                                widget.ref.read(matchChoseProvider)?.id,
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
            var match = widget.ref.watch(matchChoseProvider);
            var squad = match != null ? widget.ref.watch(match.squadProvider) : <SquadPlayer>[];
            var playerPaths = squad.map((e) => e.player?.id);
            var squadPlayer = SquadPlayer()
              ..player = _playerRefPath != null ? FirebaseFirestore.instance.doc(_playerRefPath!) : null;

            if (widget.squadPlayer != null) {
              widget.ref.read(dbProvider).editSquadPlayer(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.ref.read(matchChoseProvider)?.id,
                    widget.squadPlayer!.id,
                    squadPlayer,
                  );

              Navigator.pop(context);
            } else if (!playerPaths.contains(squadPlayer.player?.id)) {
              widget.ref.read(dbProvider).addNewSquadPlayer(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.ref.read(matchChoseProvider)?.id,
                    squadPlayer,
                  );

              Navigator.pop(context);
            } else {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text("Ce joueur est déjà dans l'effectif"),
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
