import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/global_providers.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/models/substitute.dart';
import 'package:footrack_front/utils/comparables.dart';
import 'package:footrack_front/utils/tuples.dart';

class AlertSubstitute extends ConsumerStatefulWidget {
  const AlertSubstitute({
    Key? key,
    this.substitute,
    this.onAddPressed,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  final Substitute? substitute;
  final Function(Substitute)? onAddPressed;
  final Function(Substitute)? onEditPressed;
  final Function()? onDeletePressed;

  @override
  ConsumerState<AlertSubstitute> createState() => _AlertSubstituteState();
}

class _AlertSubstituteState extends ConsumerState<AlertSubstitute> {
  final TextEditingController _substituteTimeController = TextEditingController();

  String? _playerInRefPath;
  String? _playerOutRefPath;
  int? _timeSubstitution;

  @override
  void initState() {
    super.initState();
    _playerInRefPath = widget.substitute?.playerIn?.path;
    _playerOutRefPath = widget.substitute?.playerOut?.path;
    _timeSubstitution = widget.substitute?.time;

    _substituteTimeController.text = _timeSubstitution?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var players = ref.read(seasonProvider).players;

    return AlertDialog(
      title: Text(widget.substitute != null ? "Modifier le remplacement" : "Ajouter un remplacement"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.access_alarm),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _substituteTimeController,
                  decoration: const InputDecoration(
                    hintText: "Temps",
                  ),
                  onChanged: (value) {
                    _timeSubstitution = int.parse(value);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.arrow_forward, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: FutureBuilder(
                    future: firestoreInstance.collection(players.path).get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      List<Pair<String, String>>? playersInList = snapshot.data?.docs
                          .map((e) => Player(snapshot: e))
                          .map((e) => Pair(e.reference.path, e.name))
                          .toList()
                        ?..sort(comparePairSecond);

                      if (widget.substitute == null) {
                        _playerInRefPath ??= playersInList?.first.first;
                      }

                      return DropdownButton(
                        isExpanded: true,
                        value: _playerInRefPath,
                        items: playersInList?.map<DropdownMenuItem<String>>((Pair<String, String> value) {
                          return DropdownMenuItem<String>(
                            value: value.first,
                            child: Text(value.second ?? ""),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _playerInRefPath = value;
                            });
                          }
                        },
                      );
                    }),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.arrow_back, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: FutureBuilder(
                    future: firestoreInstance.collection(players.path).get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      List<Pair<String, String>>? playersOutList = snapshot.data?.docs
                          .map((e) => Player(snapshot: e))
                          .map((e) => Pair(e.reference.path, e.name))
                          .toList()
                        ?..sort(comparePairSecond);

                      if (widget.substitute == null) {
                        _playerOutRefPath ??= playersOutList?.first.first;
                      }

                      return DropdownButton(
                        isExpanded: true,
                        value: _playerOutRefPath,
                        items: playersOutList?.map<DropdownMenuItem<String>>((Pair<String, String> value) {
                          return DropdownMenuItem<String>(
                            value: value.first,
                            child: Text(value.second ?? ""),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _playerOutRefPath = value;
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
        if (widget.substitute != null)
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Êtes-vous sûr de vouloir supprimer ce remplacement ?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler"),
                      ),
                      ElevatedButton(
                        onPressed: widget.onDeletePressed,
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
            var substitute = Substitute()
              ..playerIn = _playerInRefPath != null ? FirebaseFirestore.instance.doc(_playerInRefPath!) : null
              ..playerOut = _playerOutRefPath != null ? FirebaseFirestore.instance.doc(_playerOutRefPath!) : null
              ..time = _timeSubstitution;

            if (widget.substitute != null) {
              widget.onEditPressed?.call(substitute);
            } else {
              widget.onAddPressed?.call(substitute);
            }
          },
          child: Text(widget.substitute != null ? "Modifier" : "Ajouter"),
        ),
      ],
    );
  }
}
