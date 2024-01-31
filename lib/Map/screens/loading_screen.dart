import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taxis_app_public/Map/screens/gps_access_screen.dart';

import '../blocs/gps/gps_bloc.dart';
import 'map_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return (state.isAllGranted)
              ? const MapScreen()
              : const GpsAcessScreen();
        },
      ),
    );
  }
}
