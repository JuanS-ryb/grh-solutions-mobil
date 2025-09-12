import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(child: const Text("hola buenas tardes")),
        Container(
          child: const Text("hoal"),
        )
      ],
    );
  }
}
