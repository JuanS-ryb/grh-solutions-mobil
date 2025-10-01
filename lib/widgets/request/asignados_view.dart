import 'package:flutter/material.dart';
import '../../services/request/involved-service.dart';
import '../../models/request/involved-model.dart';

class AsignadosView extends StatefulWidget {
  final String requestId;
  const AsignadosView({super.key, required this.requestId});

  @override
  State<AsignadosView> createState() => _AsignadosViewState();
}

class _AsignadosViewState extends State<AsignadosView> {
  late Future<List<InvolvedItem>> futureInvolved;
  final InvolvedService _involvedService = InvolvedService();

  @override
  void initState() {
    super.initState();
    if (widget.requestId.isNotEmpty) {
      futureInvolved =
          _involvedService.getInvolvedByRequestId(widget.requestId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.requestId.isEmpty) {
      return const Center(
        child: Text("No se proporcionó ID de solicitud"),
      );
    }

    return FutureBuilder<List<InvolvedItem>>(
      future: futureInvolved,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error al cargar asignados: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No hay asignados"));
        }

        final involucrados = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: involucrados.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = involucrados[index];
            final role = item.role; // "peticionante", "editor", etc.
            final profileName = item.profileName;
            
            return ListTile(
              leading: Icon(
                Icons.person_outline,
                color: theme.colorScheme.primary,
                size: 32,
              ),
              title: Text(
                profileName,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text("Rol: $role"),
            );
          },
        );
      },
    );
  }
}
