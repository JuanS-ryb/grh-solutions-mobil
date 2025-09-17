import 'package:flutter/material.dart';

class SeguimientosView extends StatelessWidget {
  const SeguimientosView({super.key});

  final List<Map<String, String>> seguimientos = const [
    {"texto": "Se ha vuelto péndiente", "autor": "Miguel Andres"},
    {"texto": "Se ha asignado a Carlos Mario", "autor": "Camilo Murillo"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: seguimientos.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final seguimiento = seguimientos[index];
        return ListTile(
          leading: Icon(
            Icons.description_outlined,
            color: Theme.of(context).primaryColor,
            size: 32,
          ),
          title: Text(
            seguimiento["texto"]!,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          subtitle: Text("Por: ${seguimiento["autor"]}"),
        );
      },
    );
  }
}
