import 'package:medilink/utils/exporter.dart';

class CardModel {
  final String id;
  final String patient;
  final dynamic hospital;
  final List<RecordModel>? records;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? followup;
  final String opdNo;

  CardModel(
      {required this.id,
      required this.patient,
      required this.hospital,
      this.records,
      required this.createdAt,
      this.updatedAt,
      this.followup,
      required this.opdNo});

  CardModel copyWith(
          {required String id,
          required String patient,
          dynamic hospital,
          List<RecordModel>? records,
          required DateTime createdAt,
          DateTime? updatedAt,
          DateTime? followup,
          required String opdNo}) =>
      CardModel(
          id: id,
          patient: patient,
          hospital: hospital,
          records: records ?? this.records,
          createdAt: createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          followup: followup ?? this.followup,
          opdNo: opdNo);

  factory CardModel.fromRawJson(String str) =>
      CardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
      id: json["_id"],
      patient: json["patient"],
      hospital: json["hospital"] is String
          ? json["hospital"]
          : json["hospital"] != null
              ? Hospital.fromJson(json["hospital"])
              : null,
      records: json["records"] != null
          ? List<RecordModel>.from(
              json["records"].map((rec) => RecordModel.fromJson(rec)))
          : [],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      followup:
          json["followup"] == null ? null : DateTime.parse(json["followup"]),
      opdNo: json["opd_no"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "patient": patient,
        "hospital": hospital is Hospital ? hospital!.toJson() : hospital,
        "records": records == null
            ? []
            : List<Map<String, dynamic>>.from(records!.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "followup": followup?.toIso8601String(),
        "opd_no": opdNo
      };
}
