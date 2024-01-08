import 'package:flutter/material.dart';
import 'package:taxis_app_public/Chat_app/pages/chat_page.dart';
import 'package:taxis_app_public/Chat_app/pages/loading_page.dart';
import 'package:taxis_app_public/Chat_app/pages/login_page.dart';
import 'package:taxis_app_public/Chat_app/pages/register_page.dart';
import 'package:taxis_app_public/Chat_app/pages/usuarios_page.dart';
import 'package:taxis_app_public/Map_app/pages/acceso_gps_page.dart';
import 'package:taxis_app_public/Map_app/pages/loading_page.dart';
import 'package:taxis_app_public/Map_app/pages/mapa_page.dart';



final Map<String, Widget Function(BuildContext)> appRoutes = {

  'mapa'          : ( _ ) => MapaPage(),
  'loading map'   : ( _ ) => LoadingPageMap(),
  'acceso_gps'    : ( _ ) => AccesoGpsPage(),
  'usuarios'      : ( _ ) => UsuariosPage(),
  'chat'          : ( _ ) => ChatPage(),
  'login'         : ( _ ) => LoginPage(),
  'register'      : ( _ ) => RegisterPage(),
  'loading'       : ( _ ) => LoadingPage(),

};


