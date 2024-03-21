import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';

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

  @Field()
  Timestamp? birthdate;

  @Field()
  String? role;

  @Field()
  String? status;

  // Overridden

  @override
  bool operator ==(Object other) {
    if (other is! Player) return false;
    return super.id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
