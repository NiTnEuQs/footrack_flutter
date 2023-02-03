// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:footrack_front/converters/timestamp_converter.dart';
// import 'package:footrack_front/models/opponent.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'match.g.dart';
//
// @JsonSerializable(explicitToJson: true)
// @TimestampConverter()
// class Match {
//   @JsonKey(ignore: true)
//   String id = "";
//   // @JsonKey(name: "opponent")
//   // Opponent opponent;
//   @JsonKey(name: "date")
//   DateTime? date;
//   @JsonKey(name: "score_team")
//   int scoreTeam;
//   @JsonKey(name: "score_opponent")
//   int scoreOpponent;
//
//   Match({
//     // required this.opponent,
//     this.date,
//     this.scoreTeam = 0,
//     this.scoreOpponent = 0,
//   });
//
//   factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
//
//   Map<String, dynamic> toJson() => _$MatchToJson(this);
//
//   factory Match.fromSnapshot(
//     QueryDocumentSnapshot queryDocumentSnapshot,
//   ) =>
//       _$MatchFromJson(queryDocumentSnapshot.data() as dynamic)..id = queryDocumentSnapshot.id;
//
//   @override
//   String toString() => 'Match<$date>';
// }
