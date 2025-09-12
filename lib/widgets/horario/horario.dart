import 'package:flutter/material.dart';
import 'package:grhsolutions/widgets/horario/inasistencia.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Horario extends StatefulWidget {
  const Horario({super.key});

  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // datos desde la BD (aqui quemados para que aparezca algo mientras jijiji)
  final String grupo = "Grupo A"; // Grupo (desde BD wasaaaa)
  final Map<DateTime, String> horarios = {
    DateTime.utc(2026, 9, 1): "Diurno",
    DateTime.utc(2026, 9, 2): "Nocturno",
    DateTime.utc(2026, 9, 3): "Mixto",
    DateTime.utc(2026, 9, 9): "Diurno",
    DateTime.utc(2026, 9, 15): "Nocturno",
  };

  void _navegarACrearInasistencia() {
    if (_selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona un día primero'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Obtener el horario del día seleccionado
    final String? horarioSeleccionado = horarios[DateTime.utc(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
    )];

    // Navegar a la nueva pantalla
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CrearInasistencia(
          fechaSeleccionada: _selectedDay!,
          horario: horarioSeleccionado,
          grupo: grupo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendario"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Grupo (desde BD wasaaaa)
          Text(
            "Grupo: $grupo",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            locale: 'es_ES',
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return _buildDayCell(day);
              },
              todayBuilder: (context, day, focusedDay) {
                return _buildDayCell(day, isToday: true);
              },
              selectedBuilder: (context, day, focusedDay) {
                return _buildDayCell(day, isSelected: true);
              },
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _navegarACrearInasistencia,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: _selectedDay != null ? Colors.blue : Colors.grey,
              ),
              child: Text(
                _selectedDay != null 
                  ? "Generar Inasistencia" 
                  : "Selecciona un día",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Construye la celda personalizada para cada día.
  Widget _buildDayCell(DateTime day, {bool isToday = false, bool isSelected = false}) {
    final String? horario = horarios[DateTime.utc(day.year, day.month, day.day)];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue
                : isToday
                    ? Colors.blueAccent
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '${day.day}',
            style: TextStyle(
              color: isSelected || isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          horario ?? "",
          style: const TextStyle(fontSize: 10, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}