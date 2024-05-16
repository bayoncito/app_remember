import 'package:flutter/material.dart';

class InsertEvent extends StatefulWidget {
  final DateTime fecha;

  const InsertEvent({super.key, required this.fecha});

  @override
  // ignore: library_private_types_in_public_api
  _InsertEventState createState() => _InsertEventState();
}

class _InsertEventState extends State<InsertEvent> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Evento'),
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
              controller: _controller,
              decoration: const InputDecoration(
                labelText:'Nombre del Evento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String evento = _controller.text;
                if (evento.isNotEmpty) {
                  Navigator.pop(context, evento);
                }
              },
              child: const Text('Guardar Evento'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
