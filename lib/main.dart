import 'package:flutter/material.dart';
import 'widgets/horario/horario.dart';
import 'widgets/login/login.dart';
import 'widgets/layout/layout.dart';
import 'widgets/comunicados/comunicados.dart';
import 'widgets/request/request.dart';
import 'widgets/vacants/vacants.dart';
import 'widgets/vacants/myVacanst.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // useMaterial3: false,
          //
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => const Login(),
          "/vacantes": (context) => const MainLayout(child: Vacant()),
          "/comunicados": (context) => const MainLayout(child: Comunicados()),
          "/horarios": (context) => const MainLayout(child: Horario()),
          "/sol": (context) => const MainLayout(child: Request()),
          "/my_vacants": (context) => const MainLayout(child: myVacant()),
        });
  }
}
