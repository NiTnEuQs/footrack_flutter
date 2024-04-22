import "package:cloud_firestore/cloud_firestore.dart";
import "package:footrack_front/models/goal.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/models/opponent.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/models/season.dart";
import "package:footrack_front/models/squad_player.dart";
import "package:footrack_front/models/substitute.dart";

class DatabaseFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Create an instance of Firebase Firestore.

  // Add a Season
  Future<bool> addNewSeason(Season m) async {
    try {
      await _firestore.collection("seasons").add({
        SeasonKey.name.value: m.name,
        SeasonKey.teamName.value: m.teamName,
        SeasonKey.from.value: m.from,
        SeasonKey.to.value: m.to,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Match
  Future<bool> addNewMatch(String? seasonId, Match m) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection("seasons").doc(seasonId).collection("matchs").add({
        MatchKey.type.value: m.type,
        MatchKey.opponent.value: m.opponent,
        MatchKey.date.value: m.date,
        MatchKey.scoreOpponent.value: m.scoreOpponent,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Squad Player
  Future<bool> addNewSquadPlayer(String? seasonId, String? matchId, SquadPlayer sp) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection("seasons").doc(seasonId).collection("matchs").doc(matchId).collection("squad").add({
        SquadPlayerKey.player.value: sp.player,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Goal
  Future<bool> addNewGoal(String? seasonId, String? matchId, Goal m) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection("seasons").doc(seasonId).collection("matchs").doc(matchId).collection("goals").add({
        GoalKey.scorer.value: m.scorer,
        GoalKey.passer.value: m.passer,
        GoalKey.time.value: m.time,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Substitute
  Future<bool> addNewSubstitute(String? seasonId, String? matchId, Substitute m) async {
    if (seasonId == null) return false;

    try {
      await _firestore
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("substitutes")
          .add({
        SubstituteKey.playerIn.value: m.playerIn,
        SubstituteKey.playerOut.value: m.playerOut,
        SubstituteKey.time.value: m.time,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add an Opponent
  Future<bool> addNewOpponent(String? seasonId, Opponent m) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection("seasons").doc(seasonId).collection("opponents").add({
        OpponentKey.name.value: m.name,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Player
  Future<bool> addNewPlayer(String? seasonId, Player m) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection("seasons").doc(seasonId).collection("players").add({
        PlayerKey.name.value: m.name,
        PlayerKey.role.value: m.role,
        PlayerKey.status.value: m.status,
        PlayerKey.birthdate.value: m.birthdate,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Season
  Future<bool> removeSeason(String seasonId) async {
    try {
      await _firestore.collection("seasons").doc(seasonId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Match
  Future<bool> removeMatch(String? seasonId, String matchId) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection("seasons").doc(seasonId).collection("matchs").doc(matchId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Squad Player
  Future<bool> removeSquadPlayer(String? seasonId, String? matchId, String squadPlayerId) async {
    if (seasonId == null) return false;
    if (matchId == null) return false;

    try {
      await _firestore
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("squad")
          .doc(squadPlayerId)
          .delete();
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
          .collection("seasons")
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
          .collection("seasons")
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
      await _firestore.collection("seasons").doc(seasonId).collection("opponents").doc(opponentId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Player
  Future<bool> removePlayer(String? seasonId, String playerId) async {
    if (seasonId == null) return false;

    try {
      await _firestore.collection("seasons").doc(seasonId).collection("players").doc(playerId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Season
  Future<bool> editSeason(String seasonId, Season s) async {
    try {
      await _firestore.collection("seasons").doc(seasonId).update({
        SeasonKey.name.value: s.name,
        SeasonKey.teamName.value: s.teamName,
        SeasonKey.from.value: s.from,
        SeasonKey.to.value: s.to,
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
      await _firestore.collection("seasons").doc(seasonId).collection("matchs").doc(matchId).update({
        MatchKey.type.value: m.type,
        MatchKey.opponent.value: m.opponent,
        MatchKey.date.value: m.date,
        MatchKey.scoreOpponent.value: m.scoreOpponent,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Squad Player
  Future<bool> editSquadPlayer(String? seasonId, String? matchId, String squadPlayerId, SquadPlayer sp) async {
    if (seasonId == null) return false;
    if (matchId == null) return false;

    try {
      await _firestore
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("squad")
          .doc(squadPlayerId)
          .update({
        SquadPlayerKey.player.value: sp.player,
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
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("goals")
          .doc(goalId)
          .update({
        GoalKey.scorer.value: m.scorer,
        GoalKey.passer.value: m.passer,
        GoalKey.time.value: m.time,
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
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("substitutes")
          .doc(substituteId)
          .update({
        SubstituteKey.playerIn.value: m.playerIn,
        SubstituteKey.playerOut.value: m.playerOut,
        SubstituteKey.time.value: m.time,
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
      await _firestore.collection("seasons").doc(seasonId).collection("opponents").doc(opponentId).update({
        OpponentKey.name.value: m.name,
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
      await _firestore.collection("seasons").doc(seasonId).collection("players").doc(playerId).update({
        PlayerKey.name.value: m.name,
        PlayerKey.role.value: m.role,
        PlayerKey.status.value: m.status,
        PlayerKey.birthdate.value: m.birthdate,
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
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .update({"scoreOpponent": newOpponentGoal});
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
