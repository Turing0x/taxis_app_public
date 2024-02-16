import 'dart:convert';

class DrivingResponse {
  List<Route> routes;

  DrivingResponse({
    required this.routes,
  });

  factory DrivingResponse.fromRawJson(String str) => DrivingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DrivingResponse.fromJson(Map<String, dynamic> json) => DrivingResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class Route {
  int distanceMeters;
  String duration;
  Polyline polyline;

  Route({
    required this.distanceMeters,
    required this.duration,
    required this.polyline,
  });

  factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        distanceMeters: json["distanceMeters"],
        duration: json["duration"],
        polyline: Polyline.fromJson(json["polyline"]),
      );

  Map<String, dynamic> toJson() => {
        "distanceMeters": distanceMeters,
        "duration": duration,
        "polyline": polyline.toJson(),
      };
}

class Polyline {
  String encodedPolyline;

  Polyline({
    required this.encodedPolyline,
  });

  factory Polyline.fromRawJson(String str) => Polyline.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
        encodedPolyline: json["encodedPolyline"],
      );

  Map<String, dynamic> toJson() => {
        "encodedPolyline": encodedPolyline,
      };
}
