import 'package:flutter/material.dart';

import 'package:taxis_app_public/Core/widgets/menu_drawer.dart';
import 'package:taxis_app_public/Map_app/screens/loading_screen.dart';
import 'package:taxis_app_public/Map_app/screens/map_screen.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    void showMyWidget() {
  showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return  const MDrawer();
      },
    );
  },
);
}
    return Scaffold(
      
      drawer:const MDrawer() ,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.white60,
        child: const Icon(Icons.menu),
        onPressed: () async {

        await showTopModalSheet<String?>(context, const MDrawer());
 
      },),     
      
      body: const SafeArea(
        child:Stack(
          children: [
            Center(
              child: LoadingScreen(),
             ),
          ],
        )),
    );
  }
}




















