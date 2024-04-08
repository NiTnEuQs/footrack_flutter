import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_config.dart';
import 'package:footrack_front/database/ft_firestore.dart';
import 'package:footrack_front/models/account.dart';
import 'package:footrack_front/models/club.dart';
import 'package:footrack_front/models/match.dart';
import 'package:footrack_front/models/season.dart';

final dbProvider = Provider((_) => DatabaseFirestore());
final languageCodeProvider = StateProvider<String>((_) => "fr");

final seasonsProvider = StateProvider<List<Season>>((_) => []);
final clubChoseProvider = StateProvider<Club?>((_) => null);
final seasonChoseProvider = StateProvider<Season?>((_) => null);
final matchChoseProvider = StateProvider<Match?>((_) => null);

final userProvider = StateProvider<User?>((ref) => null);
final accountProvider = StateProvider<Account?>((ref) => null);

final userStreamProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);
final accountStreamProvider = StreamProvider<Account?>(
  (ref) {
    var user = ref.watch(userProvider);

    if (user != null) {
      return FirebaseFirestore.instance.collection('accounts').doc(user.uid).snapshots().map(
            (snap) => Account(snapshot: snap),
          );
    } else {
      return const Stream.empty();
    }
  },
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
