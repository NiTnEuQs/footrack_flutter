import 'package:flamingo/flamingo.dart';
import 'package:flamingo_annotation/flamingo_annotation.dart';

part 'opponent.flamingo.dart';

class Opponent extends Document<Opponent> {
  Opponent({
    String? id,
    DocumentSnapshot<Map<String, dynamic>>? snapshot,
    Map<String, dynamic>? values,
    CollectionReference<Map<String, dynamic>>? collectionRef,
  }) : super(id: id, snapshot: snapshot, values: values, collectionRef: collectionRef);

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);

  // Fields

  @Field()
  String? name;

  // Getters

  String getName({String defaultValue = "-"}) => name ?? defaultValue;
}
