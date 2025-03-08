import 'package:medilink/utils/exporter.dart';

class Department {
  final String? id;
  final String? name;
  final String? description;
  final String? phone;
  final String? hospital;
  final List<dynamic>? doctors;

  Department({
    this.id,
    this.name,
    this.description,
    this.phone,
    this.hospital,
    this.doctors,
  });

  Department copyWith({
    String? id,
    String? name,
    String? description,
    String? phone,
    String? hospital,
    List<dynamic>? doctors,
  }) =>
      Department(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        phone: phone ?? this.phone,
        hospital: hospital ?? this.hospital,
        doctors: doctors ?? this.doctors,
      );

  factory Department.fromRawJson(String str) =>
      Department.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        phone: json["phone"],
        hospital: json["hospital"],
        doctors: json["doctors"] != null
            ? json["doctors"].map<dynamic>((doc) {
                if (doc is String) {
                  return doc;
                } else if (doc is Map<String, dynamic>) {
                  return Doctor.fromJson(doc);
                }
                return null;
              }).toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "phone": phone,
        "hospital": hospital,
        "doctors": doctors?.map((doc) {
              if (doc is String) {
                return doc;
              } else if (doc is Department) {
                return doc.toJson();
              }
              return null;
            }).toList() ??
            [],
      };
}
