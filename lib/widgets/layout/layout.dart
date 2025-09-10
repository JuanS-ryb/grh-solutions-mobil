import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  static const List<String> routes = [
    '/comunicados',
    '/horarios',
    '/profile',
    '/vacantes',
    '/solicitud'
  ];

  int getSelectedIndex(BuildContext context) {
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
    return routes.indexOf(currentRoute);
  }

  void onDestinationSelected(BuildContext context, int index) {
    final String selectedRoute = routes[index];
    if (ModalRoute.of(context)?.settings.name != selectedRoute) {
      Navigator.pushReplacementNamed(context, selectedRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = getSelectedIndex(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => onDestinationSelected(context, index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.mail), label: 'Comunicados'),
          NavigationDestination(
              icon: Icon(Icons.calendar_month), label: 'Horarios'),
          NavigationDestination(icon: Icon(Icons.info), label: 'Solicitudes'),
          NavigationDestination(icon: Icon(Icons.work), label: 'Vacantes'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: child,
    );
  }
}
