import '../../../utils/exporter.dart';

class Slot {
  final String? id;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final bool? isBooked;
  final dynamic doctor;
  final int? v;

  Slot({
    this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.isBooked,
    this.doctor,
    this.v,
  });

  Slot copyWith({
    String? id,
    DateTime? date,
    String? startTime,
    String? endTime,
    bool? isBooked,
    dynamic doctor,
    int? v,
  }) =>
      Slot(
        id: id ?? this.id,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        isBooked: isBooked ?? this.isBooked,
        doctor: doctor ?? this.doctor,
        v: v ?? this.v,
      );

  factory Slot.fromRawJson(String str) => Slot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        isBooked: json["isBooked"],
        doctor: json["doctor"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date?.toIso8601String(),
        "startTime": startTime,
        "endTime": endTime,
        "isBooked": isBooked,
        "doctor": doctor,
        "__v": v,
      };
}
