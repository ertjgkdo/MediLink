import '../../../utils/exporter.dart';

class RecordModel {
  final String id;
  final String opdId;
  final dynamic department;
  final dynamic doctor;
  final DateTime visitdate;
  final String time;
  final String? chiefcomplain;
  final String? examination;
  final String? diagnosis;
  final Vitals? vitals;
  final List<Prescription>? prescription;
  final DateTime? followup;

  RecordModel(
      {required this.id,
      required this.opdId,
      required this.department,
      required this.doctor,
      required this.visitdate,
      required this.time,
      this.chiefcomplain,
      this.examination,
      this.diagnosis,
      this.vitals,
      this.prescription,
      this.followup});

  RecordModel copyWith(
          {required String id,
          required String opdId,
          required dynamic department,
          required dynamic doctor,
          required DateTime visitdate,
          required String time,
          String? chiefcomplain,
          String? examination,
          String? diagnosis,
          Vitals? vitals,
          List<Prescription>? prescription,
          DateTime? followup}) =>
      RecordModel(
          id: this.id,
          opdId: this.opdId,
          department: this.department,
          doctor: this.doctor,
          visitdate: this.visitdate,
          time: this.time,
          chiefcomplain: chiefcomplain ?? this.chiefcomplain,
          examination: examination ?? this.examination,
          diagnosis: diagnosis ?? this.diagnosis,
          vitals: vitals ?? this.vitals,
          prescription: prescription ?? this.prescription,
          followup: followup ?? this.followup);

  factory RecordModel.fromRawJson(String str) =>
      RecordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        id: json["_id"],
        opdId: json["opd_id"],
        department: json["department"] is String
            ? json["department"]
            : json["department"] != null
                ? Department.fromJson(json["department"])
                : null,
        doctor: json["doctor"] is String
            ? json["doctor"]
            : json["doctor"] != null
                ? Doctor.fromJson(json["doctor"])
                : null,
        visitdate: DateTime.parse(json["visitdate"]),
        time: json["time"],
        chiefcomplain: json["chiefcomplain"] ?? "",
        examination: json["examination"] ?? "",
        diagnosis: json["diagnosis"] ?? "",
        vitals: json["vitals"] != null ? Vitals.fromJson(json["vitals"]) : null,
        prescription: json["prescription"] == null
            ? []
            : List<Prescription>.from(
                json["prescription"]!.map((x) => Prescription.fromJson(x))),
        followup:
            json["followup"] == null ? null : DateTime.parse(json["followup"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "opd_id": opdId,
        "department":
            department is Department ? department!.toJson() : department,
        "doctor": doctor is Doctor ? doctor!.toJson() : doctor,
        "visitdate": visitdate.toIso8601String(),
        "time": time,
        "chiefcomplain": chiefcomplain,
        "examination": examination,
        "diagnosis": diagnosis,
        "vitals": vitals!.toJson(),
        "prescription": prescription == null
            ? []
            : List<dynamic>.from(prescription!.map((x) => x.toJson())),
        "followup": followup?.toIso8601String()
      };
}

class Vitals {
  final String? bp;
  final String? temp;
  final String? wt;
  final String? ht;

  Vitals({this.bp, this.temp, this.wt, this.ht});

  Vitals copyWith({String? bp, String? temp, String? wt, String? ht}) => Vitals(
      bp: bp ?? this.bp,
      temp: temp ?? this.temp,
      wt: wt ?? this.wt,
      ht: ht ?? this.ht);
  factory Vitals.fromRawJson(String str) => Vitals.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vitals.fromJson(Map<String, dynamic> json) => Vitals(
      bp: json["bp"], temp: json["temp"], wt: json["wt"], ht: json["ht"]);

  Map<String, dynamic> toJson() => {"bp": bp, "temp": temp, "wt": wt, "ht": ht};
}

class Prescription {
  final String? id;
  final String? medicine;
  final String? duration;
  final String? instruction;

  Prescription({this.id, this.medicine, this.duration, this.instruction});

  Prescription copyWith(
          {String? id,
          String? medicine,
          String? duration,
          String? instruction}) =>
      Prescription(
          id: id ?? this.id,
          medicine: medicine ?? this.medicine,
          duration: duration ?? this.duration,
          instruction: instruction ?? this.instruction);

  factory Prescription.fromRawJson(String str) =>
      Prescription.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
      id: json["_id"],
      medicine: json["medicine"],
      duration: json["duration"],
      instruction: json["instruction"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "medicine": medicine,
        "duration": duration,
        "instruction": instruction
      };
}
