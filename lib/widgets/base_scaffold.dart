import 'package:flutter/material.dart';
import '../data/notifiers.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const BaseScaffold({Key? key, required this.body, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: renderNotificator,
      builder: (context, selectedIndex, _) {
        return Scaffold(
          appBar: appBar,
          body: body,
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
  }
}
