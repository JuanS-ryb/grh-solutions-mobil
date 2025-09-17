import 'package:flutter/material.dart';
import 'package:grhsolutions/widgets/vacants/viewVacants.dart';
import '../base_scaffold.dart';

class OpenVacants extends StatefulWidget {
  final String name;
  final bool isRemote;

  const OpenVacants({Key? key, required this.name , required this.isRemote}) : super(key: key);

  @override
  State<OpenVacants> createState() => _OpenVacantsState();
}

class _OpenVacantsState extends State<OpenVacants> {
  final List<Map<String, dynamic>> vacants = [
    {
      "title": "Se necesita aceador.",
      "desc": "Se necesita un aceador que coopere p...",
      "date": "15/01/2025",
      "status": "aprobado",
      "id": "1"
    },
    {
      "title": "Se necesita programador.",
      "desc": "Se necesita un programador que coopere p...",
      "date": "15/01/2025",
      "status": "proceso",
      "id": "2"
    },
    {
      "title": "Se necesita ingeniero en sistemas.",
      "desc": "Se necesita un ingeniero con experiencia...",
      "date": "15/01/2025",
      "status": "aprobado",
      "id": "3"
    },
    {
      "title": "Se necesita diseñador.",
      "desc": "Se necesita un diseñador que coopere p...",
      "date": "15/01/2025",
      "status": "rechazado",
      "id": "4"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        title: Text(
          "Vacantes: " + widget.name, 
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: vacants.length,
          itemBuilder: (context, index) {
            final item = vacants[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item["desc"]!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Disponible hasta: ${item["date"]}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Botón VER
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewVacants(
                            id: item["id"] ?? "1",
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "VER",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
