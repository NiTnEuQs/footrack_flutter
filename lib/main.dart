import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flamingo/flamingo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footrack_front/components/generics/generic_error.dart';
import 'package:footrack_front/components/generics/generic_loading.dart';
import 'package:footrack_front/core/ui/app_theme_data.dart';
import 'package:footrack_front/database/firestore_config.dart';
import 'package:footrack_front/di/dependency_injection.dart';
import 'package:footrack_front/extensions/object_extensions.dart';
import 'package:footrack_front/managers/package_manager.dart';
import 'package:footrack_front/screens/seasons_list/ui/seasons_list_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';

import 'firebase_options.dart';

void main() async {
  DependencyInjection.configure();
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

  // Future<FirebaseRemoteConfig> setupRemoteConfig() async {
  //   return FirebaseRemoteConfig.instance.let((it) async {
  //     await it.setConfigSettings(RemoteConfigSettings(
  //       fetchTimeout: const Duration(seconds: 10),
  //       minimumFetchInterval: const Duration(minutes: 10),
  //     ));
  //     await it.setDefaults(Conf.defaults);
  //     await it.fetchAndActivate();
  //     RemoteConfigValue(null, ValueSource.valueStatic);
  //     ref.read(remoteConfigProvider.notifier).state = it;
  //     return it;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Footrack",
      theme: appThemeData,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
      ],
      home: const SeasonsListScreen(),
      // home: FutureBuilder(
      //   future: setupRemoteConfig(),
      //   builder: (context, snap) {
      //     if (snap.hasData) {
      //       return const SeasonsListScreen();
      //     } else if (snap.hasError) {
      //       return const Scaffold(
      //         body: GenericError(
      //           error: "Veuillez redémarrer l'application",
      //         ),
      //       );
      //     } else {
      //       return const Scaffold(
      //         body: GenericLoading(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
