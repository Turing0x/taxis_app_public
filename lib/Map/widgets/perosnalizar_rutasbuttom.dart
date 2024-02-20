import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxis_app_public/Map/blocs/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';
import 'package:taxis_app_public/Map/widgets/propiedades_ruta.dart';

class PropiedadesRuta extends StatefulWidget {
  const PropiedadesRuta({super.key});

  @override
  State<PropiedadesRuta> createState() => _PropiedadesRutaState();
}

class _PropiedadesRutaState extends State<PropiedadesRuta> {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
           Icons.remove_red_eye,
            color: Colors.black,
          ),
          onPressed: () {
                      showBottomSheet(context: context, builder: (context) => CrearPropiedadesRuta(origenSeleccionado: ValueNotifier(BlocProvider.of<BusquedaBloc>(context).state.historial.first), destinoSeleccionado: ValueNotifier(BlocProvider.of<BusquedaBloc>(context).state.historial.first))
            );
          },
        ),
      ),
    );
  }
}