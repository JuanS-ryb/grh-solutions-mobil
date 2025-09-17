import 'package:flutter/material.dart';
import 'widgets/horario/horario.dart';
import 'widgets/login/login.dart';
import 'widgets/layout/layout.dart';
import 'widgets/comunicados.dart';
import 'widgets/contratos/contratos.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      routes: {
        "/": (context) => const Login(),
        "/comunicados": (context) => const MainLayout(child: Comunicados()),
        "/horarios": (context) => const MainLayout(child: Horario()),

        // Aquí pasamos variables de fechas
        "/contratos": (context) => MainLayout(
              child: Contrato(
                startDate: DateTime(2025, 9, 1),
                endDate: DateTime(2026, 3, 1),
              ),
            ),
      },
    );
  }
}
