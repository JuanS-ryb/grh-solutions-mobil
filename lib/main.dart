import 'package:flutter/material.dart';
import 'widgets/horario/horario.dart';
import 'widgets/login/login.dart';
import 'widgets/layout/layout.dart';
import 'widgets/comunicados.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // useMaterial3: false,
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => const Login(),
          "/comunicados": (context) => const MainLayout(child: Comunicados()),
          "/horarios": (context) => const MainLayout(child: Horario())
        });
  }
}
