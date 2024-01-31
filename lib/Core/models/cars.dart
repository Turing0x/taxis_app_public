import 'package:meta/meta.dart';
import 'dart:convert';

class Car {
    String id;
    String brand;
    String model;
    String licensePlate;
    String owner;
    String color;
    String picture;
    String createdAt;
    String updatedAt;

    Car({
        required this.id,
        required this.brand,
        required this.model,
        required this.licensePlate,
        required this.owner,
        required this.color,
        required this.picture,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        brand: json["brand"],
        model: json["model"],
        licensePlate: json["license_plate"],
        owner: json["owner"],
        color: json["color"],
        picture: json["picture"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "model": model,
        "license_plate": licensePlate,
        "owner": owner,
        "color": color,
        "picture": picture,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
