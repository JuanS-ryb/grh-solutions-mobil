import 'package:flutter/material.dart';

class HistorialView extends StatelessWidget {
  const HistorialView({super.key});

  final List<Map<String, String>> historial = const [
    {
      "fecha": "01/05/2025, 07:05 pm",
      "usuario": "Miguel Angel",
      "detalle": "Versión actual"
    },
    {
      "fecha": "01/05/2025, 03:05 pm",
      "usuario": "Miguel Angel",
      "detalle": ""
    },
    {
      "fecha": "01/05/2025, 02:05 pm",
      "usuario": "Miguel Angel",
      "detalle": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // evita conflicto con scroll del padre
      itemCount: historial.length,
      itemBuilder: (context, index) {
        final item = historial[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.history,
                    color: Theme.of(context).primaryColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["fecha"]!,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.person, size: 16),
                          const SizedBox(width: 4),
                          Text(item["usuario"]!),
                          if (item["detalle"]!.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            const Icon(Icons.access_time, size: 16),
                            const SizedBox(width: 4),
                            Text(item["detalle"]!),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
