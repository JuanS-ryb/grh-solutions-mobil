import 'package:flutter/material.dart';
import 'package:grhsolutions/models/user/profile-model.dart';

class MiProfileScreen extends StatelessWidget {
  final ProfileModel? profile;

  const MiProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const Center(child: Text("Perfil no disponible"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Información del Usuario",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Avatar circular
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade400,
            child: Text(
              profile!.name.isNotEmpty ? profile!.name[0].toUpperCase() : "?",
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),

          const SizedBox(height: 24),

          // ---------------- Info Personal ----------------
          _sectionTitle("Info personal"),
          _infoRow("Nombre", profile!.name),
          _infoRow("Apellido", profile!.lastname ?? ""),
          _infoRow("Fecha de nacimiento",
              profile!.dateOfBirth != null ? "${profile!.dateOfBirth!.day}/${profile!.dateOfBirth!.month}/${profile!.dateOfBirth!.year}" : "N/A"),
          _infoRow("Documento", profile!.document ?? ""),
          _infoRow("Tipo de documento", profile!.typeDocument ?? ""),
          _infoRow("RH", profile!.rh?.toString() ?? ""),
          _infoRow("Estado", profile!.status ?? ""),

          const SizedBox(height: 16),

          // ---------------- Contacto ----------------
          _sectionTitle("Contacto"),
          _infoRow("Teléfono", profile!.numberPhone ?? ""),
          _infoRow("Email", profile!.email ?? ""),
          _infoRow("Dirección", profile!.address ?? ""),

          const SizedBox(height: 16),

          // ---------------- Datos laborales ----------------
          //_sectionTitle("Datos laborales"),
          //_infoRow("Nombre de vacante", profile!. ?? ""),
          //_infoRow("Fecha de aplicación",
          //    profile!.applicationDate != null ? "${profile!.applicationDate}" : "N/A"),
        ],
      ),
    );
  }

  // helper para títulos de sección
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  // helper para mostrar key:value
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("$label: $value",
            style: const TextStyle(fontSize: 14, height: 1.3)),
      ),
    );
  }
}
