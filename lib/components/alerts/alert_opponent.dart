import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/global_providers.dart';
import 'package:footrack_front/models/opponent.dart';

class AlertOpponent extends ConsumerStatefulWidget {
  const AlertOpponent({
    Key? key,
    this.opponent,
  }) : super(key: key);

  final Opponent? opponent;

  @override
  ConsumerState<AlertOpponent> createState() => _AlertOpponentState();
}

class _AlertOpponentState extends ConsumerState<AlertOpponent> {
  final TextEditingController _opponentNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.opponent != null) {
      _opponentNameController.text = widget.opponent!.getName();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.opponent != null ? "Modifier l'adversaire" : "Ajouter un adversaire"),
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
        if (widget.opponent != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Êtes-vous sûr de vouloir supprimer l'adversaire ?"),
                    content: Text(widget.opponent!.getName()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(dbProvider).removeOpponent(
                                ref.read(seasonProvider).id,
                                widget.opponent!.id,
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
            var value = Opponent()..name = _opponentNameController.value.text;

            if (widget.opponent != null) {
              ref.read(dbProvider).editOpponent(ref.read(seasonProvider).id, widget.opponent!.id, value);
            } else {
              ref.read(dbProvider).addNewOpponent(ref.read(seasonProvider).id, value);
            }

            Navigator.pop(context);
          },
          child: Text(widget.opponent != null ? "Modifier" : "Ajouter"),
        ),
      ],
    );
  }
}
