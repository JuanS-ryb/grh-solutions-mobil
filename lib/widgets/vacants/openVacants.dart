import 'package:flutter/material.dart';
import 'package:grhsolutions/widgets/vacants/viewVacants.dart';
import 'package:grhsolutions/services/vacants/get-vacants.dart';
import 'package:grhsolutions/models/vacants/get-model.dart';
import '../base_scaffold.dart';

class OpenVacants extends StatefulWidget {
  final String name;
  final bool isRemote;

  const OpenVacants({Key? key, required this.name, required this.isRemote})
      : super(key: key);

  @override
  State<OpenVacants> createState() => _OpenVacantsState();
}

class _OpenVacantsState extends State<OpenVacants> {
  final GetVacantsService _service = GetVacantsService();

  List<Vacants> vacants = [];
  bool isLoading = true;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    _loadVacants();
  }

  Future<void> _loadVacants() async {
    try {
      final response = await _service.getVacants();
      setState(() {
        vacants = response.vacants;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMsg != null) {
      return BaseScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Vacantes"),
        ),
        body: Center(child: Text("Error: $errorMsg")),
      );
    }

    if (vacants.isEmpty) {
      return BaseScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Vacantes"),
        ),
        body: const Center(child: Text("No hay vacantes disponibles")),
      );
    }

    return BaseScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        title: Text("Vacantes: ${widget.name}"),
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
                          item.tittle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Disponible desde: ${item.createdAt}",
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
                          builder: (context) => ViewVacants(id: item.id),
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
