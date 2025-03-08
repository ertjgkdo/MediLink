import '../../../utils/exporter.dart';

class Doctor {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? title;
  final String? depId;
  final List<dynamic>? schedule;
  final String? role;
  final String? image;

  Doctor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.title,
    this.depId,
    this.schedule,
    this.role,
    this.image,
  });

  Doctor copyWith(
          {String? id,
          String? name,
          String? email,
          String? phone,
          String? title,
          String? depId,
          List<dynamic>? schedule,
          String? role,
          String? image}) =>
      Doctor(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        title: title ?? this.title,
        depId: depId ?? this.depId,
        schedule: schedule ?? this.schedule,
        role: role ?? this.role,
        image: image ?? this.image,
      );

  factory Doctor.fromRawJson(String str) => Doctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        title: json["title"],
        depId: json["dep_id"],
        schedule: json["schedule"] != null
            ? json["schedule"].map<dynamic>((sched) {
                if (sched is String) {
                  return sched;
                } else if (sched is Map<String, dynamic>) {
                  return Schedule.fromJson(sched);
                }
                return null;
              }).toList()
            : [],
        role: json["role"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "title": title,
        "dep_id": depId,
        "schedule": schedule?.map((sched) {
              if (sched is String) {
                return sched;
              } else if (sched is Schedule) {
                return sched.toJson();
              }
              return null;
            }).toList() ??
            [],
        "role": role,
        "image": image,
      };
}
