import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Horario extends StatefulWidget {
  const Horario({super.key});

  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  DateTime currentDate = DateTime.now(); // Mes actual
  int? selectedDay;

  @override
  Widget build(BuildContext context) {
    // Nombre del mes actual
    String monthName = DateFormat('MMMM yyyy', 'es_ES').format(currentDate);

    // Lista de meses (para el menú horizontal)
    List<DateTime> months = List.generate(
      12,
      (i) => DateTime(currentDate.year, i + 1),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendario"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // Título con el mes actual
          Text(
            monthName[0].toUpperCase() + monthName.substring(1),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          // Menú horizontal de meses
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: months.length,
              itemBuilder: (context, index) {
                String name = DateFormat('MMM', 'es_ES').format(months[index]);
                bool isSelected = months[index].month == currentDate.month;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentDate = months[index];
                      selectedDay = null; // Reiniciar selección
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Encabezado días de la semana
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("D"),
              Text("L"),
              Text("M"),
              Text("M"),
              Text("J"),
              Text("V"),
              Text("S"),
            ],
          ),

          const SizedBox(height: 8),

          // Calendario (días del mes actual)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: DateUtils.getDaysInMonth(
                  currentDate.year, currentDate.month),
              itemBuilder: (context, index) {
                final day = index + 1;
                final isSelected = selectedDay == day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = day;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$day",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Botón
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Por ahora no hace nada
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Generar Inasistencia"),
            ),
          )
        ],
      ),
    );
  }
}
