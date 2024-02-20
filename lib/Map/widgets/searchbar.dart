import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Core/models/google_polyline.dart';
import 'package:taxis_app_public/Map/blocs/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';
import 'package:taxis_app_public/Map/models/search_results.dart';
import 'package:taxis_app_public/Map/search/search_destination.dart';
import 'package:taxis_app_public/Map/services/traffic_services.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        return (!state.seleccionManual)
            ? FadeInDown(duration: const Duration(milliseconds: 300), child: buildSearchbar(context))
            : Container();
      },
    );
  }

  Widget buildSearchbar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
              final historial = BlocProvider.of<BusquedaBloc>(context).state.historial;
            final resultado = await showSearch(
                context: context,
                delegate: SearchDestination(BlocProvider.of<LocationBloc>(context).state.lastKnowLocation!,historial));
            retornoBusqueda(resultado!, context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))]),
            child: const Text('¿Dónde quieres ir?', style: TextStyle(color: Colors.black87)),
          ),
        ),
      ),
    );
  }

  Future<void> retornoBusqueda(SearchResults result, BuildContext context)async {
    final busqueda = BlocProvider.of<BusquedaBloc>(context);
    if (result.cancelo) return;
    if (result.manual!) {
      busqueda.add(OnActivarMarcadorManual());
      return;
    }
    //Calcula Ruta por Result
     PolylinePoints polylinePoints = PolylinePoints();
  final trafficService =TrafficService();
  final busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
  final mapaBloc = BlocProvider.of<MapBloc>(context);
  final inicio = BlocProvider.of<LocationBloc>(context).state.lastKnowLocation!;
  final destino =result.position;
  final drivingResponse = await trafficService.getCoordsInicioYDestino(inicio, destino!, const Duration(minutes: 1));
  final geometry =drivingResponse.routes[0].polyline;
  final duration =drivingResponse.routes[0].duration;
  final distance =drivingResponse.routes[0].distanceMeters;
  final points = polylinePoints.decodePolyline(geometry.encodedPolyline);
  final List<LatLng> rutaCoordenadas = points.map((point) => LatLng(point.latitude, point.longitude)).toList();
  mapaBloc.add(OnCrearRutaInicioDestino(coords: rutaCoordenadas , distancia: distance.toDouble(), duration: duration));
   //TODO:Agregar al Historial
  
   busquedaBloc.add(OnAgregarHistorial(result: result));
   
   
   }
 




 
}
