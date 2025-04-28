import 'dart:convert';

class Hosp {
  final String? id;
  final String? name;
  final List<Dep>? depSummary;
  final List<Dep>? departments;

  Hosp({
    this.id,
    this.name,
    this.depSummary,
    this.departments,
  });

  Hosp copyWith({
    String? id,
    String? name,
    List<Dep>? depSummary,
    List<Dep>? departments,
  }) =>
      Hosp(
        id: id ?? this.id,
        name: name ?? this.name,
        depSummary: depSummary ?? this.depSummary,
        departments: departments ?? this.departments,
      );

  factory Hosp.fromRawJson(String str) => Hosp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hosp.fromJson(Map<String, dynamic> json) => Hosp(
        id: json["_id"],
        name: json["name"],
        depSummary: json["DepSummary"] == null
            ? []
            : List<Dep>.from(json["DepSummary"]!.map((x) => Dep.fromJson(x))),
        departments: json["departments"] == null
            ? []
            : List<Dep>.from(json["departments"]!.map((x) => Dep.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "DepSummary": depSummary == null
            ? []
            : List<dynamic>.from(depSummary!.map((x) => x.toJson())),
        "departments": departments == null
            ? []
            : List<dynamic>.from(departments!.map((x) => x.toJson())),
      };
}

class Dep {
  final String? id;
  final String? name;
  final List<Doc>? doc;
  final List<Doc>? doctors;

  Dep({
    this.id,
    this.name,
    this.doc,
    this.doctors,
  });

  Dep copyWith({
    String? id,
    String? name,
    List<Doc>? doc,
    List<Doc>? doctors,
  }) =>
      Dep(
        id: id ?? this.id,
        name: name ?? this.name,
        doc: doc ?? this.doc,
        doctors: doctors ?? this.doctors,
      );

  factory Dep.fromRawJson(String str) => Dep.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dep.fromJson(Map<String, dynamic> json) => Dep(
        id: json["_id"],
        name: json["name"],
        doc: json["Doc"] == null
            ? []
            : List<Doc>.from(json["Doc"]!.map((x) => Doc.fromJson(x))),
        doctors: json["doctors"] == null
            ? []
            : List<Doc>.from(json["doctors"]!.map((x) => Doc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "Doc":
            doc == null ? [] : List<dynamic>.from(doc!.map((x) => x.toJson())),
        "doctors": doctors == null
            ? []
            : List<dynamic>.from(doctors!.map((x) => x.toJson())),
      };
}

class Doc {
  final String? id;
  final String? name;

  Doc({
    this.id,
    this.name,
  });

  Doc copyWith({
    String? id,
    String? name,
  }) =>
      Doc(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Doc.fromRawJson(String str) => Doc.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
