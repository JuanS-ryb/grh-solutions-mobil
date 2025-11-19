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
  Map<DateTime, String> inasistencias = {}; // ahora guarda tipo/nombre
  String horarioGeneral = '';

  // Helper para comparar solo año-mes-día
  DateTime soloFecha(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

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
          final key = soloFecha(fechaInicio);

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

      // Cargar inasistencias
      final requests = await requestService.getRequests();
      final Map<DateTime, String> mapaInasistencias = {};

      for (final req in requests) {
if ((req.typeRequest ?? '').toLowerCase().contains('inasistencia')) {
  final createdAt = req.createdAt.toLocal();
  final fechaKey = soloFecha(createdAt);

  // Guardamos el title, no el type_request
  mapaInasistencias[fechaKey] = req.title ?? 'Inasistencia';
}
      }

      if (mounted) {
        setState(() {
          horarios = mapaHorarios;
          inasistencias = mapaInasistencias;
          grupo = nombreGrupo;
        });
      }
    } catch (e) {
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

    final claveSeleccionada = soloFecha(_selectedDay!);

    final horarioSeleccionado = horarios[claveSeleccionada];

    setState(() {
      inasistencias[claveSeleccionada] = 'Inasistencia registrada';
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

void _mostrarModalInasistencia(DateTime fecha) {
  final titulo = inasistencias[fecha] ?? 'Inasistencia registrada';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titulo), 
        content: const Text("Este día tiene registrada la inasistencia."),
        actions: [
          TextButton(
            child: const Text("Cerrar"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final clave = (_selectedDay == null) ? null : soloFecha(_selectedDay!);
    final diaTieneInasistencia = clave != null && inasistencias.containsKey(clave);

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
                ? (horarios[clave] ?? horarioGeneral ?? "Sin horario")
                : "Selecciona un día para ver horario",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 12),

          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            locale: 'es_ES',
            selectedDayPredicate: (day) => soloFecha(day) == clave,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration:
                  BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
              selectedDecoration:
                  BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            ),
            rowHeight: 80,

            onDaySelected: (selectedDay, focusedDay) {
              final claveSeleccionada = soloFecha(selectedDay);
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

              if (inasistencias.containsKey(claveSeleccionada)) {
                _mostrarModalInasistencia(claveSeleccionada);
              }
            },

            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) =>
                  _buildDayCell(day),
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
              onPressed: (!diaTieneInasistencia && _selectedDay != null)
                  ? _navegarACrearInasistencia
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor:
                    (!diaTieneInasistencia && _selectedDay != null)
                        ? Colors.blue
                        : Colors.grey,
              ),
              child: Text(
                (!diaTieneInasistencia)
                    ? "Generar Inasistencia"
                    : "Ya existe inasistencia",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDayCell(DateTime day,
      {bool isToday = false, bool isSelected = false}) {
    final clave = soloFecha(day);
    final bool tieneInasistencia = inasistencias.containsKey(clave);
    final bool esHoy = isSameDay(day, DateTime.now());

    String? horario = horarios[clave] ?? horarioGeneral;

    return Stack(
      alignment: Alignment.center,
      children: [
        if (tieneInasistencia && !esHoy)
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
          ),
        if (!tieneInasistencia || esHoy)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green
                  : isToday
                      ? Colors.blueAccent
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        Text(
          '${day.day}',
          style: TextStyle(
            color: (tieneInasistencia && !esHoy) || isSelected || isToday
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                fontWeight: FontWeight.w500,
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
