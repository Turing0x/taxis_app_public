import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Core/models/google_polyline.dart';
import 'package:taxis_app_public/Map/models/traffic_response.dart';


class TrafficService {

  static final TrafficService _instance = TrafficService._internal();
  factory TrafficService(){
    return _instance;
  }
 TrafficService._internal();
  late Dio _dio; 

  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey  = 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJja2UxbmcwYXEwMTI4MnF1bDNpOXVtczZ1In0.WU-RLHl90X1vck6KXv1JdQ';

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

}