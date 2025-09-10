import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
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
