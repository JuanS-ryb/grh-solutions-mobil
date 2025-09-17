import 'package:flutter/material.dart';

class RequestEdit extends StatefulWidget {
  final String title;
  final String description;
  final String type;
  final DateTime fromDate;
  final DateTime toDate;

  const RequestEdit({
    Key? key,
    required this.title,
    required this.description,
    required this.type,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);

  @override
  State<RequestEdit> createState() => _RequestEditState();
}

class _RequestEditState extends State<RequestEdit> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String? _selectedType;
  late DateTime? _fromDate;
  late DateTime? _toDate;

  final List<String> _typeOptions = ["prestamo", "reclamo", "otro"];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    // Si el valor recibido no está en las opciones, lo dejamos en null para no romper el dropdown
    _selectedType = _typeOptions.contains(widget.type) ? widget.type : null;
    _fromDate = widget.fromDate;
    _toDate = widget.toDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
          "Editar Solicitud",
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
                        // Campo Titulo
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: "Titulo:",
                            hintText: "Nombre de la solicitud",
                          ),
                        ),
                        const Divider(),

                        // Campo Tipo
                        DropdownButtonFormField<String>(
                          value: _selectedType,
                          decoration: const InputDecoration(
                            labelText: "Tipo:",
                          ),
                          items: _typeOptions
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e[0].toUpperCase() + e.substring(1),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value;
                            });
                          },
                          // Si el valor no existe, muestra un hint
                          hint: widget.type.isNotEmpty
                              ? Text(widget.type)
                              : const Text("Selecciona un tipo"),
                        ),
                        const SizedBox(height: 16),

                        // Desde
                        _buildDateField("Desde:", _fromDate, (date) {
                          setState(() {
                            _fromDate = date;
                          });
                        }),
                        const SizedBox(height: 16),

                        // Hasta
                        _buildDateField("Hasta:", _toDate, (date) {
                          setState(() {
                            _toDate = date;
                          });
                        }),
                        const SizedBox(height: 16),

                        // Descripción
                        TextField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: "Descripcion:",
                            hintText: "Detalles de la solicitud",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Botón Aplicar (solo regresa a la vista)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Aplicar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método de campos de fecha
  Widget _buildDateField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
        ),
        child: Text(
          date != null ? "${date.day}/${date.month}/${date.year}" : "dd/mm/aaaa",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: date == null ? theme.hintColor : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
