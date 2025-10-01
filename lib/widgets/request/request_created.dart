import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../services/request/request-services.dart';
import '../../models/request/request-models.dart';

class RequestCreated extends StatefulWidget {
  const RequestCreated({Key? key}) : super(key: key);

  @override
  State<RequestCreated> createState() => _RequestCreatedState();
}

class _RequestCreatedState extends State<RequestCreated> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedType;
  PlatformFile? _selectedFile;

  final List<String> tiposSolicitud = [
    "Vacaciones",
    "Maternidad",
    "Préstamos",
    "Cita médica",
    "Capacitación",
    "Permiso personal",
    "Reunión especial",
    "Otro",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Crear Solicitud",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: "Título",
                            hintText: "Nombre de la solicitud",
                          ),
                        ),
                        const SizedBox(height: 16),

                        DropdownButtonFormField<String>(
                          value: _selectedType,
                          decoration: const InputDecoration(
                            labelText: "Tipo de solicitud",
                          ),
                          items: tiposSolicitud.map((tipo) {
                            return DropdownMenuItem(
                              value: tipo,
                              child: Text(tipo),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: "Descripción (opcional)",
                            hintText: "Detalles de la solicitud",
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Archivo (opcional)
                        ElevatedButton.icon(
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles();
                            if (result != null) {
                              setState(() {
                                _selectedFile = result.files.first;
                              });
                            }
                          },
                          icon: const Icon(Icons.attach_file),
                          label: Text(
                            _selectedFile != null
                                ? _selectedFile!.name
                                : "Adjuntar archivo (opcional)",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_titleController.text.isEmpty || _selectedType == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Debe ingresar título y tipo de solicitud"),
                      ),
                    );
                    return;
                  }

                  final requestService = RequestService();

                  try {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    final RequestItem newRequest =
                        await requestService.createRequest(
                      title: _titleController.text,
                      typeRequest: _selectedType!,
                      description: _descriptionController.text,
                      file: _selectedFile, createdBy: '', status: '',
                    );

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Solicitud creada: ${newRequest.title}"),
                      ),
                    );

                    Navigator.of(context).pop(true);
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al crear solicitud: $e")),
                    );
                  }
                },
                child: const Text("Crear"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
