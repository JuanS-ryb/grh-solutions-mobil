import 'package:flutter/material.dart';
import '../base_scaffold.dart';

class ViewVacants extends StatefulWidget {
  final String id;

  const ViewVacants({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewVacants> createState() => _ViewVacantsState();
}

class _ViewVacantsState extends State<ViewVacants> {
  // Lista simulada de vacantes
  final List<Map<String, dynamic>> vacants = [
    {
      "id": "1",
      "title": "Se necesita programador.",
      "desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas fringilla...",
      "salary": "2.500.000",
      "date": "15/01/2025",
      "remote": true,
    },
    {
      "id": "2",
      "title": "Se necesita acceador.",
      "desc": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ante ipsum primis...",
      "salary": "2.000.000",
      "date": "15/01/2025",
      "remote": false,
    },
    {
      "id": "3",
      "title": "Se necesita asistente.",
      "desc": "Donec eu blandit dolor, id pulvinar erat. Class aptent taciti sociosqu ad litora torquent...",
      "salary": "1.800.000",
      "date": "15/01/2025",
      "remote": true,
    },
  ];

  Map<String, dynamic>? selectedVacant;

  @override
  void initState() {
    super.initState();
    selectedVacant =
        vacants.firstWhere((vac) => vac["id"] == widget.id, orElse: () => {});
  }

  @override
  Widget build(BuildContext context) {
    if (selectedVacant == null || selectedVacant!.isEmpty) {
      return BaseScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Detalle de vacante"),
        ),
        body: const Center(child: Text("Vacante no encontrada")),
      );
    }

    return BaseScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        title: Text(
          selectedVacant!["title"],
          style: const TextStyle(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Descripción larga
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  selectedVacant!["desc"],
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Caja con detalles
            Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.star_border),
                    title: const Text("Salario"),
                    subtitle: Text(selectedVacant!["salary"]),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text("Fecha de vencimiento"),
                    subtitle: Text(selectedVacant!["date"]),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: const Text("Es remoto?"),
                    subtitle: Text(selectedVacant!["remote"] ? "SI" : "NO"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Botón aplicar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Postulación enviada ✅")),
                  );
                },
                icon: const Icon(Icons.send, color: Colors.white, size: 18),
                label: const Text(
                  "APLICAR",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
