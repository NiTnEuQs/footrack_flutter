import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/models/season.dart';

class AlertOpponent extends StatelessWidget {
  AlertOpponent({
    Key? key,
    required this.ref,
    this.opponent,
  }) : super(key: key);

  final WidgetRef ref;
  final Opponent? opponent;

  final TextEditingController _opponentNameController = TextEditingController();

  _initState() {
    if (opponent != null) {
      _opponentNameController.text = opponent!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initState();

    return AlertDialog(
      title: Text(opponent != null ? "Modifier l'adversaire" : "Ajouter un adversaire"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.abc),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _opponentNameController,
                  decoration: const InputDecoration(
                    hintText: "Nom de l'adversaire",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (opponent != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Êtes-vous sûr de vouloir supprimer l'adversaire ?"),
                    content: Text(opponent!.name),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          ref.watch(seasonsProvider).removeOpponent(
                                ref.read(seasonChoseProvider)?.id,
                                opponent!.id,
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
            if (opponent != null) {
              ref.read(seasonsProvider).editOpponent(
                    ref.read(seasonChoseProvider)?.id,
                    opponent!.id,
                    Opponent(
                      name: _opponentNameController.value.text,
                    ),
                  );
            } else {
              ref.read(seasonsProvider).addNewOpponent(
                    ref.read(seasonChoseProvider)?.id,
                    Opponent(
                      name: _opponentNameController.value.text,
                    ),
                  );
            }

            Navigator.pop(context);
          },
          child: Text(opponent != null ? "Modifier" : "Ajouter"),
        ),
      ],
    );
  }
}
