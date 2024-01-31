import 'package:meta/meta.dart';
import 'dart:convert';

class DynamicFees {
    String id;
    String date;
    int increaseKmPercentage;
    int increaseMinPercentage;
    String createdAt;
    String updatedAt;

    DynamicFees({
        required this.id,
        required this.date,
        required this.increaseKmPercentage,
        required this.increaseMinPercentage,
        required this.createdAt,
        required this.updatedAt,
    });

    factory DynamicFees.fromRawJson(String str) => DynamicFees.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DynamicFees.fromJson(Map<String, dynamic> json) => DynamicFees(
        id: json["id"],
        date: json["date"],
        increaseKmPercentage: json["increaseKmPercentage"],
        increaseMinPercentage: json["increaseMinPercentage"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "increaseKmPercentage": increaseKmPercentage,
        "increaseMinPercentage": increaseMinPercentage,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
