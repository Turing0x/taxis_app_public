import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<bool> isSelected = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Opciones'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Opción ${index + 1}'),
            subtitle: Text('Descripción de la opción ${index + 1}'),
            trailing: Switch(
              value: isSelected[index],
              onChanged: (bool value) {
                setState(() {
                  isSelected[index] = value;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
