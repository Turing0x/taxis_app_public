import 'dart:convert';

DriverModel driverModelFromJson(String str) => DriverModel.fromJson(json.decode(str));

String driverModelToJson(DriverModel data) => json.encode(data.toJson());

class DriverModel {
  final String name;
  final String email;
  final String username;
  final String password;
  final String type;
  final DriverInfo driverInfo;

  DriverModel({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.type,
    required this.driverInfo,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        username: json["username"] ?? '',
        password: json["password"] ?? '',
        type: json["type"] ?? '',
        driverInfo: DriverInfo.fromJson(json["driver_info"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "username": username,
        "password": password,
        "type": type,
        "driver_info": driverInfo.toJson(),
      };
}

class DriverInfo {
  final String driverLicence;
  final String circulationLicence;
  final String dni;

  DriverInfo({
    required this.driverLicence,
    required this.circulationLicence,
    required this.dni,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) => DriverInfo(
        driverLicence: json["driver_licence"],
        circulationLicence: json["circulation_licence"],
        dni: json["dni"],
      );

  Map<String, dynamic> toJson() => {
        "driver_licence": driverLicence,
        "circulation_licence": circulationLicence,
        "dni": dni,
      };
}
