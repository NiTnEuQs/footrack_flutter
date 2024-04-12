part of "footrack_themes.dart";

final themeLight = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightGreen,
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    titleSmall: GoogleFonts.getFont(
      defaultFont,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.getFont(
      defaultFont,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.getFont(
      defaultFont,
      color: Colors.black,
    ),
    labelMedium: GoogleFonts.getFont(
      defaultFont,
      color: Colors.grey,
    ),
  ),
);
