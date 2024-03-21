import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/core/ui/spacings.dart';
import 'package:footrack_front/database/ft_providers.dart';
import 'package:footrack_front/models/extensions/opponent_extension.dart';
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

    _opponentNameController.text = widget.opponent.getName();
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
              const SizedBox(width: Spacing.xs),
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
                  return Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
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
                                    ref.watch(seasonChoseProvider)?.id,
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
            var opponent = Opponent()..name = _opponentNameController.value.text;

            if (widget.opponent != null) {
              ref.read(dbProvider).editOpponent(
                    ref.watch(seasonChoseProvider)?.id,
                    widget.opponent!.id,
                    opponent,
                  );
            } else {
              ref.read(dbProvider).addNewOpponent(
                    ref.watch(seasonChoseProvider)?.id,
                    opponent,
                  );
            }

            Navigator.pop(context);
          },
          child: Text(widget.opponent != null ? "Modifier" : "Ajouter"),
        ),
      ],
    );
  }
}
