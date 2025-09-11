
import 'package:flutter/material.dart';

class Comunicados extends StatefulWidget {
  const Comunicados({super.key});

  @override
  State<Comunicados> createState() => _ComunicadosState();
}

class _ComunicadosState extends State<Comunicados> {
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
