import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Map/blocs/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';
import 'package:taxis_app_public/Map/helpers/calculando_alerta.dart';
import 'package:taxis_app_public/Map/services/traffic_services.dart';
import 'package:taxis_app_public/Map/widgets/TravelOptions.dart';

import 'package:taxis_app_public/shared/widgets.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapView({
    super.key,
    required this.initialLocation,
    required this.polylines,
  });

  @override
  Widget build(BuildContext context) {
     PolylinePoints polylinePoints = PolylinePoints();
    final mapBloc = BlocProvider.of<MapBloc>(context);
   final locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc.add(OnUbicacionCambio(initialLocation));

    final CameraPosition initialCameraPosition = CameraPosition(target: initialLocation, zoom: 15);

    final size = MediaQuery.of(context).size;

    return SizedBox(
        width: size.width,
        height: size.height,
        child: Listener(
          onPointerMove: (pointerMoveEvent) => mapBloc.add(OnStopFollowingUser()),
          child: BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return GoogleMap(
                mapType: MapType.normal,
                onCameraMove: (position) {
                  mapBloc.add(OnMovioMapa(centroMapa: position.target));
                },
                onTap: (argument) {
                  calculandoAlerta(context);
                  TrafficService().getCoordsInicioYDestino(locationBloc.state.lastKnowLocation!, argument, const Duration(minutes: 1),context).then((value) async {
      
       final geometry = value.routes[0].polyline;
       String duration = value.routes[0].duration;
       int distance = value.routes[0].distanceMeters;
    
       int intDuration = int.parse(duration.replaceAll('s', ''));
       final points = polylinePoints.decodePolyline(geometry.encodedPolyline);
       final List<LatLng> coordsLists = points.map((point) => LatLng(point.latitude, point.longitude)).toList();
       
       Navigator.pop(context);
       mapBloc.add(OnCrearRutaInicioDestino(coords: coordsLists, distancia: distance.toDouble(), duration: duration));

    });           },
                onLongPress: (argument) {
                  showBottomSheet(context: context, builder: (context) {
                   return Container(
                      height: MediaQuery.of(context).size.height *  0.3,
                 width: double.infinity,
                    child: BottomTravelSheet(historial:BlocProvider.of<BusquedaBloc>(context).state.historial,destino: argument,inicio: BlocProvider.of<LocationBloc>(context).state.lastKnowLocation!,));
                  },);
                },
                initialCameraPosition: initialCameraPosition,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                polylines: mapBloc.state.polylines.values.toSet(),
                markers: mapBloc.state.markers.values.toSet(),
                onMapCreated: mapBloc.initMapa,
              );
            },
          ),
        ));
  }
}


