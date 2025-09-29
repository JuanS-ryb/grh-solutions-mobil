import 'package:flutter/material.dart';
import '../../services/request/history-services.dart';
import '../../models/request/history-model.dart';

class HistorialView extends StatefulWidget {
  final String requestId; // id de la solicitud a consultar
  const HistorialView({super.key, required this.requestId});

  @override
  State<HistorialView> createState() => _HistorialViewState();
}

class _HistorialViewState extends State<HistorialView> {
  late Future<List<HistoryItem>> futureHistory;
  final HistoryService _historyService = HistoryService();

  @override
  void initState() {
    super.initState();
    futureHistory = _historyService.getHistory(widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<HistoryItem>>(
      future: futureHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error al cargar historial: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No hay historial"));
        }

        final history = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.history, color: theme.colorScheme.primary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.createdAt.toLocal().toString(), // puedes formatear con DateFormat
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.person, size: 16),
                              const SizedBox(width: 4),
                              Text("${item.profile.name} ${item.profile.lastname}"),
                              const SizedBox(width: 12),
                              const Icon(Icons.info_outline, size: 16),
                              const SizedBox(width: 4),
                              Expanded(child: Text(item.description)),
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
      },
    );
  }
}
