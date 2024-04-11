import "package:flamingo/flamingo.dart";
import "package:flamingo_annotation/flamingo_annotation.dart";

part "account_club.flamingo.dart";

class AccountClub extends Document<AccountClub> {
  AccountClub({
    super.id, // is the club id
    super.snapshot,
    super.values,
    super.collectionRef,
  });

  @Field()
  String? role;

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
