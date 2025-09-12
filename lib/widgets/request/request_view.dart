import 'package:flutter/material.dart';
import 'historial_view.dart';
import 'asignados_view.dart';
import 'seguimientos_view.dart';
import 'request_edit.dart';

class RequestView extends StatefulWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  String selectedTab = "DETALLES"; // pestaña activa por defecto

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: "DETALLES", label: Text("DETALLES")),
                ButtonSegment(value: "HISTORIAL", label: Text("HISTORIAL")),
                ButtonSegment(value: "ASIGNADOS", label: Text("ASIGNADOS")),
                ButtonSegment(
                    value: "SEGUIMIENTOS", label: Text("SEGUIMIENTOS")),
              ],
              selected: {selectedTab},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selectedTab = newSelection.first;
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return theme.colorScheme.primary;
                  }
                  return theme.colorScheme.primary.withOpacity(0.1);
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return theme.colorScheme.onPrimary;
                  }
                  return theme.colorScheme.primary;
                }),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: theme.cardColor,
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildContent(theme),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const EditRequestButton(),
    );
  }

  Widget _buildContent(ThemeData theme) {
    switch (selectedTab) {
      case "DETALLES":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Radicado:", "SOL-20250313", theme),
            Divider(color: theme.dividerColor),
            _buildDetailRow("Titulo:", "Solicitud urgente.", theme),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Estado:",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(), // 🔹 Esto empuja el estado al extremo derecho
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100, // estado aprobado
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(
                    "Aprobada",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow("Tipo:", "Prestamo.", theme),
            const SizedBox(height: 12),
            _buildDetailRow("Desde:", "3/31/23 2:52 PM", theme),
            const SizedBox(height: 12),
            _buildDetailRow("Hasta:", "09/10/24 10:45 AM", theme),
            const SizedBox(height: 12),
            Text(
              "Descripcion:",
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text("Descripcion generica", style: theme.textTheme.bodyMedium),
          ],
        );

      case "HISTORIAL":
        return const HistorialView();

      case "ASIGNADOS":
        return const AsignadosView();

      case "SEGUIMIENTOS":
        return const SeguimientosView();

      default:
        return const SizedBox();
    }
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        Flexible(child: Text(value, style: theme.textTheme.bodyMedium)),
      ],
    );
  }
}

class EditRequestButton extends StatelessWidget {
  const EditRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton(
      backgroundColor: theme.colorScheme.primary,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestEdit(
              title: "Solicitud urgente.",
              description: "Descripcion generica",
              type: "prestamo",
              fromDate: DateTime(2023, 3, 31, 14, 52),
              toDate: DateTime(2024, 9, 10, 10, 45),
            ),
          ),
        );
      },
      child: Icon(Icons.edit, color: theme.colorScheme.onPrimary),
    );
  }
}
