import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Map/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';
import 'package:taxis_app_public/Map/helpers/calculando_alerta.dart';
import 'package:taxis_app_public/Map/models/search_results.dart';
import 'package:taxis_app_public/Map/services/traffic_services.dart';

class BottomTravelSheet extends StatefulWidget {
  final List<SearchResults> historial;
  final LatLng destino;
  final LatLng inicio;
  const BottomTravelSheet({
    super.key, required this.historial, required this.destino, required this.inicio,
  });

  @override
  State<BottomTravelSheet> createState() => _BottomTravelSheetState();
}

class _BottomTravelSheetState extends State<BottomTravelSheet> {
 
 

  @override
  Widget build(BuildContext context) {
 PolylinePoints polylinePoints = PolylinePoints();
 final mapBloc = BlocProvider.of<MapBloc>(context);
   final locationBloc = BlocProvider.of<LocationBloc>(context);
   SearchResults inicio = SearchResults(
    descripcion: 'Inicio',
    cancelo: false,
    favorito: false,
    manual: false,
    nombreDestino: 'Inicio',
    position: widget.inicio,
  );

  SearchResults destino = SearchResults(
    descripcion: 'Destino',
    cancelo: false,
    favorito: false,
    manual: false,
    nombreDestino: 'Destino',
    position: widget.destino,
  );
 SearchResults? selectedRouteStart=inicio;
 SearchResults? selectedRouteEnd=destino;
  // Agregar las instancias de inicio y destino al principio de la lista de historial
  List<SearchResults> places = [inicio, destino]..addAll(widget.historial);

   List<DropdownMenuItem<SearchResults>> all = places.map<DropdownMenuItem<SearchResults>>((SearchResults value) {
    return DropdownMenuItem<SearchResults>(
      value: value,
      child: ListTile(
        title: Text(value.descripcion!),
        leading: Icon(Icons.location_on),
      ),
    );
  }).toList();
  List<DropdownMenuItem<SearchResults>> alls = places.map<DropdownMenuItem<SearchResults>>((SearchResults value) {
    return DropdownMenuItem<SearchResults>(
      value: value,
      child: Text(value.descripcion!));
  }).toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height *  0.3,
      width: MediaQuery.of(context).size.width,
      child: Container(
      
      color: Colors.white70,
      child: Column(
        children: [
           IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
           Container(
            
             width: MediaQuery.of(context).size.width-47,
            height: 50,
             child: DropdownButton<SearchResults>(
            
        
           
              value: selectedRouteStart,
              onChanged: (newValue) {
                setState(() {
                  super.setState(() {
                    selectedRouteStart = newValue;
                  });
                    
                  
                });
                print('Ruta seleccionada: ${selectedRouteStart?.descripcion}');
              },
              items: alls,
                       ),
           ),
            Container(
            width: MediaQuery.of(context).size.width-40,
            height: 40,
             child: DropdownButton<SearchResults>(
              value: selectedRouteStart,
              onChanged: (newValue) {
                setState(() {
                  super.setState(() {
                    selectedRouteStart = newValue;
                  });
                    
                  
                });
                print('Ruta seleccionada: ${selectedRouteStart?.descripcion}');
              },
              items: alls,
                       ),
           ),
           Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [

              TextButton(onPressed: () {
                
              }, child: Icon(Icons.watch_later_outlined)),



               TextButton(onPressed: () {
               
        calculandoAlerta(context);
                  TrafficService().getCoordsInicioYDestino( selectedRouteStart!.position!,selectedRouteEnd!.position!, const Duration(minutes: 1),context).then((value) async {
      
       final geometry = value.routes[0].polyline;
       String duration = value.routes[0].duration;
       int distance = value.routes[0].distanceMeters;
    
       int intDuration = int.parse(duration.replaceAll('s', ''));
       final points = polylinePoints.decodePolyline(geometry.encodedPolyline);
       final List<LatLng> coordsLists = points.map((point) => LatLng(point.latitude, point.longitude)).toList();
       
       Navigator.pop(context);
       mapBloc.add(OnCrearRutaInicioDestino(coords: coordsLists, distancia: distance.toDouble(), duration: duration));

    });          





               
               }, child: Text('Confirmar Ruta')),
             ],
           )
         
        ],
      ),
        ),
    );
}}