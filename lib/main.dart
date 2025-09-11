import 'package:flutter/material.dart';
import 'package:grhsolutions/widgets/request/request.dart';
import 'widgets/comunicados/comunicados.dart';
import 'widgets/horario/horario.dart';
import 'widgets/login/login.dart';
import 'data/notifiers.dart'; // donde tienes renderNotificator y isLoggedIn

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ValueListenableBuilder<bool>(
        valueListenable: isLoggedIn,
        builder: (context, loggedIn, _) {
          // Si no está logeado, mostramos el Login
          if (!loggedIn) {
            return const Login(); // Puedes cambiar esto por tu widget real de login
          }

          // Si está logeado, mostramos la app principal con BottomNavigationBar
          return ValueListenableBuilder<int>(
            valueListenable: renderNotificator,
            builder: (context, selectedIndex, _) {
              final List<Widget> widgetOptions = [
                const Comunicados(),
                const Request(),
                const Center(
                  child: Text("Vacantes"),
                ),
                const Horario(),
                const Center(child: Text("Perfil")),
              ];

              return Scaffold(
                body: widgetOptions[selectedIndex],
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 20,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home', // COMUNICADOS
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.question_mark),
                      label: 'Solicitud', // REQUEST
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.work),
                      label: 'VANCANCY',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month),
                      label: 'HORARIOS',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'PERFIL',
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
  }
}
