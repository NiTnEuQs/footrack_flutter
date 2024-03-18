import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/database/ft_config.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/managers/package_manager.dart';
import 'package:footrack_front/pages/page_seasons_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Flamingo.initializeApp();
  // await AppCenter.startAsync(
  //   appSecretAndroid: '59ae1a3e-1468-4615-acba-13d3ae46e096',
  //   appSecretIOS: '25aac2ec-e29f-46ea-a734-589576fa6417',
  //   enableAnalytics: true,
  //   enableCrashes: true,
  //   enableDistribute: true,
  //   usePrivateDistributeTrack: false,
  //   disableAutomaticCheckForUpdate: false,
  // );
  // var res = await AppCenter.checkForUpdateAsync();

  PackageManager.packageInfo = await PackageInfo.fromPlatform();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();

    initializeLocale();
  }

  void initializeLocale() async {
    var language = "fr";
    // var language = Localizations.localeOf(context).languageCode;

    await initializeDateFormatting(language);
    Intl.defaultLocale = language;
  }

  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    return FirebaseRemoteConfig.instance.let((it) async {
      await it.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 10),
      ));
      await it.setDefaults(Conf.defaults);
      await it.fetchAndActivate();
      RemoteConfigValue(null, ValueSource.valueStatic);
      ref.read(remoteConfigProvider.notifier).state = it;
      return it;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Footrack",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder<FirebaseRemoteConfig>(
        future: setupRemoteConfig(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          if (snapshot.hasData) {
            return const SeasonsListPage();
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Une erreur est survenue, veuillez redémarrer l'application"),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
