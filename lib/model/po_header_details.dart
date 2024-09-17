// To parse this JSON data, do
//
//     final poHeaderModel = poHeaderModelFromJson(jsonString);

import 'dart:convert';

List<PoHeaderModel> poHeaderModelFromJson(List str) =>
    List<PoHeaderModel>.from(str.map((x) => PoHeaderModel.fromJson(x)));

String poHeaderModelToJson(List<PoHeaderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoHeaderModel {
  int pono;
  String podate;
  int vendorid;
  String remark;
  String enteredby;

  PoHeaderModel({
    required this.pono,
    required this.podate,
    required this.vendorid,
    required this.remark,
    required   this.enteredby
  });

  factory PoHeaderModel.fromJson(Map<String, dynamic> json) => PoHeaderModel(
        pono: json["pono"] ?? 0,
        podate: json["podate"] ?? "",
        vendorid: json["vendorid"] ?? 0,
    remark: json["remark"] ?? "",
    enteredby: json["enteredby"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "pono": pono,
        "podate": podate,
        "vendorid": vendorid,
    "remark": remark,
    "enteredby": enteredby,
      };
}
