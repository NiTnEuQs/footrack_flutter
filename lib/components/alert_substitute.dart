import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/utils/tuples.dart';

class AddSubstituteAlert extends StatefulWidget {
  AddSubstituteAlert({
    Key? key,
    required this.ref,
    this.substitute,
  }) : super(key: key);

  final WidgetRef ref;
  final Substitute? substitute;

  @override
  State<AddSubstituteAlert> createState() => _AddSubstituteAlertState();
}

class _AddSubstituteAlertState extends State<AddSubstituteAlert> {
  final TextEditingController _substituteTimeController = TextEditingController();

  String? _playerInRefPath;
  String? _playerOutRefPath;
  int? _timeSubstitution;

  @override
  void initState() {
    super.initState();
    if (widget.substitute != null) {
      _playerInRefPath = widget.substitute!.playerInRef?.path;
      _playerOutRefPath = widget.substitute!.playerOutRef?.path;
      _timeSubstitution = widget.substitute!.time;

      _substituteTimeController.text = _timeSubstitution?.toString() ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: FirestoreBuilder(
                    ref: seasonsRef.doc(widget.ref.read(seasonChoseProvider)?.id).players,
                    builder: (context, AsyncSnapshot<PlayerQuerySnapshot> snapshot, child) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      List<Pair<String, String>> playersInList = List<PlayerQueryDocumentSnapshot>.from(snapshot.requireData.docs)
                          .map((e) => Pair(e.reference.path, e.data.name))
                          .toList()
                        ..sort((a, b) => a.second?.compareTo(b.second ?? "") ?? 0);

                      if (widget.substitute == null && playersInList.isNotEmpty) {
                        _playerInRefPath ??= playersInList.first.first;
                      }

                      return DropdownButton(
                        isExpanded: true,
                        value: _playerInRefPath,
                        items: playersInList.map<DropdownMenuItem<String>>((Pair<String, String> value) {
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
                child: FirestoreBuilder(
                    ref: seasonsRef.doc(widget.ref.read(seasonChoseProvider)?.id).players,
                    builder: (context, AsyncSnapshot<PlayerQuerySnapshot> snapshot, child) {
                      if (snapshot.hasError) {
                        return const Center(child: Text("Erreur"));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text("Loading ..."));
                      }

                      List<Pair<String, String>> playersOutList = List<PlayerQueryDocumentSnapshot>.from(snapshot.requireData.docs)
                          .map((e) => Pair(e.reference.path, e.data.name))
                          .toList()
                        ..sort((a, b) => a.second?.compareTo(b.second ?? "") ?? 0);

                      if (widget.substitute == null && playersOutList.length >= 2) {
                        _playerOutRefPath ??= playersOutList[1].first;
                      }

                      return DropdownButton(
                        isExpanded: true,
                        value: _playerOutRefPath,
                        items: playersOutList.map<DropdownMenuItem<String>>((Pair<String, String> value) {
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
                          child: const Text("Annuler")),
                      ElevatedButton(
                        onPressed: () {
                          widget.ref
                              .watch(seasonsProvider)
                              .removeSubstitute(widget.ref.read(seasonChoseProvider)?.id, widget.ref.read(matchChoseProvider)?.id, widget.substitute!.id);

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
            Substitute substitute = Substitute(
              playerInRef: _playerInRefPath != null ? FirebaseFirestore.instance.doc(_playerInRefPath!) : null,
              playerOutRef: _playerOutRefPath != null ? FirebaseFirestore.instance.doc(_playerOutRefPath!) : null,
              time: _timeSubstitution,
            );

            if (widget.substitute != null) {
              widget.ref.read(seasonsProvider).editSubstitute(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.ref.read(matchChoseProvider)?.id,
                    widget.substitute!.id,
                    substitute,
                  );
            } else {
              widget.ref.read(seasonsProvider).addNewSubstitute(
                    widget.ref.read(seasonChoseProvider)?.id,
                    widget.ref.read(matchChoseProvider)?.id,
                    substitute,
                  );
            }

            Navigator.pop(context);
          },
          child: Text(widget.substitute != null ? "Modifier" : "Ajouter"),
        ),
      ],
    );
  }
}
