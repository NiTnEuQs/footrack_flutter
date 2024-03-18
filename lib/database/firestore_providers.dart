import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flamingo/flamingo.dart';
import 'package:footrack_front/database/firestore_database.dart';
import 'package:footrack_front/notifiers/match_notifier.dart';
import 'package:footrack_front/notifiers/season_notifier.dart';

final dbProvider = Provider((_) => FirestoreDatabase());

final increaseOpponentGoalProvider = FutureProvider((ref) {
  var season = ref.watch(selectedSeasonProvider);
  var match = ref.watch(selectedMatchProvider);
  var opponentGoal = match.getScoreOpponent();

  return FirebaseFirestore.instance
      .doc("seasons/${season.id}/matchs/${match.id}")
      .update({'scoreOpponent': (opponentGoal + 1)});
});

final decreaseOpponentGoalProvider = FutureProvider((ref) {
  var season = ref.watch(selectedSeasonProvider);
  var match = ref.watch(selectedMatchProvider);
  var opponentGoal = match.getScoreOpponent();

  return FirebaseFirestore.instance
      .doc("seasons/${season.id}/matchs/${match.id}")
      .update({'scoreOpponent': max(0, opponentGoal - 1)});
});
