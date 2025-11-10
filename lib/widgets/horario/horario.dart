import 'package:flutter/material.dart';
import 'package:grhsolutions/services/horarios/horario-services.dart';
import 'package:grhsolutions/services/request/request-services.dart';
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
  final RequestService requestService = RequestService();

  String grupo = '';
  Map<DateTime, String> horarios = {};
  Map<DateTime, bool> inasistencias = {};
  String horarioGeneral = '';

  @override
  void initState() {
    super.initState();
    cargarHorariosYRequests();
  }

  Future<void> cargarHorariosYRequests() async {
    try {
      final List res = await horarioService.getHorarios();

      final Map<DateTime, String> mapaHorarios = {};
      String nombreGrupo = '';

      for (final h in res) {
        if (h.startDate == null || h.startDate.isEmpty) continue;

        try {
          final fechaInicio = DateTime.parse(h.startDate).toLocal();
          final key =
              DateTime(fechaInicio.year, fechaInicio.month, fechaInicio.day);

          String tipo = h.scheduleType?.name ?? '';
          if (tipo.isNotEmpty) horarioGeneral = tipo;

          mapaHorarios[key] = tipo;

          if (h.group?.name != null && h.group!.name.isNotEmpty) {
            nombreGrupo = h.group!.name;
          }
        } catch (e) {
          print('❌ Error al convertir fecha: $e');
          continue;
        }
      }
      final requests = await requestService.getRequests();
      final Map<DateTime, bool> mapaInasistencias = {};

      for (final req in requests) {
        if ((req.typeRequest ?? '').toLowerCase().contains('inasistencia')) {
          final fechaKey = DateTime(
            req.createdAt.toLocal().year,
            req.createdAt.toLocal().month,
            req.createdAt.toLocal().day,
          );

          // Guardar la fecha en el mapa
          mapaInasistencias[fechaKey] = true;
        }
      }

      if (mounted) {
        setState(() {
          inasistencias = mapaInasistencias;
        });
      }

    } catch (e, stack) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: $e')),
        );
      }
    }
  }

  Future<void> _navegarACrearInasistencia() async {
    if (_selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona un día primero'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final claveSeleccionada =
        DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);

    final horarioSeleccionado = horarios[claveSeleccionada];

    // Actualizar inasistencias antes de navegar
    setState(() {
      inasistencias[claveSeleccionada] = true;
    });

    await Navigator.push(
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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Calendario"),
        backgroundColor: theme.primaryColor,
      ),
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
                ? (horarios[DateTime(_selectedDay!.year, _selectedDay!.month,
                        _selectedDay!.day)] ??
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
            rowHeight: 80,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
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
    final clave = DateTime(day.year, day.month, day.day);
    final bool tieneInasistencia = inasistencias.containsKey(clave);
    final bool esHoy = isSameDay(day, DateTime.now());

    String? horario = horarios[clave] ?? horarioGeneral;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Fondo para inasistencia (rojo) excepto hoy
        if (tieneInasistencia && !esHoy)
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),

        // Fondo para hoy o seleccionado (si no tiene inasistencia o es hoy)
        if (!tieneInasistencia || esHoy)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blue
                  : isToday
                      ? Colors.blueAccent
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),

        // Número del día
        Text(
          '${day.day}',
          style: TextStyle(
            color: (tieneInasistencia && !esHoy) || isSelected || isToday
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        // Horario debajo del número
        Positioned(
          bottom: -2,
          child: SizedBox(
            width: 40,
            child: Text(
              horario ?? "",
              style: TextStyle(
                fontSize: 9,
                color: (horario != null && horario.isNotEmpty)
                    ? Colors.blue
                    : Colors.grey,
                fontWeight: (horario != null && horario.isNotEmpty)
                    ? FontWeight.w500
                    : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
