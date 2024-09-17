// To parse this JSON data, do
//
//     final onlineProductModel = onlineProductModelFromJson(jsonString);

import 'dart:convert';

List<OnlineProductModel> onlineProductModelFromJson(String str) =>
    List<OnlineProductModel>.from(
        json.decode(str).map((x) => OnlineProductModel.fromJson(x)));

List<OnlineProductModel> onlineProductModelFromList(List data) =>
    List<OnlineProductModel>.from(
        data.map((x) => OnlineProductModel.fromJson(x)));

String onlineProductModelToJson(List<OnlineProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnlineProductModel {
  String itemcode;
  String mastername;
  String barcode;
  String qtyyype;
  String categoryname;
  int qty;
  double price;
  int addQty;
  int replaceQty;
  String adjtype;
  int sajno;
  double pcspertype;

  OnlineProductModel({
    required this.itemcode,
    required this.mastername,
    required this.barcode,
    required this.qtyyype,
    required this.categoryname,
    required this.qty,
    required this.addQty,
    required this.replaceQty,
    required this.adjtype,
    required this.sajno,
    required this.price,
    required this.pcspertype,
  });

  factory OnlineProductModel.fromJson(Map<String, dynamic> json) =>
      OnlineProductModel(
        itemcode: json["itemcode"] == null ? "" : json["itemcode"].toString(),
        price: json["cashPrice"] == null ? 0.0 : json["cashPrice"].toDouble(),
        mastername: json["mastername"] ?? "",
        barcode: json["barcode"] ?? "",
        qtyyype: json["qtyyype"] ?? "",
        categoryname: json["categoryname"] ?? "",
        qty: json["qty"] ?? 0,
        addQty: json["addQTY"] ?? 0,
        replaceQty: json["replaceQTY"] ?? 0,
        adjtype: json["adjtype"] ?? "",
        sajno: json["sajno"] ?? 0,
        pcspertype: json["pcspertype"].toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "itemcode": itemcode,
        "mastername": mastername,
        "barcode": barcode,
        "qtyyype": qtyyype,
        "categoryname": categoryname,
        "qty": qty,
        "addQTY": addQty,
        "replaceQTY": replaceQty,
        "adjtype": adjtype,
        "sajno": sajno,
        "pcspertype": pcspertype,
      };
}
