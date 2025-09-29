import 'package:flutter/material.dart';
import 'package:grhsolutions/services/vacants/get-my-vacants.dart';
import 'package:grhsolutions/models/vacants/get-my-modal.dart';
import 'package:grhsolutions/widgets/vacants/buildStatusCircle.dart';
import 'package:grhsolutions/widgets/vacants/viewVacants.dart';
import '../base_scaffold.dart';
import '../../data/notifiers.dart';

class myVacant extends StatefulWidget {
  const myVacant({Key? key}) : super(key: key);

  @override
  State<myVacant> createState() => _myVacantState();
}

class _myVacantState extends State<myVacant> {
  int _selectedTab = 0;
  final List<String> tabs = ["TODAS", "APROBADOS", "PROCESOS", "RECHAZADOS"];

  late Future<GetMyVacants> _futureVacants;
  final service = GetMyVacantsService();

  @override
  void initState() {
    super.initState();
    debugPrint(loginController.value?.user?.id);
    final String? id = loginController.value?.user?.id;
    debugPrint(id);
    _futureVacants = service.getMyVacants(id!);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        title: const Text("Mis vacantes"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tabs de filtro
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

              Expanded(
                child: FutureBuilder<GetMyVacants>(
                  future: _futureVacants,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text("Error: ${snapshot.error.toString()}"));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.applications.isEmpty) {
                      return const Center(
                          child: Text("No tienes vacantes registradas"));
                    }

                    final applications = snapshot.data!.applications;

                    final filtered = applications.where((app) {
                      switch (_selectedTab) {
                        case 1:
                          return app.status.toLowerCase() == "contratado";
                        case 2:
                          return app.status.toLowerCase() == "pendiente";
                        case 3:
                          return app.status.toLowerCase() == "rechazado";
                        default:
                          return true; // TODAS
                      }
                    }).toList();

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final app = filtered[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              buildStatusCircle(app.status),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      app.vacant.tittle,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      app.vacant.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Disponible hasta: ${app.applicationDate}",
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
                                      builder: (context) =>
                                          ViewVacants(id: app.vacant.id, isMyVacant: true),
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

extension on Map<String, dynamic> {
  String? get id => null;
}
