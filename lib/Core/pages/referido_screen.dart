import 'package:flutter/material.dart';

class ReferidoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Código de referido'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Icon(
            Icons.label_outline,
            size: 200,
          ),
          Container(
  child: Text(
    'Tu código de referido: TKZNUOED',
    style: TextStyle(
      fontSize: 24,
      color: Colors.amber[400],
      shadows: <Shadow>[
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
         
          Text(
            'Comparte este código de referido con sus amigos',
            style: TextStyle(fontSize: 16),
          ),
          ElevatedButton(
            onPressed: () {
              // Acción para Compartir Código
            },
            child: Text('Compartir código'),
          ),
        ],
      ),
    );
  }
}