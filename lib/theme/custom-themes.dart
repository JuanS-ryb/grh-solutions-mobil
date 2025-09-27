import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue.shade500,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white, // color de texto/iconos en appbar
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      labelSmall: TextStyle(color: Colors.black87),
      labelMedium: TextStyle(color: Colors.black87),
      labelLarge: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black87),
      displayLarge: TextStyle(color: Colors.black87),
      displayMedium: TextStyle(color: Colors.black87),
      displaySmall: TextStyle(color: Colors.black87),
    ),
    cardColor: Colors.white12,
    iconTheme: const IconThemeData(color: Colors.black87)
    // Añade más personalizaciones que quieras
    );

final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue.shade800,
    scaffoldBackgroundColor: Colors.black45,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black87,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
    ),
    cardColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white)
    // Personaliza más según necesites
    );
final SettingsThemeData settingsLightTheme = SettingsThemeData(
  inactiveSubtitleColor:
      lightTheme.textTheme.bodyMedium?.color ?? Colors.black87,
  inactiveTitleColor: lightTheme.textTheme.bodyLarge?.color ?? Colors.black87,
  leadingIconsColor: lightTheme.iconTheme.color ?? Colors.black87,
  settingsListBackground: Colors.white,
  settingsSectionBackground: Colors.white12,
  settingsTileTextColor:
      lightTheme.textTheme.bodyMedium?.color ?? Colors.black87,
  tileDescriptionTextColor:
      lightTheme.textTheme.bodySmall?.color ?? Colors.black54,
  titleTextColor: lightTheme.textTheme.bodyLarge?.color ?? Colors.black87,
  trailingTextColor: lightTheme.textTheme.bodySmall?.color ?? Colors.black54,
);

final SettingsThemeData settingsDarkTheme = SettingsThemeData(
  inactiveSubtitleColor:
      darkTheme.textTheme.bodyMedium?.color ?? Colors.white70,
  inactiveTitleColor: darkTheme.textTheme.bodyLarge?.color ?? Colors.white70,
  leadingIconsColor: darkTheme.iconTheme.color ?? Colors.white70,
  settingsListBackground: Colors.blue.shade800,
  settingsSectionBackground: Colors.black,
  settingsTileTextColor: darkTheme.textTheme.bodyMedium?.color ?? Colors.white,
  tileDescriptionTextColor:
      darkTheme.textTheme.bodySmall?.color ?? Colors.white70,
  titleTextColor: darkTheme.textTheme.bodyLarge?.color ?? Colors.white,
  trailingTextColor: darkTheme.textTheme.bodySmall?.color ?? Colors.white70,
);
