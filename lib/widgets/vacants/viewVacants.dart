import 'package:flutter/material.dart';
import 'package:grhsolutions/services/vacants/relation-vacants.dart';
import '../base_scaffold.dart';
import 'package:grhsolutions/models/vacants/get-model.dart';
import 'package:grhsolutions/services/vacants/get-vacant-id.dart';

class ViewVacants extends StatefulWidget {
  final String id;
  final bool isMyVacant;

  const ViewVacants({
    Key? key,
    required this.id,
    this.isMyVacant = false,
  }) : super(key: key);

  @override
  State<ViewVacants> createState() => _ViewVacantsState();
}

class _ViewVacantsState extends State<ViewVacants> {
  Vacants? selectedVacant;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadVacant();
  }

  Future<void> _loadVacant() async {
    final service = GetVacantIdService();
    try {
      final vacant = await service.getVacantById(widget.id);
      setState(() {
        selectedVacant = vacant;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return BaseScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text("Detalle de vacante"),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null || selectedVacant == null) {
      return BaseScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Detalle de vacante"),
        ),
        body: Center(child: Text(errorMessage ?? "Vacante no encontrada")),
      );
    }

    return BaseScaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        title: Text(
          selectedVacant!.tittle,
          style: const TextStyle(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  selectedVacant!.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.star_border),
                    title: const Text(
                      "Salario",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    subtitle: Text(selectedVacant!.salary),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text(
                      "Fecha de publicación",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    subtitle: Text(selectedVacant!.createdAt),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: const Text(
                      "Modalidad",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    subtitle: Text(selectedVacant!.typeModality),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (!widget.isMyVacant)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final service = RelarionsVacanstService();
                      final result = await service.createPostulate(
                        selectedVacant!.id,
                        "pendiente",
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text("Postulación enviada ✅ ID: ${result.id}")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e")),
                      );
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.white, size: 18),
                  label: const Text(
                    "APLICAR",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
