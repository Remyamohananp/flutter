// To parse this JSON data, do
//
//     final poDetailsModel = poDetailsModelFromJson(jsonString);

import 'dart:convert';

List<PoDetailsModel> poDetailsModelFromJson(List str) =>
    List<PoDetailsModel>.from(str.map((x) => PoDetailsModel.fromJson(x)));

String poDetailsModelToJson(List<PoDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoDetailsModel {
  int pono;
  String barcode;
  int qty;
  double foc;
  double rate;

  PoDetailsModel({
    required this.pono,
    required this.barcode,
    required this.qty,
    required this.foc,
    required this.rate,
  });

  factory PoDetailsModel.fromJson(Map<String, dynamic> json) => PoDetailsModel(
        pono: json["pono"] ?? 0,
        barcode: json["barcode"] ?? "",
        qty: json["qty"].toInt() ?? 0,
        foc: json["foc"] != null
            ? json["foc"].toString().isNotEmpty
                ? double.parse(json["foc"].toString())
                : 0.0
            : 0.0,
        rate: json["rate"] != null
            ? json["rate"].toString().isNotEmpty
                ? double.parse(json["rate"].toString())
                : 0.0
            : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "pono": pono,
        "barcode": barcode,
        "qty": qty,
        "foc": foc,
        "rate": rate,
      };
}
