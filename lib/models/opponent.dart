// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'opponent.g.dart';
//
// @JsonSerializable(explicitToJson: true)
// class Opponent {
//   @JsonKey(ignore: true)
//   String id = "";
//   @JsonKey(name: "name")
//   String name;
//
//   Opponent({
//     required this.name,
//   });
//
//   factory Opponent.fromJson(Map<String, dynamic> json) => _$OpponentFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OpponentToJson(this);
//
//   factory Opponent.fromSnapshot(
//     QueryDocumentSnapshot queryDocumentSnapshot,
//   ) =>
//       _$OpponentFromJson(queryDocumentSnapshot.data() as dynamic)..id = queryDocumentSnapshot.id;
//
//   @override
//   String toString() => 'Opponent<$name>';
// }
