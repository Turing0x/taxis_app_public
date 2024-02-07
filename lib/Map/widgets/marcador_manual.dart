import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxis_app_public/Map/blocs/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';
import 'package:taxis_app_public/Map/services/traffic_services.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        return (state.seleccionManual) ? _BuildMarcadorManual() : Container();
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        return Stack(
          children: [
            // Botón regresar
            Positioned(
              top: 70,
              left: 20,
              child: FadeInLeft(
                child: CircleAvatar(
                  maxRadius: 25,
                  backgroundColor: Colors.white,
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () {
                        final busqueda = BlocProvider.of<BusquedaBloc>(context);
                        busqueda.add(OnDesactivarMarcadorManual());
                      }),
                ),
              ),
            ),

            Center(
              child: Transform.translate(
                  offset: const Offset(0, -12),
                  child: BounceInDown(
                      child: const Icon(Icons.location_on, size: 50))),
            ),

            // Boton de confirmar destino
            Positioned(
              bottom: 70,
              left: 40,
              child: FadeIn(
                child: MaterialButton(
                    minWidth: width - 120,
                    color: Colors.black,
                    shape: const StadiumBorder(),
                    elevation: 0,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      calcularDestino(context);
                    },
                    child: const Text('Confirmar destino',
                        style: TextStyle(color: Colors.white)))
                
                
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> calcularDestino(BuildContext context) async {
    final TrafficService trafficService = TrafficService();
    final mapaBloc = BlocProvider.of<MapBloc>(context);
    final miUbicaconBloc = BlocProvider.of<LocationBloc>(context);
    final inicio = miUbicaconBloc.state.lastKnowLocation;
    final fin = mapaBloc.state.ubicacionCentral;

    await trafficService.getCoordsInicioYDestino(inicio!, fin!);
  }
}
