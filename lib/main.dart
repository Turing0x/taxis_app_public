import 'package:flutter/material.dart';

import 'package:taxis_app_public/routes/routes.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'taxis_app_public App',
      initialRoute: 'usuarios',
      routes: appRoutes,
    );
  }
}