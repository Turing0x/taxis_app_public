import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxis_app_public/Core/config/theme/app_theme.dart';
import 'package:taxis_app_public/Core/config/utils/initial_route.dart';
import 'package:taxis_app_public/Map/blocs/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map/blocs/gps/gps_bloc.dart';
import 'package:taxis_app_public/Map/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';
import 'package:taxis_app_public/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: '.env');

  final rutIni = await initialRoute();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BusquedaBloc>(create: (context) => BusquedaBloc(),),
        BlocProvider<GpsBloc>(create: (context) => GpsBloc()),
        BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
        BlocProvider<MapBloc>( create: (context) =>
          MapBloc(locationBloc: 
            BlocProvider.of<LocationBloc>(context))),
      ], 
      child: ProviderScope(
        child: MapsApp(
          rutaInicial: 'loading',
        ),
      )
    )
  );
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key,
    required this.rutaInicial, 
  });

  final String rutaInicial;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme( isDarkmode: false ).getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: rutaInicial,
      routes: appRoutes,
      title: 'MapsApp',
    );
  }
}
