import 'package:meta/meta.dart';
import 'dart:convert';

class Bill {
    String id;
    int baseKmPrice;
    int baseMinutePrice;
    String createdAt;
    String updatedAt;

    Bill({
        required this.id,
        required this.baseKmPrice,
        required this.baseMinutePrice,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Bill.fromRawJson(String str) => Bill.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        baseKmPrice: json["base_km_price"],
        baseMinutePrice: json["base_minute_price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "base_km_price": baseKmPrice,
        "base_minute_price": baseMinutePrice,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
