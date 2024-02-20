import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxis_app_public/Map/blocs/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map/models/search_results.dart';

class CrearPropiedadesRuta extends StatefulWidget {
  final ValueNotifier<SearchResults> origenSeleccionado ;
  final ValueNotifier<SearchResults> destinoSeleccionado;

  CrearPropiedadesRuta({super.key, required this.origenSeleccionado, required this.destinoSeleccionado});

  @override
  State<CrearPropiedadesRuta> createState() => _CrearPropiedadesRutaState();
}

class _CrearPropiedadesRutaState extends State<CrearPropiedadesRuta> {
  final ValueNotifier<Duration> duracionSeleccionada = ValueNotifier<Duration>(Duration(minutes:  10));

  @override
  Widget build(BuildContext context) {
    final historial = BlocProvider.of<BusquedaBloc>(context).state.historial;
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Selecciona el lugar de inicio'),
          ValueListenableBuilder<SearchResults>(
            valueListenable: widget.origenSeleccionado,
            builder: (context, origen, child) {
              return DropdownButton<SearchResults>(
                value: origen,
                items: historial.map((ruta) {
                  return DropdownMenuItem<SearchResults>(
                    value: ruta,
                    child: Text(ruta.nombreDestino!),
                  );
                }).toList(),
                onChanged: (SearchResults? nuevoOrigen) {
                  widget.origenSeleccionado.value = nuevoOrigen!;
                },
              );
            },
          ),
          Text('Selecciona el lugar de destino'),
          ValueListenableBuilder<SearchResults>(
            valueListenable: widget.destinoSeleccionado,
            builder: (context, destino, child) {
              return DropdownButton<SearchResults>(
                value: destino,
                items: historial.map((ruta) {
                  return DropdownMenuItem<SearchResults>(
                    value: ruta,
                    child: Text(ruta.nombreDestino!),
                  );
                }).toList(),
                onChanged: (SearchResults? nuevoDestino) {
                  widget.destinoSeleccionado.value = nuevoDestino!;
                },
              );
            },
          ),
          Text('Selecciona la duración:${duracionSeleccionada.value.inMinutes}'),
          ValueListenableBuilder<Duration>(
            valueListenable: duracionSeleccionada,
            builder: (context, duracion, child) {
              return Slider(
                value: duracion.inMinutes.toDouble(),
                min:  0.0,
                max:  24.0,
                divisions:48,
                onChanged: (double value) {
                 setState(() {
                    duracionSeleccionada.value = Duration(minutes: value.round());
                 });
                
                },
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Aquí puedes manejar el cierre del BottomSheet
              // y realizar acciones con la ruta y duración seleccionadas
              Navigator.pop(context);
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}