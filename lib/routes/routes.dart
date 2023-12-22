import 'package:flutter/material.dart';
import 'package:taxis_app_public/pages/chat_page.dart';
import 'package:taxis_app_public/pages/loading_page.dart';
import 'package:taxis_app_public/pages/login_page.dart';
import 'package:taxis_app_public/pages/register_page.dart';
import 'package:taxis_app_public/pages/usuarios_page.dart';



final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios': ( _ ) => UsuariosPage(),
  'chat'    : ( _ ) => ChatPage(),
  'login'   : ( _ ) => LoginPage(),
  'register': ( _ ) => RegisterPage(),
  'loading' : ( _ ) => LoadingPage(),

};


