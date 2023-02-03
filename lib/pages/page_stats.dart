import 'package:async/async.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/seasons_store.dart';
import 'package:footrack_front/models/season.dart';

class StatsPage extends ConsumerStatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatsPageState();
}

class _StatsPageState extends ConsumerState<StatsPage> {
  @override
  Widget build(BuildContext context) {
    var matchs = seasonsRef.doc(ref.read(seasonChoseProvider)?.id).matchs;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stats"),
      ),
      body: FirestoreBuilder(
        ref: matchs,
        builder: (context, AsyncSnapshot<MatchQuerySnapshot> matchQuerySnapshot, Widget? child) {
          if (matchQuerySnapshot.hasError) {
            debugPrint(matchQuerySnapshot.error.toString());
            return const Center(child: Text('Erreur'));
          }

          if (!matchQuerySnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // final sum = matchQuerySnapshot.data?.docs.fold(0, (prev, next) => prev + int.parse(next['Value']))

          var goals = StreamZip(matchQuerySnapshot.requireData.docs.map(
            (match) => match.reference.goals.snapshots(),
          ));

          return StreamBuilder(
              stream: goals,
              builder: (context, AsyncSnapshot<List<GoalQuerySnapshot>> goalsQuerySnapshot) {
                if (goalsQuerySnapshot.hasError) {
                  debugPrint(goalsQuerySnapshot.error.toString());
                  return const Center(child: Text("Erreur"));
                }

                if (!goalsQuerySnapshot.hasData) {
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                int goals = 0;

                for (var goalQuerySnapshot in goalsQuerySnapshot.requireData) {
                  goals += goalQuerySnapshot.docs.length;
                }

                return Text(goals.toString());
              });
        },
      ),
    );
  }
}
