import 'package:flutter/material.dart';

import 'calendary.dart';

class InsertEvent extends StatefulWidget {
  final DateTime fecha;

  const InsertEvent({Key? key, required this.fecha}) : super(key: key);

  @override
  _InsertEventState createState() => _InsertEventState();
}

class _InsertEventState extends State<InsertEvent> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha: ${widget.fecha.day}/${widget.fecha.month}/${widget.fecha.year}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título del Evento',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción del Evento',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String titulo = _tituloController.text.trim();
                String descripcion = _descripcionController.text.trim();
                if (titulo.isNotEmpty) {
                  DateTime horaActual = DateTime.now();
                  Event nuevoEvento = Event(
                    title: titulo,
                    date: DateTime(widget.fecha.year, widget.fecha.month, widget.fecha.day, horaActual.hour, horaActual.minute),
                    description: descripcion,
                  );
                  // Devuelve el nuevo evento a la pantalla anterior
                  Navigator.pop(context, nuevoEvento);
                }
              },
              child: Text('Guardar Evento'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }
}
