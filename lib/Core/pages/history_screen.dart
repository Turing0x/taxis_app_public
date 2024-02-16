import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<String> rutas = [
    'Ruta 1: Autobús         ${DateTime.now()}',
    'Ruta 2: Camion de Carga ${DateTime.now()} ',
    'Ruta 3: Automovil       ${DateTime.now()}',
    // Añade más rutas aquí
  ];

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Rutas'),
      ),
      body: ListView.builder(
        itemCount: rutas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(rutas[index]),
          );
        },
      ),
    );
  }
}
