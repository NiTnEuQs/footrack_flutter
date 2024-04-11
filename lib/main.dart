import "package:firebase_core/firebase_core.dart";
import "package:flamingo/flamingo.dart";
import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/core/ui/themes/footrack_themes.dart";
import "package:footrack_front/firebase_options.dart";
import "package:footrack_front/pages/page_loading.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Flamingo.initializeApp();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Footrack",
      theme: themeLight,
      darkTheme: themeDark,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fr"),
      ],
      home: const LoadingPage(),
    );
  }
}
