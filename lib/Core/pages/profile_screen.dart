import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profileImage.jpg'), // Reemplaza con la URL de tu imagen
            ),
           
            Text(
              'Nombre del Usuario',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'usuario@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '+1234567890',
              style: TextStyle(fontSize: 16),
            ),
             SizedBox(height: MediaQuery.of(context).size.height*0.2),
            ElevatedButton(
              
              style: ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 25,color: Colors.black,)) ),
              onPressed: () {
                // Acción para cambiar la contraseña
              },
              child: Text('Cambiar Contraseña'),
            ),
            ElevatedButton(
              style: ButtonStyle(textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 25,color: Colors.black,)) ),
              onPressed: () {
                // Acción para cambiar el número de teléfono
              },
              child: Text('Cambiar Número de Teléfono',),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.15),
             ElevatedButton(
              style: ButtonStyle(
               
                backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
                // Acción para Cerrar Sesion
              },
              child: Text('Cerrar Sesion',style: TextStyle(color:  Colors.black)),
              
            ),
             ElevatedButton(
              onPressed: () {
                // Acción para Eliminar Cuenta
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Eliminar Cuenta',style: TextStyle(color: Colors.black),),
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