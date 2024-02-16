import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profileImage.jpg'), // Reemplaza con la URL de tu imagen
            ),
            const Text(
              'Nombre del Usuario',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'usuario@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '+1234567890',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ElevatedButton(
              style: const ButtonStyle(
                  textStyle: MaterialStatePropertyAll(TextStyle(
                fontSize: 25,
                color: Colors.black,
              ))),
              onPressed: () {
                // Acción para cambiar la contraseña
              },
              child: const Text('Cambiar Contraseña'),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  textStyle: MaterialStatePropertyAll(TextStyle(
                fontSize: 25,
                color: Colors.black,
              ))),
              onPressed: () {
                // Acción para cambiar el número de teléfono
              },
              child: const Text(
                'Cambiar Número de Teléfono',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            ElevatedButton(
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
                // Acción para Cerrar Sesion
              },
              child: const Text('Cerrar Sesion', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para Eliminar Cuenta
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Eliminar Cuenta',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.delete)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
