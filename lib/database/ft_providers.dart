import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_remote_config/firebase_remote_config.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/database/ft_config.dart";
import "package:footrack_front/database/ft_firestore.dart";
import "package:footrack_front/extensions/snapshot_extensions.dart";
import "package:footrack_front/models/account.dart";
import "package:footrack_front/models/club.dart";
import "package:footrack_front/models/match.dart";
import "package:footrack_front/models/season.dart";
import "package:intl/date_symbol_data_local.dart";
import "package:intl/intl.dart";
import "package:package_info_plus/package_info_plus.dart";

final dbProvider = Provider((_) => DatabaseFirestore());
final languageCodeProvider = StateProvider<String>((_) => "fr");
final packageInfoProvider = StateProvider<PackageInfo?>((_) => null);

final clubChoseProvider = StateProvider<Club?>((_) => null);
final seasonChoseProvider = StateProvider<Season?>((_) => null);
final matchChoseProvider = StateProvider<Match?>((_) => null);

final userProvider =
    Provider<User?>((ref) => ref.watch(userStreamProvider).value);

final isUserConnectedProvider =
    Provider<bool>((ref) => ref.watch(userProvider) != null);

final accountProvider = StateProvider<Account?>((ref) => null);

final userStreamProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);
// final accountStreamProvider = StreamProvider<Account?>(
//   (ref) {
//     var user = ref.watch(userProvider);
//
//     if (user != null) {
//       return FirebaseFirestore.instance
//           .collection("accounts")
//           .doc(user.uid)
//           .snapshots()
//           .map(
//             (snap) => Account(snapshot: snap),
//           );
//     } else {
//       return const Stream.empty();
//     }
//   },
// );

final clubsStreamProvider = StreamProvider<List<Club>>(
  (ref) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return Stream.value(<Club>[]);
    }

    // User is authenticated, proceed with query
    FirebaseFirestore.setLoggingEnabled(true);
    final clubsCollection = FirebaseFirestore.instance.collection("clubs");
    return clubsCollection.snapshots().map(
          (querySnap) =>
              querySnap.map((snap) => Club(snapshot: snap, ref: ref)).toList(),
        );
  },
  // (ref) {
  //   var account = ref.watch(accountProvider);
  //   if (account == null) {
  //     return Stream.value([]);
  //   }
  //   var accountClubs = ref.watch(account.accountClubsProvider);
  //   if (accountClubs.isEmpty) {
  //     return Stream.value([]);
  //   }
  //
  //   var clubIds = accountClubs.map((ac) => ac.getClubId()).toList();
  //   if (clubIds.isEmpty) {
  //     return Stream.value([]);
  //   }
  //
  //   // Firestore whereIn has a limit of 10, so we need to handle batching
  //   // For now, we'll take the first 10. In production, you'd want to batch queries
  //   var limitedClubIds = clubIds.take(10).toList();
  //
  //   if (limitedClubIds.length == 1) {
  //     return FirebaseFirestore.instance
  //         .collection("clubs")
  //         .doc(limitedClubIds.first)
  //         .snapshots()
  //         .map((snap) =>
  //             snap.exists ? [Club(snapshot: snap, ref: ref)] : <Club>[]);
  //   }
  //
  //   return FirebaseFirestore.instance
  //       .collection("clubs")
  //       .where(FieldPath.documentId, whereIn: limitedClubIds)
  //       .snapshots()
  //       .map((querySnap) => querySnap.docs
  //           .map((snap) => Club(snapshot: snap, ref: ref))
  //           .toList());
  // },
);

final seasonsStreamProvider = StreamProvider<List<Season>>(
  (ref) {
    var club = ref.watch(clubChoseProvider);
    if (club?.id == null) {
      return Stream.value([]);
    }
    return FirebaseFirestore.instance
        .collection("clubs")
        .doc(club!.id)
        .collection("seasons")
        .snapshots()
        .map((querySnap) =>
            querySnap.map((snap) => Season(snapshot: snap, ref: ref)).toList());
  },
);

final localeFutureProvider = FutureProvider<void>(
  (ref) async {
    var language = "fr";
    // var language = Localizations.localeOf(context).languageCode;

    ref.read(languageCodeProvider.notifier).state = language;
    await initializeDateFormatting(language);
    Intl.defaultLocale = language;
  },
);

final orientationFutureProvider = FutureProvider<void>(
  (ref) async => await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]),
);

final remoteConfigFutureProvider = FutureProvider<FirebaseRemoteConfig>(
  (ref) async {
    var config = FirebaseRemoteConfig.instance;
    await config.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 10),
      ),
    );
    await config.setDefaults(Conf.defaults);
    await config.fetchAndActivate();
    RemoteConfigValue(null, ValueSource.valueStatic);

    return config;
  },
);
