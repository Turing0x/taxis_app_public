import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TrafficService {

  static final TrafficService _instance = TrafficService._internal();
  factory TrafficService(){
    return _instance;
  }
 TrafficService._internal();
  final _dio =  Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey  = 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJja2UxbmcwYXEwMTI4MnF1bDNpOXVtczZ1In0.WU-RLHl90X1vck6KXv1JdQ';

  Future getCoordsInicioYDestino( LatLng inicio, LatLng destino ) async {

    final coordString = '${ inicio.longitude },${ inicio.latitude };${ destino.longitude },${ destino.latitude }';
    final url = '$_baseUrl /mapbox/driving/$coordString';

    final resp = await _dio.get( url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': _apiKey,
      'language': 'es',
    });

  }

}