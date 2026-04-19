import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get dark {
    const bg = Color(0xFF0F1216);
    const card = Color(0xFF1B1B1D);
    const accent = Color(0xFF7AFF6B);

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accent,
        surface: card,
      ),
      fontFamily: 'Rubik',
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
