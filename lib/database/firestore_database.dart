import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:footrack_front/models/goal.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/opponent.dart';
import 'package:footrack_front/models/player.dart';
import 'package:footrack_front/models/season.dart';
import 'package:footrack_front/models/substitute.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Create an instance of Firebase Firestore.

  // Add a Season
  Future<bool> addNewSeason(Season m) async {
    try {
      await _firestore.collection('seasons').add({
        'name': m.name,
        'teamName': m.teamName,
        'from': m.from,
        'to': m.to,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Match
  Future<bool> addNewMatch(String? seasonId, Match m) async {
    if (seasonId == null) return false;

    var opponents = _firestore.collection('seasons').doc(seasonId).collection("matchs");
    try {
      await opponents.add({
        'type': m.type,
        'opponent': m.opponent,
        'date': m.date,
        'scoreOpponent': m.scoreOpponent,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Goal
  Future<bool> addNewGoal(String? seasonId, String? matchId, Goal m) async {
    if (seasonId == null) return false;

    var goals = _firestore.collection('seasons').doc(seasonId).collection("matchs").doc(matchId).collection("goals");
    try {
      await goals.add({
        'scorer': m.scorer,
        'passer': m.passer,
        'time': m.time,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Substitute
  Future<bool> addNewSubstitute(String? seasonId, String? matchId, Substitute m) async {
    if (seasonId == null) return false;

    var goals =
        _firestore.collection('seasons').doc(seasonId).collection("matchs").doc(matchId).collection("substitutes");
    try {
      await goals.add({
        'playerIn': m.playerIn,
        'playerOut': m.playerOut,
        'time': m.time,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add an Opponent
  Future<bool> addNewOpponent(String? seasonId, Opponent m) async {
    if (seasonId == null) return false;

    var opponents = _firestore.collection('seasons').doc(seasonId).collection("opponents");
    try {
      await opponents.add({
        'name': m.name,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Player
  Future<bool> addNewPlayer(String? seasonId, Player m) async {
    if (seasonId == null) return false;

    var players = _firestore.collection('seasons').doc(seasonId).collection("players");
    try {
      await players.add({
        'name': m.name,
        'role': m.role,
        'status': m.status,
        'birthdate': m.birthdate,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Season
  Future<bool> removeSeason(String seasonId) async {
    try {
      await _firestore.collection('seasons').doc(seasonId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Match
  Future<bool> removeMatch(String? seasonId, String matchId) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection('seasons').doc(seasonId).collection("matchs").doc(matchId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Goal
  Future<bool> removeGoal(String? seasonId, String? matchId, String goalId) async {
    if (seasonId == null) return false;
    if (matchId == null) return false;

    try {
      await _firestore
          .collection('seasons')
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("goals")
          .doc(goalId)
          .delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Substitute
  Future<bool> removeSubstitute(String? seasonId, String? matchId, String substituteId) async {
    if (seasonId == null) return false;
    if (matchId == null) return false;

    try {
      await _firestore
          .collection('seasons')
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("substitutes")
          .doc(substituteId)
          .delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove an Opponent
  Future<bool> removeOpponent(String? seasonId, String opponentId) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection('seasons').doc(seasonId).collection("opponents").doc(opponentId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Player
  Future<bool> removePlayer(String? seasonId, String playerId) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection('seasons').doc(seasonId).collection("players").doc(playerId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Season
  Future<bool> editSeason(Season m, String seasonId) async {
    try {
      await _firestore.collection('seasons').doc(seasonId).update({
        'name': m.name,
        'teamName': m.teamName,
        'from': m.from,
        'to': m.to,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Match
  Future<bool> editMatch(String? seasonId, String matchId, Match m) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection('seasons').doc(seasonId).collection("matchs").doc(matchId).update({
        'type': m.type,
        'opponent': m.opponent,
        'date': m.date,
        'scoreOpponent': m.scoreOpponent,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Goal
  Future<bool> editGoal(String? seasonId, String? matchId, String goalId, Goal m) async {
    if (seasonId == null) return false;
    if (matchId == null) return false;

    try {
      await _firestore
          .collection('seasons')
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("goals")
          .doc(goalId)
          .update({
        'scorer': m.scorer,
        'passer': m.passer,
        'time': m.time,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Substitute
  Future<bool> editSubstitute(String? seasonId, String? matchId, String substituteId, Substitute m) async {
    if (seasonId == null) return false;
    if (matchId == null) return false;

    try {
      await _firestore
          .collection('seasons')
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("substitutes")
          .doc(substituteId)
          .update({
        'playerIn': m.playerIn,
        'playerOut': m.playerOut,
        'time': m.time,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit an Opponent
  Future<bool> editOpponent(String? seasonId, String opponentId, Opponent m) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection('seasons').doc(seasonId).collection("opponents").doc(opponentId).update({
        'name': m.name,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Player
  Future<bool> editPlayer(String? seasonId, String playerId, Player m) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection('seasons').doc(seasonId).collection("players").doc(playerId).update({
        'name': m.name,
        'role': m.role,
        'status': m.status,
        'birthdate': m.birthdate,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Update an Opponent Goal
  Future<bool> updateOpponentGoal(String? seasonId, String? matchId, int? newOpponentGoal) async {
    if (seasonId == null) return false;
    if (matchId == null) return false;

    try {
      await _firestore
          .collection('seasons')
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .update({'scoreOpponent': newOpponentGoal});
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
