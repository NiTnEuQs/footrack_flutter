import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteConfigProvider = StateProvider<FirebaseRemoteConfig?>((_) => null);

class Conf {
  static const String statsTileEnabled = "stats_tile_enabled";

  static const defaults = {
    statsTileEnabled: false,
  };
}
