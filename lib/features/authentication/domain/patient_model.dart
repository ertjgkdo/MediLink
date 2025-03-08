// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

class Patient {
  final String name;
  final String? email;
  final String phone;
  final DateTime? dob;
  final String? address;
  final String? gender;
  final String? bloodGroup;
  final String password;
  final String role;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? token;

  Patient({
    required this.name,
    this.email,
    required this.phone,
    this.dob,
    this.address,
    this.gender,
    this.bloodGroup,
    required this.password,
    this.role = "general_user",
    this.id,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  Patient copyWith({
    String? name,
    String? email,
    String? phone,
    DateTime? dob,
    String? address,
    String? gender,
    String? bloodGroup,
    String? password,
    String? role,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) =>
      Patient(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        dob: dob ?? this.dob,
        address: address ?? this.address,
        gender: gender ?? this.gender,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        password: password ?? this.password,
        role: role ?? this.role,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        token: token ?? this.token,
      );
  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String patientToJson(Patient data) => json.encode(data.toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["patient"]["_id"],
        name: json["patient"]["name"] ?? "",
        email: json["patient"]["email"] ?? "",
        phone: json["patient"]["phone"] ?? "",
        dob: json["patient"]["dob"] == null
            ? null
            : DateTime.parse(json["patient"]["dob"]),
        address: json["patient"]["address"],
        gender: json["patient"]["gender"] ?? "",
        bloodGroup: json["patient"]["bloodGroup"] ?? "",
        password: json["patient"]["password"] ?? "",
        role: json["patient"]["role"] ?? "general_user",
        createdAt: json["patient"]["createdAt"] == null
            ? null
            : DateTime.parse(json["patient"]["createdAt"]),
        updatedAt: json["patient"]["updatedAt"] == null
            ? null
            : DateTime.parse(json["patient"]["updatedAt"]),
        token: json["token"], // Extract token from root level
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob?.toIso8601String(),
        "address": address,
        "gender": gender,
        "bloodGroup": bloodGroup,
        "password": password,
        "role": role,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "token": token,
      };
}
