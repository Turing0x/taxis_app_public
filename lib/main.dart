import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:taxis_app_public/Core/config/theme/app_theme.dart';
import 'package:taxis_app_public/Core/pages/home_screend.dart';

import 'package:taxis_app_public/Map_app/blocs/gps/gps_bloc.dart';
import 'package:taxis_app_public/Map_app/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map_app/blocs/map/map_bloc.dart';
import 'package:taxis_app_public/Map_app/screens/loading_screen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<GpsBloc>(create: (context) => GpsBloc()),
    BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
    BlocProvider<MapBloc>(
        create: (context) =>
            MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
  ], child: const MapsApp()));
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:AppTheme( isDarkmode: false ).getTheme(),
      debugShowCheckedModeBanner: false,
     
      title: 'MapsApp',
      home: const HomeScreen(),
    );
  }
}
