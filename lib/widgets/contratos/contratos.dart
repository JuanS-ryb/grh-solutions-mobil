import 'package:flutter/material.dart';

class Contrato extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;

  const Contrato({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysLeft = endDate.difference(now).inDays;

    // Indicador visual según días restantes
    Color indicatorColor;
    String indicatorText;

    if (daysLeft <= 0) {
      indicatorColor = Colors.red;
      indicatorText = "Contrato vencido";
    } else if (daysLeft <= 30) {
      indicatorColor = Colors.orange;
      indicatorText = "Próximo a vencer ($daysLeft días)";
    } else {
      indicatorColor = Colors.green;
      indicatorText = "Activo ($daysLeft días restantes)";
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contrato"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contrato de Prestación de Servicios",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text("Inicio: ${startDate.day}/${startDate.month}/${startDate.year}"),
                Text("Fin: ${endDate.day}/${endDate.month}/${endDate.year}"),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Icon(Icons.circle, color: indicatorColor, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      indicatorText,
                      style: TextStyle(
                        color: indicatorColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const Divider(height: 32),

                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PdfViewerPage()),
                        );
                      },
                      icon: const Icon(Icons.visibility),
                      label: const Text("Ver contrato"),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Descargando PDF...")),
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text("Descargar PDF"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  const PdfViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visor de contrato")),
      body: const Center(
        child: Text(
          "Aquí iría el visor integrado de PDF 📄",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
