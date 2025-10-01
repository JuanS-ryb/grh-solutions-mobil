import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:grhsolutions/widgets/perfil/parts/mi_certificados.dart';
import 'package:grhsolutions/widgets/perfil/parts/mi_profile.dart';
import 'package:grhsolutions/widgets/perfil/parts/settings_section.dart';

import '../../models/user/profile-model.dart';
import '../../services/user/profile-services.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> with TickerProviderStateMixin {
  late TabController _tabController;
  final ProfileService sr = ProfileService();

  bool loadingProfile = false; // <- antes era final, ahora bool
  ProfileModel? myProfile;

  Future<void> getProfile() async {
    setState(() {
      loadingProfile = true;
    });
    try {
      final profile = await sr.getMyProfile();
      setState(() {
        myProfile = profile;
        loadingProfile = false;
      });
    } catch (e) {
      setState(() {
        loadingProfile = false;
      });
      debugPrint("Error obteniendo perfil: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
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

  // Lista de widgets que quieres renderizar según selección
  List<Widget> get options {
    if (loadingProfile) {
      return const [
        Center(child: CircularProgressIndicator()),
        Center(child: CircularProgressIndicator()),
        Center(child: CircularProgressIndicator()),
        Center(child: CircularProgressIndicator()),
      ];
    }

    if (myProfile == null) {
      return [
        const SettingsScreen(),
        const Center(child: Text("Error cargando perfil")),
        const Center(child: Text('Opción 3: Certificados', style: TextStyle(fontSize: 18))),
        const Center(child: Text('Opción 4: Hoja de vida', style: TextStyle(fontSize: 18))),
      ];
    }

    return [
      const SettingsScreen(),
      MiProfileScreen(profile: myProfile),
      MiCertificadosScreen(profile: myProfile),
      const Center(child: Text('Opción 4: Hoja de vida', style: TextStyle(fontSize: 18))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color? contrastText = theme.textTheme.labelSmall?.color;
    final Color scaffoldBackgroundColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Column(
        children: [
          // Contenedor para el TabBar con estilo personalizado
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent),
            ),
            child: ButtonsTabBar(
              controller: _tabController,
              unselectedBackgroundColor: Colors.transparent,
              labelStyle: TextStyle(
                color: contrastText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelStyle: TextStyle(
                color: contrastText,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              borderWidth: 1,
              borderColor: Colors.transparent,
              unselectedBorderColor: Colors.transparent,
              radius: 10,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.settings, size: 18, color: contrastText),
                    ],
                  ),
                ),
                const Tab(text: "MI INFORMACIÓN"),
                const Tab(text: "CERTIFICADOS"),
                const Tab(text: "HOJA DE VIDA"),
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
      ),
    );
  }
}
