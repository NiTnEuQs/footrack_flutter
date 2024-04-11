import "package:flamingo/flamingo.dart";
import "package:flamingo_annotation/flamingo_annotation.dart";

part "opponent.flamingo.dart";

class Opponent extends Document<Opponent> {
  Opponent({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
  });

  @Field()
  String? name;

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
