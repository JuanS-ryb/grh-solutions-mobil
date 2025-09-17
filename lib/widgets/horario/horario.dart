import 'package:flutter/material.dart';
import 'package:grhsolutions/services/horarios/horario-services.dart';
import 'package:grhsolutions/widgets/horario/inasistencia.dart';
import 'package:table_calendar/table_calendar.dart';

class Horario extends StatefulWidget {
  const Horario({super.key});

  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final HorarioService horarioService = HorarioService();

  String grupo = '';
  Map<DateTime, String> horarios = {};
  String horarioGeneral = ''; // Para almacenar el tipo de horario general

  @override
  void initState() {
    super.initState();
    cargarHorarios();
  }

  Future<void> cargarHorarios() async {
    try {
      final List res = await horarioService.getHorarios();

      final Map<DateTime, String> mapaHorarios = {};
      String nombreGrupo = '';

      print('=== DEBUG: Total horarios recibidos: ${res.length} ===');

      for (final h in res) {
        print('--- Procesando horario ---');
        print('ID: ${h.id}');
        print('startDate (String): "${h.startDate}"');
        print('scheduleType: ${h.scheduleType?.name}');
        print('group: ${h.group?.name}');

        // startDate es String, verificar que no esté vacío
        if (h.startDate.isEmpty) {
          print('❌ Saltando: startDate está vacío');
          continue;
        }

        // Parsear fecha desde String
        DateTime fechaInicio;
        try {
          // h.startDate ya es String del JSON, parseamos directamente
          fechaInicio = DateTime.parse(h.startDate).toLocal();
          print('✅ Fecha parseada: $fechaInicio');
        } catch (err) {
          print('❌ Error parseando fecha "${h.startDate}": $err');
          continue;
        }

        // Crear clave normalizada (solo fecha, sin hora)
        final key = DateTime(fechaInicio.year, fechaInicio.month, fechaInicio.day);
        print('🔑 Clave generada: $key');

        // Obtener tipo de horario
        String tipo = '';
        if (h.scheduleType?.name != null && h.scheduleType!.name.isNotEmpty) {
          tipo = h.scheduleType!.name;
          // Guardar como horario general (se sobrescribirá con el último, pero generalmente será el mismo)
          horarioGeneral = tipo;
        }
        print('📅 Tipo horario: "$tipo"');

        mapaHorarios[key] = tipo;

        // Obtener nombre del grupo  
        if (h.group?.name != null && h.group!.name.isNotEmpty) {
          nombreGrupo = h.group!.name;
          print('👥 Grupo: $nombreGrupo');
        }
      }

      print('=== RESULTADO FINAL ===');
      print('Horarios mapeados: ${mapaHorarios.length}');
      mapaHorarios.forEach((fecha, tipo) {
        print('$fecha -> "$tipo"');
      });
      print('Grupo: "$nombreGrupo"');

      if (mounted) {
        setState(() {
          horarios = mapaHorarios;
          grupo = nombreGrupo;
        });
        print('✅ Estado actualizado');
        print('🔄 Horario general para mostrar: "$horarioGeneral"');
      }
    } catch (e, st) {
      print('❌ ERROR GENERAL: $e');
      print('Stack trace: $st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al cargar horarios: $e')));
      }
    }
  }

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

    // Usar la misma normalización que en cargarHorarios
    final claveSeleccionada = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
    );

    final horarioSeleccionado = horarios[claveSeleccionada];
    print('Día seleccionado: $claveSeleccionada');
    print('Horario encontrado: "$horarioSeleccionado"');

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
      appBar: AppBar(title: const Text("Calendario")),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Text(
            "Grupo: $grupo",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            _selectedDay != null
                ? (horarios[DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)] ??
                    horarioGeneral ??
                    "Sin horario")
                : "Selecciona un día para ver horario",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                  color: Colors.blueAccent, shape: BoxShape.circle),
              selectedDecoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
            rowHeight: 80, // Aumenté un poco más el espacio
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              
              // Debug para verificar selección
              final clave = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
              print('Día seleccionado: $clave');
              print('Horario: "${horarios[clave]}"');
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) => _buildDayCell(day),
              todayBuilder: (context, day, focusedDay) =>
                  _buildDayCell(day, isToday: true),
              selectedBuilder: (context, day, focusedDay) =>
                  _buildDayCell(day, isSelected: true),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _navegarACrearInasistencia,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor:
                      _selectedDay != null ? Colors.blue : Colors.grey),
              child: Text(
                  _selectedDay != null
                      ? "Generar Inasistencia"
                      : "Selecciona un día",
                  style: const TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDayCell(DateTime day,
      {bool isToday = false, bool isSelected = false}) {
    // Usar la misma normalización
    final clave = DateTime(day.year, day.month, day.day);
    
    // Primero buscar horario específico para este día, si no existe usar el horario general
    String? horario = horarios[clave];
    if (horario == null || horario.isEmpty) {
      horario = horarioGeneral; // Mostrar horario general en todos los días
    }
    
    return Container(
      margin: const EdgeInsets.all(2),
      child: Column(
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
            child: Text('${day.day}',
                style: TextStyle(
                    color: isSelected || isToday ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          const SizedBox(height: 2),
          Container(
            height: 16, // Altura fija para el texto del horario
            child: Text(
              horario ?? "",
              style: TextStyle(
                fontSize: 9, 
                color: (horario != null && horario.isNotEmpty) ? Colors.blue : Colors.grey,
                fontWeight: (horario != null && horario.isNotEmpty) ? FontWeight.w500 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}