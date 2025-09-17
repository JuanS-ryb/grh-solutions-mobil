import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/request-services.dart';
import '../../models/request-models.dart';
import 'request_created.dart';
import 'request_view.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  late Future<List<RequestItem>> futureRequests;
  final RequestService _requestService = RequestService(); // Ya no se pasa token

  @override
  void initState() {
    super.initState();
    futureRequests = _requestService.getRequests();
  }

  // 🔹 Función para formatear fechas legibles
  String formatDate(DateTime date) {
    return DateFormat("dd MMM yyyy, hh:mm a").format(date);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          children: [
            // --- encabezado ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Solicitudes",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.filter_alt_outlined,
                      color: theme.iconTheme.color),
                )
              ],
            ),
            const SizedBox(height: 8),

            // --- listado dinámico ---
            Expanded(
              child: FutureBuilder<List<RequestItem>>(
                future: futureRequests,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No hay solicitudes"));
                  }

                  final requests = snapshot.data!;

                  return ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final req = requests[index];

                      // Definir color según estado
                      Color color;
                      switch (req.status.toLowerCase()) {
                        case "aprobada":
                          color = Colors.greenAccent;
                          break;
                        case "rechazada":
                          color = Colors.redAccent;
                          break;
                        default:
                          color = Colors.grey;
                      }

                      return InkWell(
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RequestView(request: req),
    ),
  );
},

                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: theme.cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // fila superior: id + estado (chip)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Radicado: ${req.id}",
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Text(
                                        req.status,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Divider(
                                  height: 1,
                                  color: theme.dividerColor,
                                ),
                                const SizedBox(height: 10),
                                // contenido con título + fechas
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            req.title,
                                            style: theme
                                                .textTheme.bodyMedium
                                                ?.copyWith(
                                              color: theme.textTheme.bodyMedium
                                                  ?.color,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            formatDate(req.createdAt),
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Hasta",
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: theme.hintColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          formatDate(req.updatedAt),
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // --- Botón inferior ---
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestCreated(),
                      ),
                    );
                  },
                  child: Text(
                    "Crear Solicitud",
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
