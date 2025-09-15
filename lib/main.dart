import 'package:flutter/material.dart';
import 'package:grhsolutions/widgets/request/request.dart';
import 'widgets/comunicados/comunicados.dart';
import 'widgets/horario/horario.dart';
import 'widgets/login/login.dart';
import 'data/notifiers.dart';
import 'theme/custom-themes.dart';
import 'domain/dio.dart';

final api=ApiService(baseUrl: "http://localhost:3000");

void main() => runApp(const MyApp());

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
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: ValueListenableBuilder<bool>(
            valueListenable: isLoggedIn,
            builder: (context, loggedIn, _) {
              if (!loggedIn) {
                return const Login();
              }
              return ValueListenableBuilder<int>(
                valueListenable: renderNotificator,
                builder: (context, selectedIndex, _) {
                  final List<Widget> widgetOptions = [
                    const Comunicados(),
                    const Request(),
                    const Center(child: Text("Vacantes")),
                    const Horario(),
                    const Center(child: Text("Perfil")),
                  ];

                  return Scaffold(
                    body: widgetOptions[selectedIndex],
                    bottomNavigationBar: BottomNavigationBar(
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      iconSize: 20,
                      items: const <BottomNavigationBarItem>[
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
