import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

ThemeData buildTheme({
  required Brightness brightness,
  required Color primaryColor,
  required Color scaffoldBackground,
  required Color appBarBackground,
  required Color appBarForeground,
  required Color bottomNavBackground,
  required Color selectedItemColor,
  required Color unselectedItemColor,
  required Color textColor,
  required Color cardColor,
  required Color iconColor,
}) {
  return ThemeData(
    brightness: brightness,
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: appBarBackground,
      foregroundColor: appBarForeground,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomNavBackground,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: textColor),
      labelSmall: TextStyle(color: textColor),
      labelMedium: TextStyle(color: textColor),
      labelLarge: TextStyle(color: textColor),
      bodyLarge: TextStyle(color: textColor),
      bodySmall: TextStyle(color: textColor),
      displayLarge: TextStyle(color: textColor),
      displayMedium: TextStyle(color: textColor),
      displaySmall: TextStyle(color: textColor),
    ),
    cardColor: cardColor,
    iconTheme: IconThemeData(color: iconColor),
  );
}

SettingsThemeData buildSettingsTheme({
  required ThemeData theme,
  required Color settingsListBackground,
  required Color settingsSectionBackground,
  required Color tileDescriptionTextColor,
  required Color trailingTextColor,
}) {
  return SettingsThemeData(
    inactiveSubtitleColor: theme.textTheme.bodyMedium?.color,
    inactiveTitleColor: theme.textTheme.bodyLarge?.color,
    leadingIconsColor: theme.iconTheme.color,
    settingsListBackground: settingsListBackground,
    settingsSectionBackground: settingsSectionBackground,
    settingsTileTextColor: theme.textTheme.bodyMedium?.color,
    tileDescriptionTextColor: tileDescriptionTextColor,
    titleTextColor: theme.textTheme.bodyLarge?.color,
    trailingTextColor: trailingTextColor,
  );
}

// Tema claro
final ThemeData lightTheme = buildTheme(
  brightness: Brightness.light,
  primaryColor: Colors.blue.shade500,
  scaffoldBackground: Colors.white,
  appBarBackground: Colors.blue,
  appBarForeground: Colors.white,
  bottomNavBackground: Colors.white,
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
  textColor: Colors.black87,
  cardColor: Colors.white12,
  iconColor: Colors.black87,
);

final SettingsThemeData settingsLightTheme = buildSettingsTheme(
  theme: lightTheme,
  settingsListBackground: Colors.transparent,
  settingsSectionBackground: Colors.transparent,
  tileDescriptionTextColor: Colors.black54,
  trailingTextColor: Colors.black54,
);

// Tema oscuro
final ThemeData darkTheme = buildTheme(
  brightness: Brightness.dark,
  primaryColor: Colors.blue.shade800,
  scaffoldBackground: Colors.black45,
  appBarBackground: Colors.black87,
  appBarForeground: Colors.white,
  bottomNavBackground: Colors.black87,
  selectedItemColor: Colors.blueAccent,
  unselectedItemColor: Colors.grey,
  textColor: Colors.white,
  cardColor: Colors.black,
  iconColor: Colors.white,
);

final SettingsThemeData settingsDarkTheme = buildSettingsTheme(
  theme: darkTheme,
  settingsListBackground: Colors.transparent,
  settingsSectionBackground: Colors.transparent,
  tileDescriptionTextColor: Colors.white70,
  trailingTextColor: Colors.white70,
);
