import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billetera'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Center(
            child: Card(
              color: Colors.grey[800],
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Saldo',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    Text(
                      '0.00 CUP',
                      style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                    ),

                   
                    TextButton(
                      onPressed: () {
                        // Acción para ver el historial
                      },
                      child: Text(
                        'Pulse para ver el historial',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
           SizedBox(height: MediaQuery.of(context).size.height*0.4),
          ElevatedButton(
            onPressed: () {
              // Acción para Transferir Saldo
            },
            child: Text('Transferir saldo'),
          ),
          ElevatedButton(
            onPressed: () {
              // Acción para Recargar Saldo
            },
            child: Text('Recargar saldo'),
          ),
        ],
      ),
    );
  }
}