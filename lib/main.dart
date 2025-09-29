import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:grhsolutions/widgets/request/request.dart';
import 'widgets/comunicados/comunicados.dart';
import 'widgets/horario/horario.dart';
import 'widgets/login/login.dart';
import 'data/notifiers.dart'; // renderNotificator, isLoggedIn, useDarkTheme
import 'theme/custom-themes.dart';
import 'domain/dio.dart';
import 'widgets/vacants/vacants.dart';
import 'widgets/perfil/perfil.dart';

final api = ApiService(baseUrl: "http://localhost:3000");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null); // <-- inicializa locale
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: useDarkTheme,
      builder: (context, isDarkMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          locale: const Locale("es", "ES"),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('en', 'GB'),
          ],
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: ValueListenableBuilder<bool>(
            valueListenable: isLoggedIn,
            builder: (context, loggedIn, _) {
              if (!loggedIn) return const Login();

              return ValueListenableBuilder<int>(
                valueListenable: renderNotificator,
                builder: (context, selectedIndex, _) {
                  final List<Widget> widgetOptions = [
                    const Comunicados(),
                    const Request(),
                    const Vacant(),
                    const Horario(),
                    const Perfil(),
                  ];

                  return Scaffold(
                    backgroundColor: Theme.of(context).primaryColor,
                    body: widgetOptions[selectedIndex],
                    bottomNavigationBar: BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      iconSize: 20,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.question_mark),
                          label: 'Solicitud',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.work),
                          label: 'Vacancy',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.calendar_month),
                          label: 'Horarios',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: 'Perfil',
                        ),
                      ],
                      currentIndex: selectedIndex,
                      onTap: (index) {
                        renderNotificator.value = index;
                      },
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
