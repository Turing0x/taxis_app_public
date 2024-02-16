import 'package:dio/dio.dart';

import '../models/google_polyline.dart';

class RoutesControllers {
  late Dio _dio;

  RoutesControllers() {
    _initializeDio();
  }

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

  Future<List<GooglePolyline>> makeRouteRequest() async {
    await _initializeDio();
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['X-Goog-Api-Key'] = 'AIzaSyD02_rRNBExD1cmU8I684O-Kt5UGsN3Hs4';
    _dio.options.headers['X-Goog-FieldMask'] = 'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline';

    String url = 'https://routes.googleapis.com/directions/v2:computeRoutes';
    Map<String, dynamic> data = {
      "origin": {
        "location": {
          "latLng": {"latitude": 37.419734, "longitude": -122.0827784}
        }
      },
      "destination": {
        "location": {
          "latLng": {"latitude": 37.417670, "longitude": -122.079595}
        }
      },
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "departureTime": "2024-10-15T15:01:23.045123456Z",
      "computeAlternativeRoutes": false,
      "routeModifiers": {"avoidTolls": false, "avoidHighways": false, "avoidFerries": false},
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };

    try {
      Response response = await _dio.post(url, data: data);
      print(response);

      List<GooglePolyline> list = [];

      list.add(GooglePolyline.fromJson(response.data));

      return list;
    } catch (e) {
      return [];
    }
  }
}
