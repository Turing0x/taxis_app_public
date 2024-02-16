import 'dart:convert';

GooglePolyline googlePolylineFromJson(String str) => GooglePolyline.fromJson(json.decode(str));

String googlePolylineToJson(GooglePolyline data) => json.encode(data.toJson());

class GooglePolyline {
  final List<Route> routes;

  GooglePolyline({
    required this.routes,
  });

  factory GooglePolyline.fromJson(Map<String, dynamic> json) => GooglePolyline(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class Route {
  final int distanceMeters;
  final String duration;
  final Polyline polyline;

  Route({
    required this.distanceMeters,
    required this.duration,
    required this.polyline,
  });

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
  final String encodedPolyline;

  Polyline({
    required this.encodedPolyline,
  });

  factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
        encodedPolyline: json["encodedPolyline"],
      );

  Map<String, dynamic> toJson() => {
        "encodedPolyline": encodedPolyline,
      };
}
