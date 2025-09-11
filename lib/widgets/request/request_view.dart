import 'package:flutter/material.dart';

class RequestView extends StatelessWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con botón atrás
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // vuelve a request.dart
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Botones superiores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTab("DETALLES", true),
                _buildTab("HISTORIAL", false),
                _buildTab("ASIGNADOS", false),
                _buildTab("SEGUIMIENTOS", false),
              ],
            ),
            const SizedBox(height: 20),

            // Tarjeta con detalles
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow("Radicado:", "SOL-20250313"),
                        const Divider(),
                        _buildDetailRow("Titulo:", "Solicitud urgente."),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text(
                              "Estado:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: const Text(
                                "Aprobada",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow("Tipo:", "Prestamo."),
                        const SizedBox(height: 12),
                        _buildDetailRow("Desde:", "3/31/23 2:52 PM"),
                        const SizedBox(height: 12),
                        _buildDetailRow("Hasta:", "09/10/24 10:45 AM"),
                        const SizedBox(height: 12),
                        const Text(
                          "Descripcion:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text("Descripcion generica"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Botón flotante (lapiz)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Aquí luego irá la navegación hacia editar solicitud
        },
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  // Widget para filas con texto
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Flexible(child: Text(value)),
      ],
    );
  }

  // Widget para botones superiores
  Widget _buildTab(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
