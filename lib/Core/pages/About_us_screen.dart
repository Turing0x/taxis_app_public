import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  final List<Map<String, String>> faq = [
    {
      'pregunta': '¿Cómo puedo pedir un taxi?',
      'respuesta': 'Puedes pedir un taxi desde la pantalla principal de la aplicación.'
    },
    {
      'pregunta': '¿Cómo puedo pagar por el viaje?',
      'respuesta': 'Puedes pagar en efectivo o a través de la aplicación si has vinculado una tarjeta de crédito.'
    },
    {
      'pregunta': '¿Cómo puedo calificar a mi conductor?',
      'respuesta': 'Después de finalizar el viaje, tendrás la opción de calificar a tu conductor.'
    },
    // Añade más preguntas y respuestas aquí
  ];

  AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preguntas Frecuentes'),
      ),
      body: ListView.builder(
        itemCount: faq.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faq[index]['pregunta']!),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faq[index]['respuesta']!),
              ),
            ],
          );
        },
      ),
    );
  }
}