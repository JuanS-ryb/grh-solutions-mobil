import 'package:flutter/material.dart';
import 'package:grhsolutions/widgets/vacants/buildStatusCircle.dart';
import 'package:grhsolutions/widgets/vacants/viewVacants.dart';
import '../base_scaffold.dart';

class myVacant extends StatefulWidget {
  const myVacant({Key? key}) : super(key: key);

  @override
  State<myVacant> createState() => _myVacantState();
}

class _myVacantState extends State<myVacant> {
  int _selectedTab = 0;

  final List<String> tabs = ["TODAS", "APROBADOS", "PROCESOS", "RECHAZADOS"];

  final List<Map<String, dynamic>> vacants = [
    {
      "title": "Se necesita programador.",
      "desc": "Se necesita un programador que coopere p...",
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
      "title": "Se necesita acceador.",
      "desc": "Se necesita un acceador que coopere p...",
      "date": "15/01/2025",
      "status": "rechazado",
      "id": "3"
    },
    {
      "title": "Se necesita asistente.",
      "desc": "Se necesita un asistente que coopere p...",
      "date": "15/01/2025",
      "status": "aprobado",
      "id": "4"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        title: const Text("Mis vacantes", style: TextStyle()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(tabs.length, (index) {
                    final isSelected = _selectedTab == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // Lista de vacantes
              Expanded(
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
                          // Status
                          buildStatusCircle(item["status"]!),
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
                                    id: item["id"] ??
                                        "1", // le pasas un string seguro, nunca null
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
            ],
          ),
        ),
      ),
    );
  }
}
