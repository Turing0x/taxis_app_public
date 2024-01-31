import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:taxis_app_public/Map/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';
import 'package:taxis_app_public/Map/views/map_view.dart';
import 'package:taxis_app_public/Map/widgets/btn_follow_user.dart';
import 'package:taxis_app_public/Map/widgets/btn_location.dart';
import 'package:taxis_app_public/Map/widgets/btn_toogle_user_route.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    //locationBloc.getCurrentPosition();

    return locationBloc.startFollowingUsers();
  }

  @override
  void dispose() {
    //locationBloc se inicializa en initState
    locationBloc.stopFollowingUsers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //MultiBloc
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnowLocation == null) {
            return const Center(child: Text("Espere por favor..."));
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines =
                  Map.from(mapState.polylines); //copia de las polylines

              if (mapState.showMyRoute == false) {
                polylines.removeWhere((key, value) => key == "myRoute");
              }

              return MapView(
                initialLocation: locationState.lastKnowLocation!,
                polylines: polylines.values.toSet(),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnToggleUser(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}
