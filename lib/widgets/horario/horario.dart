import 'package:flutter/material.dart';

class Horario extends StatefulWidget {
  const Horario({super.key});

  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
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
