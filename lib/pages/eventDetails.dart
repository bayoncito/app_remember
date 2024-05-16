import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calendary.dart';

class EventDetails extends StatelessWidget {
  final Event evento;

  const EventDetails({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Evento'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles del Evento:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Título: ${evento.title}'),
            SizedBox(height: 8),
            // Mostrar la fecha del evento
            Text('Fecha: ${DateFormat('dd/MM/yyyy').format(evento.date)}'),
            // Mostrar la hora del evento
            Text('Hora: ${DateFormat('HH:mm').format(evento.date)}'),
            // Mostrar la descripción del evento
            Text('Descripción: ${evento.description}'),
          ],
        ),
      ),
    );
  }
}
