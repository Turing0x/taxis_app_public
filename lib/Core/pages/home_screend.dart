import 'package:flutter/material.dart';
import 'package:taxis_app_public/Core/widgets/menu_drawer.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:const MenuDrawer() ,
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            child: const Text('Home Screen'),
          ),
         )),
    );
  }
}