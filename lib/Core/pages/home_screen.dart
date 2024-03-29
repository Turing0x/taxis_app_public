import 'package:flutter/material.dart';

import 'package:taxis_app_public/Core/widgets/menu_drawer.dart';
import 'package:taxis_app_public/Map/screens/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MDrawer(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white60,
      //   child: const Icon(Icons.menu),
      //   onPressed: () async {
      //     await showTopModalSheet<String?>(context, const MDrawer());
      //   },
      // ),
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
