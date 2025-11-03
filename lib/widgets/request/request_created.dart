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
  List<PlatformFile> _selectedFiles = []; // ✅ ahora puede tener varios archivos

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
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: "Descripción (opcional)",
                            hintText: "Detalles de la solicitud",
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 📎 Selección de archivos PDF
                        ElevatedButton.icon(
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              allowMultiple: true, // ✅ Permitir varios
                              type: FileType.custom,
                              allowedExtensions: ['pdf'], // ✅ Solo PDF
                            );

                            if (result != null && result.files.isNotEmpty) {
                              final invalidFiles = result.files.where(
                                (f) => f.extension?.toLowerCase() != 'pdf',
                              );

                              if (invalidFiles.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Solo se permiten archivos PDF.",
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (result.files.length > 2) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Solo puedes subir hasta 2 archivos PDF.",
                                    ),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _selectedFiles = result.files;
                              });
                            }
                          },
                          icon: const Icon(Icons.attach_file),
                          label: Text(
                            _selectedFiles.isNotEmpty
                                ? "${_selectedFiles.length} archivo(s) seleccionado(s)"
                                : "Adjuntar archivos PDF (máx. 2)",
                          ),
                        ),

                        if (_selectedFiles.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: _selectedFiles.map((file) {
                              return Chip(
                                label: Text(file.name),
                                onDeleted: () {
                                  setState(() {
                                    _selectedFiles.remove(file);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 📤 Botón de envío
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_titleController.text.isEmpty || _selectedType == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Debe ingresar título y tipo de solicitud."),
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
                      files: _selectedFiles, // ✅ ahora enviamos lista de PDFs
                      createdBy: '', // TODO: reemplazar con usuario actual
                      status: 'pendiente',
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
