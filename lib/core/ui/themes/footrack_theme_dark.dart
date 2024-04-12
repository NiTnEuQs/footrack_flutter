part of "footrack_themes.dart";

final themeDark = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    titleSmall: GoogleFonts.getFont(
      defaultFont,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.getFont(
      defaultFont,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.getFont(
      defaultFont,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.grey,
    ),
  ),
);
