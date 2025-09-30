import 'package:flutter/material.dart';

class MiProfileScreen extends StatefulWidget {
  const MiProfileScreen({super.key});

  @override
  State<MiProfileScreen> createState() => _MiProfileScreenState();
}

class _MiProfileScreenState extends State<MiProfileScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Información del Usuario",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 60,
                  child: Text("M", style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(height: 20),

                // Info personal
                const _SectionTitle("Info personal"),
                const _InfoRow("Nombre", "MIGUELANDRES"),
                const _InfoRow("Apellido", "BALLESTEROSFLOREZ"),
                const _InfoRow("Fecha de nacimiento", "8/7/2005"),
                const _InfoRow("Documento", "109488827"),
                const _InfoRow("Tipo de documento", "Cédula de ciudadanía"),
                const _InfoRow("RH", "false"),
                const _InfoRow("Estado", "enabled"),
                const SizedBox(height: 20),

                // Contacto
                const _SectionTitle("Contacto"),
                const _InfoRow("Teléfono", ""),
                const _InfoRow("Teléfono fijo", ""),
                const _InfoRow("Email", "miguelballesta05@gmail.com"),
                const _InfoRow("Dirección", ""),
                const SizedBox(height: 20),

                // Datos laborales
                const _SectionTitle("Datos laborales"),
                const _InfoRow("Nombre de vacante", ""),
                const _InfoRow("Fecha de aplicación", "Invalid Date"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
