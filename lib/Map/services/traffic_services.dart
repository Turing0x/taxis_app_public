import 'dart:async';
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Map/helpers/debouncer.dart';
import 'package:taxis_app_public/Map/models/places_results.dart';
import 'package:taxis_app_public/Map/models/traffic_response.dart';

class TrafficService {
  static final TrafficService _instance = TrafficService._internal();
  factory TrafficService() {
    return _instance;
  }
  TrafficService._internal();
  late Dio _dio;
  final debouncer = Debouncer<String>(duration: const Duration(milliseconds: 500));
  final StreamController<FindPlacesRespose> _sugerenciasStreamController =
      StreamController<FindPlacesRespose>.broadcast();
  Stream<FindPlacesRespose> get sugerenciasStream => _sugerenciasStreamController.stream;

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
    
  Future<DrivingResponse> getCoordsInicioYDestino(LatLng inicio, LatLng destino, Duration tiempoSalida,BuildContext context) async {
    String fecha = DateTime.now().add(tiempoSalida).toUtc().toIso8601String();
    await _initializeDio();
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['X-Goog-Api-Key'] = 'AIzaSyD02_rRNBExD1cmU8I684O-Kt5UGsN3Hs4';
    _dio.options.headers['X-Goog-FieldMask'] = 'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline';
    String url = 'https://routes.googleapis.com/directions/v2:computeRoutes';
    Map<String, dynamic> data = {
      "origin": {
        "location": {
          "latLng": {"latitude": "${inicio.latitude}", "longitude": "${inicio.longitude}"}
        }
      },
      "destination": {
        "location": {
          "latLng": {"latitude": "${destino.latitude}", "longitude": "${destino.longitude}"}
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "departureTime": fecha,
      "computeAlternativeRoutes": false,
      "routeModifiers": {"avoidTolls": false, "avoidHighways": false, "avoidFerries": false},
      "languageCode": "es-ES",
      "units": "IMPERIAL"
    };
    final response = await _dio.post(url, data: data);
if(response.data["routes"].toString() ==''){
   showDialog(context: context, builder: (context) => SnackBar(
        content: Text('No hay ruta disponible'),
      ));
}
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
    'fields': 'name,geometry,formatted_address',
    'locationbias': 'circle:${proximidad.latitude},${proximidad.longitude},10000',
    'region': 'CU',
    'key':'AIzaSyD02_rRNBExD1cmU8I684O-Kt5UGsN3Hs4', // Ajusta el radio según sea necesario
    'language': 'es',
    'maxresults': 10
  };
   final response = await _dio.get(url,queryParameters: params );
try{
  if ( 
    response.statusCode ==  200 && response.data['status'] == 'OK'
    ) {
 // return  response.data;
 //TODO:CambiarJsonString por response.data
 return FindPlacesRespose.fromJson(response.data);
 // } else {
 //  throw Exception('Error al buscar lugares: ${response.data['error_message']}');
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
//  Future<String> getAddress(double latitude, double longitude) async {
//   final String apiKey = 'TU_CLAVE_API'; // Reemplaza 'TU_CLAVE_API' con tu clave API de Google Cloud
//   final String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyD02_rRNBExD1cmU8I684O-Kt5UGsN3Hs4';

//   final response = _dio.get(url);

//   if (response.statusCode ==  200) {
//     final data = jsonDecode(response.body);
//     if (data['status'] == 'OK') {
//       final String address = data['results'][0]['formatted_address'];
//       return address;
//     } else {
//       throw Exception('Error al obtener la dirección: ${data['status']}');
//     }
//   } else {
//     throw Exception('Error al realizar la petición: ${response.statusCode}');
//   }
// }
}

