part of "footrack_themes.dart";

final themeLight = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightGreen,
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.black,
    ),
    labelMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.grey,
    ),
  ),
);
