import 'package:flutter/material.dart';
import 'request_created.dart';
import 'request_view.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class RequestItem {
  final String radicado;
  final String estado;
  final Color color;
  final String titulo;
  final String desde;
  final String hasta;

  const RequestItem({
    required this.radicado,
    required this.estado,
    required this.color,
    required this.titulo,
    required this.desde,
    required this.hasta,
  });
}

class _RequestState extends State<Request> {
  final List<RequestItem> _requests = [
    RequestItem(
      radicado: "SOL-20250313",
      estado: "Aprobada",
      color: Colors.greenAccent, // se mantiene (es estado)
      titulo: "Solicitud urgente..",
      desde: "09/10/24 12:12 AM",
      hasta: "3/31/23 2:52 PM",
    ),
    RequestItem(
      radicado: "SOL-20250313",
      estado: "Rechazada",
      color: Colors.redAccent,
      titulo: "Revisión final..",
      desde: "09/10/24 5:14 PM",
      hasta: "3/31/23 2:52 PM",
    ),
    RequestItem(
      radicado: "SOL-20250313",
      estado: "En proceso",
      color: Colors.grey,
      titulo: "Documentos completos..",
      desde: "09/10/24 10:45 AM",
      hasta: "3/31/23 2:52 PM",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          children: [
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

            Expanded(
              child: ListView.builder(
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  final req = _requests[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RequestView(),
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
                            // fila superior: radicado + estado (chip)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Radicado: ${req.radicado}",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: req.color,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Text(
                                    req.estado,
                                    style: theme.textTheme.bodyMedium?.copyWith(
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
                            // contenido con título + fechas (izq/derecha)
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        req.titulo,
                                        style:
                                            theme.textTheme.bodyMedium?.copyWith(
                                          color: theme
                                              .textTheme.bodyMedium?.color,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        req.desde,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Desde",
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: theme.hintColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      req.hasta,
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
