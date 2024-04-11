part of "footrack_themes.dart";

final themeDark = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.grey,
    ),
  ),
);
