import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> with TickerProviderStateMixin {
  late TabController _tabController;

  // Lista de widgets que quieres renderizar según selección
  final List<Widget> options = const [
    Center(child: Text('Opción 1: Configuración', style: TextStyle(fontSize: 18))),
    Center(child: Text('Opción 2: Mi información', style: TextStyle(fontSize: 18))),
    Center(child: Text('Opción 3: Certificados', style: TextStyle(fontSize: 18))),
    Center(child: Text('Opción 4: Hoja de vida', style: TextStyle(fontSize: 18))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1, // Inicia en "Mi información" (index 1)
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Contenedor para el TabBar con estilo personalizado
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: ButtonsTabBar(
            controller: _tabController,
            backgroundColor: Colors.blue,
            unselectedBackgroundColor: Colors.transparent,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            borderWidth: 1,
            borderColor: Colors.transparent,
            unselectedBorderColor: Colors.transparent,
            radius: 8,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            tabs: const [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.settings, size: 18),
                    SizedBox(width: 4),
                    Text("Config"),
                  ],
                ),
              ),
              Tab(text: "MI INFORMACIÓN"),
              Tab(text: "CERTIFICADOS"),
              Tab(text: "HOJA DE VIDA"),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: options,
          ),
        ),
      ],
    );
  }
}