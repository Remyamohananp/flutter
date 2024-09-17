// To parse this JSON data, do
//
//     final barcodeProductModel = barcodeProductModelFromJson(jsonString);

import 'dart:convert';

BarcodeProductModel barcodeProductModelFromJson(String str) =>
    BarcodeProductModel.fromJson(json.decode(str));

String barcodeProductModelToJson(BarcodeProductModel data) =>
    json.encode(data.toJson());

class BarcodeProductModel {
  String itemcode;
  String barcode;
  String itemname;
  String categoryname;
  String qtype;
  String pcspertype;
  String cost;
  String sp;
  String custock;

  BarcodeProductModel({
    required this.itemcode,
    required this.barcode,
    required this.itemname,
    required this.categoryname,
    required this.qtype,
    required this.pcspertype,
    required this.cost,
    required this.sp,
    required this.custock,
  });

  factory BarcodeProductModel.fromJson(Map<String, dynamic> json) =>
      BarcodeProductModel(
        itemcode: json["itemcode"].toString(),
        barcode: json["barcode"].toString(),
        itemname: json["itemname"].toString(),
        categoryname: json["categoryname"].toString(),
        qtype: json["qtype"].toString(),
        pcspertype: json["pcspertype"].toString(),
        cost: json["cost"].toString(),
        sp: json["sp"].toString(),
        custock: json["custock"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "itemcode": itemcode,
        "barcode": barcode,
        "itemname": itemname,
        "categoryname": categoryname,
        "qtype": qtype,
        "pcspertype": pcspertype,
        "cost": cost,
        "sp": sp,
        "custock": custock
      };
}
