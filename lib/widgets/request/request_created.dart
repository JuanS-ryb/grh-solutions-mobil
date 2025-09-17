import 'package:flutter/material.dart';

class RequestCreated extends StatefulWidget {
  const RequestCreated({Key? key}) : super(key: key);

  @override
  State<RequestCreated> createState() => _RequestCreatedState();
}

class _RequestCreatedState extends State<RequestCreated> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedType;
  DateTime? _fromDate;
  DateTime? _toDate;

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
                        // Campo Titulo
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
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
                          items: const [
                            DropdownMenuItem(
                              value: "prestamo",
                              child: Text("Préstamo"),
                            ),
                            DropdownMenuItem(
                              value: "reclamo",
                              child: Text("Reclamo"),
                            ),
                            DropdownMenuItem(
                              value: "otro",
                              child: Text("Otro"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildDateField("Desde:", _fromDate, (date) {
                          setState(() {
                            _fromDate = date;
                          });
                        }),
                        const SizedBox(height: 16),
                        _buildDateField("Hasta:", _toDate, (date) {
                          setState(() {
                            _toDate = date;
                          });
                        }),
                        const SizedBox(height: 16),

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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Crear"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
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
          date != null
              ? "${date.day}/${date.month}/${date.year}"
              : "dd/mm/aaaa",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: date == null ? theme.hintColor : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
