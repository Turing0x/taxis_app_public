import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';

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
    final mapBloc = BlocProvider.of<MapBloc>(context);

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
                initialCameraPosition: initialCameraPosition,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                polylines: mapBloc.state.polylines.values.toSet(),
                onMapCreated: mapBloc.initMapa,
              );
            },
          ),
        ));

    // TODO: Markers
    //TODO: Polylines
  }
}
