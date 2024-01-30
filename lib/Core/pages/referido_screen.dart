import 'package:flutter/material.dart';

class ReferidoScreen extends StatelessWidget {
  const ReferidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Código de referido'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          const Icon(
            Icons.label_outline,
            size: 200,
          ),
          Container(
  child: Text(
    'Tu código de referido: TKZNUOED',
    style: TextStyle(
      fontSize: 24,
      color: Colors.amber[400],
      shadows: const <Shadow>[
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 3.0,
          color:Colors.yellow,
        ),
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 8.0,
          color: Colors.black,
        ),
      ],
    ),
  ),
),
         
          const Text(
            'Comparte este código de referido con sus amigos',
            style: TextStyle(fontSize: 16),
          ),
          ElevatedButton(
            onPressed: () {
              // Acción para Compartir Código
            },
            child: const Text('Compartir código'),
          ),
        ],
      ),
    );
  }
}