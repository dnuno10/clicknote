import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
              primary: Color(0xffab3cff)
          ),
    primaryColor: Colors.grey[300],
    secondaryHeaderColor: Colors.grey[200],
    canvasColor: const Color(0xfffd7fff),
    dividerColor:  const Color(0xffab3cff),
    indicatorColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white), // Background for buttons in light theme
        foregroundColor: WidgetStateProperty.all(Colors.black), // Font color for light theme
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
              primary: Color(0xffab3cff)
          ),
    primaryColor: Colors.black,
    secondaryHeaderColor: Colors.grey[850],
    canvasColor: const Color(0xffab3cff),
    dividerColor:  const Color(0xfffd7fff),
    indicatorColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey[800]), // Background for buttons in dark theme
        foregroundColor: WidgetStateProperty.all(Colors.white), // Font color for dark theme
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    ),
  );
}
