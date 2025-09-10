import 'package:flutter/material.dart';
import 'widgets/horario/horario.dart';
import 'widgets/login/login.dart';
import 'widgets/layout/layout.dart';
import 'widgets/comunicados/comunicados.dart';
import 'widgets/request/request.dart';

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
          "/comunicados": (context) => const MainLayout(child: Comunicados()),
          "/horarios": (context) => const MainLayout(child: Horario()),
          "/sol": (context) => const MainLayout(child: Request()),
        });
  }
}
