import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taxis_app_public/Core/widgets/menu_drawer.dart';
import 'package:taxis_app_public/Map/blocs/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map/screens/loading_screen.dart';
import 'package:taxis_app_public/Map/widgets/propiedades_ruta.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white60,
        child: const Icon(Icons.menu),
        onPressed: () async {
         
        },
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: LoadingScreen(),
          ),
        ],
      )),
    );
  }
}
