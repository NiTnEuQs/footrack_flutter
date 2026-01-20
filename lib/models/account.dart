import "package:flamingo/flamingo.dart";
import "package:flamingo_annotation/flamingo_annotation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

part "account.flamingo.dart";

class Account extends Document<Account> {
  Account({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
    WidgetRef? ref,
  });

  @Field()
  String? role;

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
