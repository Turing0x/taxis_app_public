import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Map_app/bloc/mapa/mapa_bloc.dart';
import 'package:taxis_app_public/Map_app/widgets/widgets.dart';

import '../bloc/mi_ubicacion/mi_ubicacion_bloc.dart';


class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  @override
  void initState() {
    
    context.watch<MiUbicacionBloc>().iniciarSeguimiento();

    super.initState();
  }

  @override
  void dispose() {
    context.watch<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: ( _ , state)  => crearMapa( state )
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          BtnUbicacion(),

          BtnSeguirUbicacion(),

          BtnMiRuta(),

        ],
      ),
   );

  }

  Widget crearMapa(MiUbicacionState state ) {

    if ( !state.existeUbicacion ) return Center(child: Text('Ubicando...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add( OnNuevaUbicacion( state.ubicacion! ) );

    final cameraPosition = CameraPosition(
      target: state.ubicacion!,
      zoom: 15
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc.initMapa,
      polylines:  mapaBloc.state.polylines.values.toSet(),
      onCameraMove: ( cameraPosition ) {
        // cameraPosition.target = LatLng central del mapa
        mapaBloc.add( OnMovioMapa( cameraPosition.target ));
      },
    );

  }

}