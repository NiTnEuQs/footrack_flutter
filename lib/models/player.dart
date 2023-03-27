import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';
import 'package:footrack_front/converters/player_role_converter.dart';
import 'package:footrack_front/converters/player_status_converter.dart';
import 'package:footrack_front/enums/player_roles_enum.dart';
import 'package:footrack_front/enums/player_status_enum.dart';

part 'player.flamingo.dart';

class Player extends Document<Player> {
  Player({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
    CollectionReference<Map<String, dynamic>>? collectionRef,
  }) : super(id: id, snapshot: snapshot, values: values, collectionRef: collectionRef);

  @Field()
  String? name;

  String getName({String defaultValue = "-"}) => name ?? defaultValue;

  @Field()
  Timestamp? birthdate;

  @Field()
  String? role;

  PlayerRoleEnum getRole() => const PlayerRoleConverter().fromJson(role);

  @Field()
  String? status;

  PlayerStatusEnum getStatus() => const PlayerStatusConverter().fromJson(status);

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
