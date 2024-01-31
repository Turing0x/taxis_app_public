import 'package:meta/meta.dart';
import 'dart:convert';

class User {
    String id;
    String name;
    String email;
    String username;
    String type;
    String createdAt;
    String updatedAt;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.username,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        type: json["type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "type": type,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
