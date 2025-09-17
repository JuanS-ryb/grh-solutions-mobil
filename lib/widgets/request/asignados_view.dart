import 'package:flutter/material.dart';

class AsignadosView extends StatefulWidget {
  const AsignadosView({super.key});

  @override
  State<AsignadosView> createState() => _AsignadosViewState();
}

class _AsignadosViewState extends State<AsignadosView> {
  final List<Map<String, String>> asignados = [
    {"nombre": "Miguel Angel", "rol": "Editor"},
    {"nombre": "Camilo Murillo", "rol": "Lector"},
  ];

  final List<String> rolesDisponibles = ["Editor", "Lector", "Revisor", "Admin"];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: asignados.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final usuario = asignados[index];
        return ListTile(
          leading: Icon(
            Icons.person_outline,
            color: Theme.of(context).primaryColor,
            size: 32,
          ),
          title: Text(
            usuario["nombre"]!,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: DropdownButton<String>(
            value: usuario["rol"],
            underline: const SizedBox(),
            items: rolesDisponibles.map((rol) {
              return DropdownMenuItem(
                value: rol,
                child: Text(rol),
              );
            }).toList(),
            onChanged: (nuevoRol) {
              setState(() {
                asignados[index]["rol"] = nuevoRol!;
              });
            },
          ),
        );
      },
    );
  }
}
