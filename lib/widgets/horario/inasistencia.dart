import 'package:flutter/material.dart';
import 'package:grhsolutions/services/horarios/request-services.dart';
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
  final RequestService _requestService = RequestService(); // 👈 tu servicio
  bool _enviando = false;

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _crearInasistencia() async {
    if (_tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El título es obligatorio'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _enviando = true);
    try {
      final nuevaInasistencia = await _requestService.createRequest(
        title: _tituloController.text.trim(),
        typeRequest: "inasistencia",
        description: _descripcionController.text.trim(),
        createdBy: "",
        status: "PENDIENTE",
        files: null,
        createdAt: widget.fechaSeleccionada, // DateTime
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inasistencia creada exitosamente'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al crear inasistencia: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String fechaFormateada =
        DateFormat('dd/MM/yyyy').format(widget.fechaSeleccionada);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Crear Inasistencia'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _enviando ? null : _crearInasistencia,
            child: _enviando
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
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
                color: const Color(0xFF0095FF),
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
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Grupo: ${widget.grupo}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  if (widget.horario != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Horario: ${widget.horario}',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Campo título
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

            // Campo descripción
            TextField(
              controller: _descripcionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Descripción:',
                hintText:
                    'Detalles de la solicitud o motivo de la inasistencia',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 24),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _enviando ? null : _crearInasistencia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _enviando
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : const Text(
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
