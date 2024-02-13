import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Core/models/google_polyline.dart';
import 'package:taxis_app_public/Map/helpers/debouncer.dart';
import 'package:taxis_app_public/Map/models/places_results.dart';
import 'package:taxis_app_public/Map/models/traffic_response.dart';


class TrafficService {

  static final TrafficService _instance = TrafficService._internal();
  factory TrafficService(){
    return _instance;
  }
 TrafficService._internal();
  late Dio _dio; 
final debouncer = Debouncer<String>(duration: const Duration(milliseconds: 500 ));
final StreamController <FindPlacesRespose>_sugerenciasStreamController = StreamController<FindPlacesRespose>.broadcast();
 Stream <FindPlacesRespose> get sugerenciasStream=>_sugerenciasStreamController.stream  ;
Map<String,dynamic> jsonString ={
   "candidates" : [
      {
         "formatted_address" : "1600 Amphitheatre Parkway, Mountain View, CA   94043, USA",
         "geometry" : {
            "location" : {
               "lat" :   37.4224764,
               "lng" : -122.0842499
            },
            "viewport" : {
               "northeast" : {
                  "lat" :   37.4238253802915,
                  "lng" : -122.0829009197085
               },
               "southwest" : {
                  "lat" :   37.4211274197085,
                  "lng" : -122.0855988802915
               }
            }
         }
      }
   ],
   "status" : "OK"
};
Future<void> _initializeDio() async {

    _dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
        },
        validateStatus: (status) => true,
      ),
    );
}
Future<DrivingResponse> getCoordsInicioYDestino( LatLng inicio, LatLng destino,Duration tiempoSalida ) async {
    String fecha=DateTime.now().add(tiempoSalida).toUtc().toIso8601String();
    await _initializeDio();
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['X-Goog-Api-Key'] = 'AIzaSyD02_rRNBExD1cmU8I684O-Kt5UGsN3Hs4';
    _dio.options.headers['X-Goog-FieldMask'] = 'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline';
    String url = 'https://routes.googleapis.com/directions/v2:computeRoutes';
    Map<String, dynamic> data = {
      "origin": {
        "location": {
          "latLng": {
            "latitude":  "${inicio.latitude}",
            "longitude":  "${inicio.longitude}"
          }
        }
      },
      "destination": {
        "location": {
          "latLng": {
            "latitude":  "${destino.latitude}",
            "longitude": "${destino.longitude}"
          }
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "departureTime":fecha ,
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "es-ES",
      "units": "IMPERIAL"
    };
     final response = await _dio.post(url, data: data);
      

     

      

      return DrivingResponse.fromJson(response.data);

  
    

  }
Future getPlacesPorQuery(String busqueda, LatLng proximidad) async {
  await _initializeDio();
  print('Buscando!!!!!!!!!!!!!!!!!!!!');
  _dio.options.headers['Content-Type'] = 'application/json';
  _dio.options.headers['X-Goog-Api-Key'] = 'AIzaSyD02_rRNBExD1cmU8I684O-Kt5UGsN3Hs4';
 
 
  String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json';
  Map<String, dynamic> params = {
    'input': busqueda,
    'inputtype': 'textquery',
    'fields': 'name,geometry',
    'locationbias': 'circle:${proximidad.latitude},${proximidad.longitude},10000',
    'region': 'CU',
    'key':'AIzaSyD02_rRNBExD1cmU8I684O-Kt5UGsN3Hs4' // Ajusta el radio según sea necesario
  };
try{
  if ( true
  //  response.statusCode ==  200 && response.data['status'] == 'OK'
    ) {
 // return  response.data;
 //TODO:CambiarJsonString por response.data
 return FindPlacesRespose.fromJson(jsonString);   
  } else {
   // throw Exception('Error al buscar lugares: ${response.data['error_message']}');
  }
} catch(e){
return FindPlacesRespose(candidates: [], status: '400');
}
  //final response = await _dio.get(url, queryParameters: params);

}
void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

  debouncer.value = '';
  debouncer.onValue = ( value ) async {
    final resultados = await getPlacesPorQuery(value, proximidad);
    _sugerenciasStreamController.add(resultados);
  };

  final timer = Timer.periodic(const Duration(milliseconds: 200), (_) {
    debouncer.value = busqueda;
  });

  Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 

}

}