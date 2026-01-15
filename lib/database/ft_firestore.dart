import "package:cloud_firestore/cloud_firestore.dart";
import "package:footrack_front/models/account.dart";
import "package:footrack_front/models/club.dart";
import "package:footrack_front/models/goal.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/models/opponent.dart";
import "package:footrack_front/models/player.dart";
import "package:footrack_front/models/season.dart";
import "package:footrack_front/models/squad_player.dart";
import "package:footrack_front/models/substitute.dart";

class DatabaseFirestore {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Create an instance of Firebase Firestore.

  // Add a Season
  Future<bool> addNewSeason(String? clubId, Season m) async {
    if (clubId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .add({
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
  Future<bool> addNewMatch(String? clubId, String? seasonId, Match m) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .add({
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
  Future<bool> addNewSquadPlayer(
      String? clubId, String? seasonId, String? matchId, SquadPlayer sp) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("squad")
          .add({
        SquadPlayerKey.player.value: sp.player,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Goal
  Future<bool> addNewGoal(
      String? clubId, String? seasonId, String? matchId, Goal m) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .collection("goals")
          .add({
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
  Future<bool> addNewSubstitute(
      String? clubId, String? seasonId, String? matchId, Substitute m) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
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
  Future<bool> addNewOpponent(
      String? clubId, String? seasonId, Opponent m) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("opponents")
          .add({
        OpponentKey.name.value: m.name,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Add a Player
  Future<bool> addNewPlayer(String? clubId, String? seasonId, Player m) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("players")
          .add({
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
  Future<bool> removeSeason(String? clubId, String seasonId) async {
    if (clubId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Match
  Future<bool> removeMatch(
      String? clubId, String? seasonId, String matchId) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Squad Player
  Future<bool> removeSquadPlayer(String? clubId, String? seasonId,
      String? matchId, String squadPlayerId) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
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
  Future<bool> removeGoal(
      String? clubId, String? seasonId, String? matchId, String goalId) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
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
  Future<bool> removeSubstitute(String? clubId, String? seasonId,
      String? matchId, String substituteId) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
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
  Future<bool> removeOpponent(
      String? clubId, String? seasonId, String opponentId) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("opponents")
          .doc(opponentId)
          .delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Player
  Future<bool> removePlayer(
      String? clubId, String? seasonId, String playerId) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("players")
          .doc(playerId)
          .delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Season
  Future<bool> editSeason(String? clubId, String seasonId, Season s) async {
    if (clubId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .update({
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
  Future<bool> editMatch(
      String? clubId, String? seasonId, String matchId, Match m) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("matchs")
          .doc(matchId)
          .update({
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
  Future<bool> editSquadPlayer(String? clubId, String? seasonId,
      String? matchId, String squadPlayerId, SquadPlayer sp) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
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
  Future<bool> editGoal(String? clubId, String? seasonId, String? matchId,
      String goalId, Goal m) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
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
  Future<bool> editSubstitute(String? clubId, String? seasonId, String? matchId,
      String substituteId, Substitute m) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
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
  Future<bool> editOpponent(
      String? clubId, String? seasonId, String opponentId, Opponent m) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("opponents")
          .doc(opponentId)
          .update({
        OpponentKey.name.value: m.name,
      });
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Player
  Future<bool> editPlayer(
      String? clubId, String? seasonId, String playerId, Player m) async {
    if (clubId == null || seasonId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
          .collection("seasons")
          .doc(seasonId)
          .collection("players")
          .doc(playerId)
          .update({
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
  Future<bool> updateOpponentGoal(String? clubId, String? seasonId,
      String? matchId, int? newOpponentGoal) async {
    if (clubId == null || seasonId == null || matchId == null) return false;

    try {
      await _firestore
          .collection("clubs")
          .doc(clubId)
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

  // Add a Club
  Future<bool> addNewClub(Club c, String? userId) async {
    if (userId == null) return false;

    try {
      final batch = _firestore.batch();

      // Create the club
      final clubRef = _firestore.collection("clubs").doc();
      batch.set(clubRef, {
        ClubKey.teamName.value: c.teamName,
      });

      // Create the account_club relationship with admin role
      final accountClubRef = clubRef.collection("accounts").doc(userId);
      batch.set(accountClubRef, {
        AccountKey.role.value: "admin",
      });

      await batch.commit();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Remove a Club
  Future<bool> removeClub(String clubId) async {
    try {
      await _firestore.collection("clubs").doc(clubId).delete();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  // Edit a Club
  Future<bool> editClub(String clubId, Club c) async {
    try {
      await _firestore.collection("clubs").doc(clubId).update(c.toData());
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
