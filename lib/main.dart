import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxis_app_public/Map_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map_app/bloc/mapa/mapa_bloc.dart';
import 'package:taxis_app_public/Map_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:taxis_app_public/routes/routes.dart';



void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => MiUbicacionBloc() ),
        BlocProvider(create: ( _ ) => MapaBloc() ),
        BlocProvider(create: ( _ ) => BusquedaBloc() ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'taxis_app_public App',
        initialRoute: 'loading map',
        routes: appRoutes,
      ),
    );
  }
}