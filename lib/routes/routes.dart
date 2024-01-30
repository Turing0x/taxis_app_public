

import 'package:flutter/material.dart';
import 'package:taxis_app_public/Chat_app/pages/chat_page.dart';
import 'package:taxis_app_public/Chat_app/pages/loading_page.dart';
import 'package:taxis_app_public/Chat_app/pages/login_page.dart';
import 'package:taxis_app_public/Chat_app/pages/register_page.dart';
import 'package:taxis_app_public/Chat_app/pages/usuarios_page.dart';
import 'package:taxis_app_public/Core/pages/home_screen.dart';



final Map<String, Widget Function(BuildContext)> appRoutes = {


  'usuarios'      : ( _ ) => const UsuariosPage(),
  'chat'          : ( _ ) => const ChatPage(),
  'login'         : ( _ ) => const LoginPage(),
  'register'      : ( _ ) => const RegisterPage(),
  'loading'       : ( _ ) => const LoadingPage(),
  'home'          : ( _ ) => const HomeScreen(),

};


