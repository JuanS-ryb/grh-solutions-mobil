import 'package:flutter/material.dart';
import '../../services/request/involved-service.dart';
import '../../models/request/involved-model.dart';

class SeguimientosView extends StatefulWidget {
  final String requestId; // ID de la solicitud a consultar
  const SeguimientosView({super.key, required this.requestId});

  @override
  State<SeguimientosView> createState() => _SeguimientosViewState();
}

class _SeguimientosViewState extends State<SeguimientosView> {
  late Future<List<InvolvedItem>> futureInvolved;
  final InvolvedService _involvedService = InvolvedService();

  @override
  void initState() {
    super.initState();

    if (widget.requestId.isEmpty) {
      futureInvolved = Future.value([]);
    } else {
      futureInvolved = _involvedService.getInvolvedByRequestId(widget.requestId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<InvolvedItem>>(
      future: futureInvolved,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Error al cargar seguimientos: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No hay seguimientos"));
        }

        final involved = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: involved.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = involved[index];

            final assignedByName = item.assignedByName ?? "Desconocido";
            final profileName = item.profileName;

            return ListTile(
              leading: Icon(Icons.description_outlined,
                  color: theme.colorScheme.primary, size: 32),
              title: Text(
                profileName,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: Text("Involucrado por: $assignedByName"),
            );
          },
        );
      },
    );
  }
}
