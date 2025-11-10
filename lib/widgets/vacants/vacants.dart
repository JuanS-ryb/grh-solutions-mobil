import 'package:flutter/material.dart';
import 'package:grhsolutions/widgets/vacants/myVacanst.dart';
import 'package:grhsolutions/widgets/vacants/openVacants.dart';

class Vacant extends StatefulWidget {
  const Vacant({Key? key}) : super(key: key);

  @override
  State<Vacant> createState() => _VacantState();
}

class _VacantState extends State<Vacant> {
  final TextEditingController _controller = TextEditingController();
  bool _isRemote = false;
  String? _errorText;

  final RegExp _validPattern = RegExp(r'^[a-zA-Z0-9áéíóúÁÉÍÓÚüÜñÑ\s.,-]+$');

  void _myVacants() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const myVacant()),
    );
  }

  void _searchVacants() {
    final text = _controller.text.trim();

    setState(() {
      _errorText = null; // limpia error anterior
    });

    if (text.isEmpty) {
      setState(() {
        _errorText = "Por favor ingresa un término de búsqueda.";
      });
      return;
    }

    if (!_validPattern.hasMatch(text)) {
      setState(() {
        _errorText = "El término de búsqueda contiene caracteres no válidos.";
      });
      return;
    }

    // Si todo está bien, navega
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OpenVacants(
          name: text,
          isRemote: _isRemote,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(vertical: 50),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Busca lo que te interesa!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Input de búsqueda
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Ej: Programador móvil',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _controller.clear();
                                    _errorText = null; // limpia error al borrar
                                  });
                                },
                              ),
                              filled: true,
                              errorText: _errorText,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          // Switch remoto
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Switch(
                                value: _isRemote,
                                onChanged: (value) {
                                  setState(() {
                                    _isRemote = value;
                                  });
                                },
                                activeColor: Colors.purple,
                              ),
                              const Text(
                                'Buscar remoto?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Botón buscar
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _searchVacants,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(Icons.search, color: Colors.white),
                              label: const Text(
                                'BUSCAR',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Botón ver postulaciones
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _myVacants,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 136, 246),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Ver tus postulaciones',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
