import 'package:medilink/utils/exporter.dart';

class Hospital {
  final String? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? description;
  final String? image;
  final List<dynamic>? departments;
  final int? v;

  Hospital({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.description,
    this.image,
    this.departments,
    this.v,
  });

  Hospital copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? description,
    String? image,
    List<dynamic>? departments,
    int? v,
  }) =>
      Hospital(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        description: description ?? this.description,
        image: image ?? this.image,
        departments: departments ?? this.departments,
        v: v ?? this.v,
      );

  factory Hospital.fromRawJson(String str) =>
      Hospital.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        description: json["description"],
        image: json["image"],
        departments: json["departments"] != null
            ? json["departments"].map<dynamic>((dept) {
                if (dept is String) {
                  return dept; // It's an ID
                } else if (dept is Map<String, dynamic>) {
                  return Department.fromJson(
                      dept); // Convert to Department object
                }
                return null;
              }).toList()
            : [],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "description": description,
        "image": image,
        "departments": departments?.map((dept) {
              if (dept is String) {
                return dept; // Keep it as ID
              } else if (dept is Department) {
                return dept.toJson(); // Convert object to JSON
              }
              return null;
            }).toList() ??
            [],
        "__v": v,
      };
}
