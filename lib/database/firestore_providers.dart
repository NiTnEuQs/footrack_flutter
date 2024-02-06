import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flamingo/flamingo.dart';
import 'package:footrack_front/database/global_providers.dart';

final increaseOpponentGoalProvider = FutureProvider((ref) {
  var season = ref.watch(seasonProvider);
  var match = ref.watch(matchStreamProvider).value ?? (throw Exception("No match selected"));
  var opponentGoal = match.getScoreOpponent();

  return firestoreInstance
      .collection("seasons")
      .doc(season.id)
      .collection("matchs")
      .doc(match.id)
      .update({'scoreOpponent': (opponentGoal + 1)});
});

final decreaseOpponentGoalProvider = FutureProvider((ref) {
  var season = ref.watch(seasonProvider);
  var match = ref.watch(matchStreamProvider).value ?? (throw Exception("No match selected"));
  var opponentGoal = match.getScoreOpponent();

  return firestoreInstance
      .collection("seasons")
      .doc(season.id)
      .collection("matchs")
      .doc(match.id)
      .update({'scoreOpponent': max(0, opponentGoal - 1)});
});
