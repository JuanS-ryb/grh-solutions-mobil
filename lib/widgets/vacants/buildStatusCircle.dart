import 'package:flutter/material.dart';

Widget buildStatusCircle(String status) {
  double progress = 0.0;
  Color color = Colors.grey;

  switch (status) {
    case "aprobado":
      progress = 1.0; // círculo lleno
      color = Colors.green;
      break;
    case "proceso":
      progress = 0.5; // mitad del círculo
      color = Colors.blue;
      break;
    case "rechazado":
      progress = 1.0; // lleno
      color = Colors.red;
      break;
  }

  return SizedBox(
    width: 40,
    height: 40,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: progress,
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          backgroundColor: Colors.grey.shade300,
        ),
        const Icon(Icons.work_outline, size: 20),
      ],
    ),
  );
}
