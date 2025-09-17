import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrearInasistencia extends StatefulWidget {
  final DateTime fechaSeleccionada;
  final String? horario;
  final String grupo;

  const CrearInasistencia({
    super.key,
    required this.fechaSeleccionada,
    this.horario,
    required this.grupo,
  });

  @override
  State<CrearInasistencia> createState() => _CrearInasistenciaState();
}

class _CrearInasistenciaState extends State<CrearInasistencia> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  void _crearInasistencia() {
    if (_tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El título es obligatorio'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    debugPrint('Creando inasistencia:');
    debugPrint('Fecha: ${widget.fechaSeleccionada}');
    debugPrint('Horario: ${widget.horario}');
    debugPrint('Grupo: ${widget.grupo}');
    debugPrint('Título: ${_tituloController.text}');
    debugPrint('Descripción: ${_descripcionController.text}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Inasistencia creada exitosamente'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final String fechaFormateada = DateFormat('dd/MM/yyyy').format(widget.fechaSeleccionada);
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Crear Inasistencia'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _crearInasistencia,
            child: const Text(
              'Crear',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fecha seleccionada: $fechaFormateada',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Grupo: ${widget.grupo}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  if (widget.horario != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Horario: ${widget.horario}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título:',
                hintText: 'Nombre de la solicitud',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _descripcionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Descripción:',
                hintText: 'Detalles de la solicitud',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: () {
                  debugPrint('Seleccionar imagen');
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _crearInasistencia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Crear Inasistencia',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}