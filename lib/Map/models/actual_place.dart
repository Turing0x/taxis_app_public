import 'package:meta/meta.dart';
import 'dart:convert';

class ActualPlacesRespose {
    List<Result> results;

    ActualPlacesRespose({
        required this.results,
    });

    factory ActualPlacesRespose.fromRawJson(String str) => ActualPlacesRespose.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ActualPlacesRespose.fromJson(Map<String, dynamic> json) => ActualPlacesRespose(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    List<AddressComponent> addressComponents;
    String formattedAddress;
    Geometry geometry;
    String placeId;
    List<String> types;

    Result({
        required this.addressComponents,
        required this.formattedAddress,
        required this.geometry,
        required this.placeId,
        required this.types,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"],
        types: List<String>.from(json["types"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
        "place_id": placeId,
        "types": List<dynamic>.from(types.map((x) => x)),
    };
}

class AddressComponent {
    String longName;
    String shortName;
    List<String> types;

    AddressComponent({
        required this.longName,
        required this.shortName,
        required this.types,
    });

    factory AddressComponent.fromRawJson(String str) => AddressComponent.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
    };
}

class Geometry {
    Location location;
    String locationType;
    Viewport viewport;

    Geometry({
        required this.location,
        required this.locationType,
        required this.viewport,
    });

    factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        locationType: json["location_type"],
        viewport: Viewport.fromJson(json["viewport"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "location_type": locationType,
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
