import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/request/request-models.dart';
import '../../services/request/history-services.dart';
import 'historial_view.dart';
import 'asignados_view.dart';
import 'seguimientos_view.dart';
import 'request_edit.dart';

class RequestView extends StatefulWidget {
  final RequestItem request;

  const RequestView({Key? key, required this.request}) : super(key: key);

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  String selectedTab = "DETALLES";

  String formatDate(DateTime date) {
    return DateFormat("dd MMM yyyy, hh:mm a").format(date);
  }

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
            // --- Selector de pestañas ---
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: "DETALLES", label: Text("DETALLES")),
                ButtonSegment(value: "HISTORIAL", label: Text("HISTORIAL")),
                ButtonSegment(value: "ASIGNADOS", label: Text("ASIGNADOS")),
                ButtonSegment(value: "SEGUIMIENTOS", label: Text("SEGUIMIENTOS")),
              ],
              selected: {selectedTab},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selectedTab = newSelection.first;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return theme.colorScheme.primary;
                  }
                  return theme.colorScheme.primary.withOpacity(0.1);
                }),
                foregroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return theme.colorScheme.onPrimary;
                  }
                  return theme.colorScheme.primary;
                }),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // --- Contenido ---
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      floatingActionButton: EditRequestButton(request: widget.request),
    );
  }

  Widget _buildContent(ThemeData theme) {
    final req = widget.request;

    switch (selectedTab) {
      case "DETALLES":
        Color statusColor;
        switch (req.status.toLowerCase()) {
          case "aprobada":
            statusColor = Colors.green.shade100;
            break;
          case "rechazada":
            statusColor = Colors.red.shade100;
            break;
          default:
            statusColor = Colors.grey.shade200;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Radicado:", req.id, theme),
            Divider(color: theme.dividerColor),
            _buildDetailRow("Titulo:", req.title.isNotEmpty ? req.title : "Sin título", theme),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Estado:",
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(
                    req.status,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow("Tipo:", req.typeRequest.isNotEmpty ? req.typeRequest : "otro", theme),
            const SizedBox(height: 12),
            _buildDetailRow("Creado:", formatDate(req.createdAt), theme),
            const SizedBox(height: 12),
            _buildDetailRow("Actualizado:", formatDate(req.updatedAt), theme),
            const SizedBox(height: 12),
            Text("Descripcion:", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(req.infoDx ?? "-", style: theme.textTheme.bodyMedium),
          ],
        );

      case "HISTORIAL":
        // 🔹 Aquí pasamos correctamente el requestId
        return HistorialView(requestId: req.id);

      case "ASIGNADOS":
        return AsignadosView(requestId: req.id);

      case "SEGUIMIENTOS":
        return SeguimientosView(requestId: req.id);

      default:
        return const SizedBox();
    }
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        Flexible(child: Text(value, style: theme.textTheme.bodyMedium)),
      ],
    );
  }
}

class EditRequestButton extends StatelessWidget {
  final RequestItem request;
  const EditRequestButton({super.key, required this.request});

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
              title: request.title.isNotEmpty ? request.title : "Sin título",
              description: request.infoDx ?? "Sin descripción",
              type: request.typeRequest.isNotEmpty ? request.typeRequest : "otro",
              fromDate: request.createdAt,
              toDate: request.updatedAt,
            ),
          ),
        );
      },
      child: Icon(Icons.edit, color: theme.colorScheme.onPrimary),
    );
  }
}
