import 'package:flutter/material.dart';
import './../../../data/notifiers.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import './../../../theme/custom-themes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ValueListenableBuilder<bool>(
        valueListenable: useDarkTheme,
        builder: (context, isDark, _) {
          return SettingsList(
            applicationType: ApplicationType.material,
            darkTheme: settingsDarkTheme,
            lightTheme: settingsLightTheme,
            contentPadding: const EdgeInsets.all(2),
            sections: [
              SettingsSection(
                title: const Text("Personalizacion"),
                tiles: [
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      useDarkTheme.value = value;
                    },
                    initialValue: isDark,
                    leading: const Icon(Icons.format_paint),
                    title: const Text('Tema oscuro'),
                  ),
                ],
              ),
              SettingsSection(
                title: const Text("Cuenta"),
                tiles: [
                  SettingsTile.navigation(
                    onPressed: (context) => {
                      loginController.value = null,
                      isLoggedIn.value = false
                    },
                    leading: const Icon(Icons.close),
                    title: const Text('Cerrar sesion'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
