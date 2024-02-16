import 'dart:convert';

class FindPlacesRespose {
  List<Candidate> candidates;
  String status;

  FindPlacesRespose({
    required this.candidates,
    required this.status,
  });

  factory FindPlacesRespose.fromRawJson(String str) => FindPlacesRespose.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FindPlacesRespose.fromJson(Map<String, dynamic> json) => FindPlacesRespose(
        candidates: List<Candidate>.from(json["candidates"].map((x) => Candidate.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
        "status": status,
      };
}

class Candidate {
  String formattedAddress;
  Geometry geometry;

  Candidate({
    required this.formattedAddress,
    required this.geometry,
  });

  factory Candidate.fromRawJson(String str) => Candidate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
      };
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  factory Viewport.fromRawJson(String str) => Viewport.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}
