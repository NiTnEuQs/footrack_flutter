import "package:flamingo/flamingo.dart";
import "package:flamingo_annotation/flamingo_annotation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/extensions/snapshot_extensions.dart";
import "package:footrack_front/models/account_club.dart";

part "account.flamingo.dart";

class Account extends Document<Account> {
  Account({
    super.id,
    super.snapshot,
    super.values,
    super.collectionRef,
    WidgetRef? ref,
  }) {
    clubs = Collection(this, AccountKey.clubs.value);

    init(ref);
  }

  void init(WidgetRef? ref) {
    firestoreInstance.collection(clubs.ref.path).snapshots().listen((snap) {
      ref?.read(accountClubsProvider.notifier).state = snap.map((e) => AccountClub(snapshot: e));
    });
  }

  // Account clubs

  @SubCollection()
  late Collection<AccountClub> clubs;
  final accountClubsProvider = StateProvider<List<AccountClub>>((_) => []);

  // Json

  @override
  Map<String, dynamic> toData() => _$toData(this);

  @override
  void fromData(Map<String, dynamic> data) => _$fromData(this, data);
}
