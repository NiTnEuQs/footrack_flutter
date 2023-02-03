import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:footrack_front/converters/date_time_converter.dart';
import 'package:footrack_front/converters/document_reference_converter.dart';
import 'package:footrack_front/converters/player_role_converter.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'season.g.dart';

@Collection<Season>('seasons', name: "seasons")
@Collection<Player>('seasons/*/players', name: "players")
@Collection<Opponent>('seasons/*/opponents', name: "opponents")
@Collection<Match>('seasons/*/matchs', name: "matchs")
@Collection<Goal>('seasons/*/matchs/*/goals', name: "goals")
@Collection<Substitute>('seasons/*/matchs/*/substitutes', name: "substitutes")
final seasonsRef = SeasonCollectionReference();

extension QueryDocumentSnapshotToModel on FirestoreQueryDocumentSnapshot {
  T toModel<T>() {
    return data..id = id;
  }
}

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class Season {
  @JsonKey(ignore: true)
  String id = "";
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "team_name")
  String? teamName;
  @JsonKey(name: "from")
  DateTime? from;
  @JsonKey(name: "to")
  DateTime? to;

  Season({
    required this.name,
    this.teamName,
    this.from,
    this.to,
  });

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  factory Season.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return _$SeasonFromJson(
      documentSnapshot.data() as dynamic,
    )..id = documentSnapshot.id;
  }

  @override
  String toString() => 'Season<$name>';
}

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class Match {
  @JsonKey(ignore: true)
  String id = "";

  @JsonKey(name: "opponent")
  @DocumentReferenceConverter()
  DocumentReference? opponentRef;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "score_opponent")
  int? scoreOpponent;
  @JsonKey(ignore: true)
  int scoreTeam = 0;

  Match({
    required this.opponentRef,
    this.date,
    this.scoreOpponent = 0,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);

  Map<String, dynamic> toJson() => _$MatchToJson(this);

  factory Match.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return _$MatchFromJson(
      documentSnapshot.data() as dynamic,
    )..id = documentSnapshot.id;
  }

  String resultString() {
    if (scoreOpponent == null) return "Erreur";

    if (scoreTeam.compareTo(scoreOpponent!).isEven == true) {
      return "Egalité";
    } else if (scoreTeam.compareTo(scoreOpponent!).isNegative == true) {
      return "Défaite";
    } else {
      return "Victoire";
    }
  }

  Color resultColor() {
    if (scoreOpponent == null) return Colors.black;

    if (scoreTeam.compareTo(scoreOpponent!).isEven == true) {
      return Colors.black.withAlpha(150);
    } else if (scoreTeam.compareTo(scoreOpponent!).isNegative == true) {
      return Colors.red.withAlpha(150);
    } else {
      return Colors.green.withAlpha(150);
    }
  }

  @override
  String toString() => 'Match<$date>';
}

@JsonSerializable(explicitToJson: true)
@PlayerRoleConverter()
@DateTimeConverter()
class Player {
  @JsonKey(ignore: true)
  String id = "";
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "birthdate")
  DateTime? birthdate;
  @JsonKey(name: "role")
  PlayerRoleEnum? role;

  Player({
    required this.name,
    this.birthdate,
    this.role,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  factory Player.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return _$PlayerFromJson(
      documentSnapshot.data() as dynamic,
    )..id = documentSnapshot.id;
  }

  @override
  String toString() => 'Player<$name>';
}

@JsonSerializable(explicitToJson: true)
class Goal {
  @JsonKey(ignore: true)
  String id = "";
  @JsonKey(name: "scorer")
  @DocumentReferenceConverter()
  DocumentReference? scorerRef;
  @JsonKey(name: "passer")
  @DocumentReferenceConverter()
  DocumentReference? passerRef;
  @JsonKey(name: "time")
  int? time;

  Goal({
    required this.scorerRef,
    required this.passerRef,
    required this.time,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);

  factory Goal.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return _$GoalFromJson(
      documentSnapshot.data() as dynamic,
    )..id = documentSnapshot.id;
  }

  @override
  String toString() => 'Goal<${passerRef?.id} -> ${scorerRef?.id}>';
}

@JsonSerializable(explicitToJson: true)
class Substitute {
  @JsonKey(ignore: true)
  String id = "";
  @JsonKey(name: "player_in")
  @DocumentReferenceConverter()
  DocumentReference? playerInRef;
  @JsonKey(name: "player_out")
  @DocumentReferenceConverter()
  DocumentReference? playerOutRef;
  @JsonKey(name: "time")
  int? time;

  Substitute({
    required this.playerInRef,
    required this.playerOutRef,
    required this.time,
  });

  factory Substitute.fromJson(Map<String, dynamic> json) => _$SubstituteFromJson(json);

  Map<String, dynamic> toJson() => _$SubstituteToJson(this);

  factory Substitute.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return _$SubstituteFromJson(
      documentSnapshot.data() as dynamic,
    )..id = documentSnapshot.id;
  }

  @override
  String toString() => 'Substitute<${playerOutRef?.id} -> ${playerInRef?.id}>';
}

@JsonSerializable(explicitToJson: true)
class Opponent {
  @JsonKey(ignore: true)
  String id = "";
  @JsonKey(name: "name")
  String name;

  Opponent({
    required this.name,
  });

  factory Opponent.fromJson(Map<String, dynamic> json) => _$OpponentFromJson(json);

  Map<String, dynamic> toJson() => _$OpponentToJson(this);

  factory Opponent.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return _$OpponentFromJson(
      documentSnapshot.data() as dynamic,
    )..id = documentSnapshot.id;
  }

  @override
  String toString() => 'Opponent<$name>';
}
