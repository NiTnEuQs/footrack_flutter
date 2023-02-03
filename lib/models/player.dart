// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:footrack_front/converters/player_role_converter.dart';
// import 'package:footrack_front/enums/player_roles_enum.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'player.g.dart';
//
// @JsonSerializable(explicitToJson: true)
// @StringConverter()
// class Player {
//   @JsonKey(ignore: true)
//   String id = "";
//   @JsonKey(name: "name")
//   String name;
//   @JsonKey(name: "role")
//   PlayerRoleEnum? role;
//
//   Player({
//     required this.name,
//     this.role,
//   });
//
//   factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PlayerToJson(this);
//
//   factory Player.fromSnapshot(
//     QueryDocumentSnapshot queryDocumentSnapshot,
//   ) =>
//       _$PlayerFromJson(queryDocumentSnapshot.data() as dynamic)..id = queryDocumentSnapshot.id;
//
//   @override
//   String toString() => 'Player<$name>';
// }
