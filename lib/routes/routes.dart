import 'package:flutter/material.dart';
import 'package:taxis_app_public/Chat/pages/chat_page.dart';
import 'package:taxis_app_public/Chat/pages/loading_page.dart';
import 'package:taxis_app_public/Chat/pages/usuarios_page.dart';
import 'package:taxis_app_public/Core/pages/home_screen.dart';
import 'package:taxis_app_public/Map/screens/Auth/auth_page.dart';
import 'package:taxis_app_public/Map/screens/Auth/register_page.dart';
import 'package:taxis_app_public/Map/screens/gps_access_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios'      : ( _ ) => const UsuariosPage(),
  'chat'          : ( _ ) => const ChatPage(),
  'auth_page'     : ( _ ) => const AuthPage(),
  'register_page' : ( _ ) => const RegisterPage(),
  'loading'       : ( _ ) => const LoadingPage(),
  'home'          : ( _ ) => const HomeScreen(),
  'location_permission' : ( _ ) => const GpsAcessScreen(),
};