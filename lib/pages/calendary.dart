import 'package:flutter/material.dart';
import 'package:remember_app/pages/events.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';



final actualDia = DateTime.now();
final primerDia = DateTime(actualDia.year, actualDia.month - 3, actualDia.day);
final ultimoDia = DateTime(actualDia.year, actualDia.month + 3, actualDia.day);

class calendarioApp extends StatefulWidget {
  @override
  _calendarioAppState createState() => _calendarioAppState();
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final descEventos = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_eventosIngresados);


final Map<DateTime, List<Event>> _eventosIngresados = {};


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class _calendarioAppState extends State<calendarioApp> {
  late final ValueNotifier<List<Event>> _eventos;
  CalendarFormat _formatoCalendario = CalendarFormat.month;
  DateTime _actualDay = DateTime.now();
  DateTime? _diaSeleccionado;

  @override
  void initState() {
    super.initState();
    _diaSeleccionado = _actualDay;
    _eventos = ValueNotifier(_eventosPorDia(_diaSeleccionado!));
  }

  void dispose() {
    _eventos.dispose();
    super.dispose();
  }

  List<Event> _eventosPorDia(DateTime day) {
    return _eventosIngresados[day] ?? [];
  }

  void diaSeleccionado(DateTime diaSeleccionado, DateTime diaActual) {
    if (!isSameDay(_diaSeleccionado, diaSeleccionado)) {
      setState(() {
        _diaSeleccionado = diaSeleccionado;
        _actualDay = diaActual;
      });
      _eventos.value = _eventosPorDia(diaSeleccionado);
    }
  }

  void agregarEvento(DateTime fecha, String nombreEvento) {
  setState(() {
    if (_eventosIngresados.containsKey(fecha)) {
      _eventosIngresados[fecha]!.add(Event(nombreEvento));
    } else {
      _eventosIngresados[fecha] = [Event(nombreEvento)];
    }
    _eventos.value = _eventosPorDia(_diaSeleccionado!);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario De Recordatorios'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: primerDia,
            lastDay: ultimoDia,
            focusedDay: _actualDay,
            selectedDayPredicate: (day) => isSameDay(_diaSeleccionado, day),
            calendarFormat: _formatoCalendario,
            eventLoader: _eventosPorDia,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
            ),
            onDaySelected: diaSeleccionado,
            onFormatChanged: (format) {
              if (_formatoCalendario != format) {
                setState(() {
                  _formatoCalendario = format;
                });
              }
            },
            onPageChanged: (_diaFijado) {
              _actualDay = _diaFijado;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _eventos,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InsertEvent(fecha: _diaSeleccionado!)),
    ).then((nombreEvento) {
      if (nombreEvento != null) {
        agregarEvento(_diaSeleccionado!, nombreEvento);
      }
    });
  },
  child: Icon(Icons.add),
),

    );
  }
}
