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
    return Scaffold(
      // AppBar con botón atrás
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // vuelve a request.dart
          },
        ),
        title: const Text(
          "Crear Solicitud",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tarjeta principal
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
                            border: InputBorder.none,
                          ),
                        ),
                        const Divider(),

                        // Campo Tipo (Dropdown)
                        DropdownButtonFormField<String>(
                          value: _selectedType,
                          decoration: const InputDecoration(
                            labelText: "Tipo:",
                            border: InputBorder.none,
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
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Botón Crear
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // vuelve a request.dart
                },
                child: const Text(
                  "Crear",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para campos de fecha
  Widget _buildDateField(
      String label, DateTime? date, Function(DateTime) onDateSelected) {
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
          border: InputBorder.none,
        ),
        child: Text(
          date != null ? "${date.day}/${date.month}/${date.year}" : "dd/mm/aaaa",
          style: TextStyle(color: date == null ? Colors.grey : Colors.black),
        ),
      ),
    );
  }
}
