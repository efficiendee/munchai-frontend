import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get dark {
    const bg = Color(0xFF0F1216);
    const card = Color(0xFF1B1B1D);
    const accent = Color(0xFF2FD4CB);

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accent,
        surface: card,
      ),
      fontFamily: 'Rubik',
      appBarTheme: const AppBarTheme(backgroundColor: bg, elevation: 0),
      cardTheme: CardThemeData(
        color: card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Color(0xFF152228),
        selectedColor: accent,
        labelStyle: TextStyle(color: Colors.white),
        secondaryLabelStyle: TextStyle(color: Color(0xFF042A2F)),
      ),
    );
  }

  static ThemeData get light {
    const bg = Color(0xFFF4F7F8);
    const card = Colors.white;
    const accent = Color(0xFF0EAAA2);

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.light(
        primary: accent,
        secondary: accent,
        surface: card,
      ),
      fontFamily: 'Rubik',
      appBarTheme: const AppBarTheme(backgroundColor: bg, elevation: 0),
      cardTheme: CardThemeData(
        color: card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
