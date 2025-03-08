import '../../../utils/exporter.dart';

class Schedule {
  final String? id;
  final String? day;
  final String? startTime;
  final String? endTime;
  final bool? isAvailable;
  final String? doctor;
  final int? v;

  Schedule({
    this.id,
    this.day,
    this.startTime,
    this.endTime,
    this.isAvailable,
    this.doctor,
    this.v,
  });

  Schedule copyWith({
    String? id,
    String? day,
    String? startTime,
    String? endTime,
    bool? isAvailable,
    String? doctor,
    int? v,
  }) =>
      Schedule(
        id: id ?? this.id,
        day: day ?? this.day,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        isAvailable: isAvailable ?? this.isAvailable,
        doctor: doctor ?? this.doctor,
        v: v ?? this.v,
      );

  factory Schedule.fromRawJson(String str) =>
      Schedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["_id"],
        day: json["day"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        isAvailable: json["isAvailable"],
        doctor: json["doctor"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "day": day,
        "startTime": startTime,
        "endTime": endTime,
        "isAvailable": isAvailable,
        "doctor": doctor,
        "__v": v,
      };
}
