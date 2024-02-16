import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billetera'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          Center(
            child: Card(
              color: Colors.grey[800],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Saldo',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    const Text(
                      '0.00 CUP',
                      style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        // Acción para ver el historial
                      },
                      child: const Text(
                        'Pulse para ver el historial',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.4),
          ElevatedButton(
            onPressed: () {
              // Acción para Transferir Saldo
            },
            child: const Text('Transferir saldo'),
          ),
          ElevatedButton(
            onPressed: () {
              // Acción para Recargar Saldo
            },
            child: const Text('Recargar saldo'),
          ),
        ],
      ),
    );
  }
}
