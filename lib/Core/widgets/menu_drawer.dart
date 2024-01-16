import 'package:flutter/material.dart';
import 'package:taxis_app_public/Chat_app/pages/chat_page.dart';
import 'package:taxis_app_public/Chat_app/pages/usuarios_page.dart';

import 'package:taxis_app_public/Map_app/screens/loading_screen.dart';
class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      width: MediaQuery.of(context).size.width*0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: const Icon(Icons.settings_applications_outlined),
             onTap: () {

             },
             title: const Text('Opciones'),
             ),
             ListTile(
            leading: const Icon(Icons.map_outlined),
             onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder:(context) => LoadingScreen(),));
             },
             title: const Text('Mapa'),
             ),ListTile(
            leading: const Icon(Icons.chat),
             onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder:(context) => UsuariosPage(),));       
             },
             title: const Text('Chat'),
             )
        ],
      ),
    );
  }
}