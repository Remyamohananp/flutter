// To parse this JSON data, do
//
//     final itemmasterModel = itemmasterModelFromJson(jsonString);

import 'dart:convert';

List<ItemmasterModel> itemmasterModelFromJson(List str) =>
    List<ItemmasterModel>.from(str.map((x) => ItemmasterModel.fromJson(x)));

String itemmasterModelToJson(List<ItemmasterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemmasterModel {
  String barcode;
  int itemcode;
  String barcodespecificname;
  double cashpriceaftertax;
  double creditpriceaftertax;
  double retailerpriceaftertax;
  int categoryid;
  String itemmastername;
  double cost;
  double whprice;
  double roqty;
  double pcspertype;
  String flag;
  String qtytype;

  ItemmasterModel({
    required this.barcode,
    required this.whprice,
    required this.itemcode,
    required this.barcodespecificname,
    required this.cashpriceaftertax,
    required this.creditpriceaftertax,
    required this.retailerpriceaftertax,
    required this.categoryid,
    required this.itemmastername,
    required this.cost,
    required this.roqty,
    required this.pcspertype,
    required this.flag,
    required this.qtytype,
  });

  factory ItemmasterModel.fromJson(Map<String, dynamic> json) =>
      ItemmasterModel(
        barcode: json["barcode"] ?? "",
        itemcode: json["itemcode"] ?? 0,
        barcodespecificname: json["barcodespecificname"] ?? "",
        cashpriceaftertax: json["cashpriceaftertax"].toDouble() ?? 0.0,
        creditpriceaftertax: json["creditpriceaftertax"] ?? 0.0,
        retailerpriceaftertax: json["retailerpriceaftertax"] ?? 0.0,
        categoryid: json["categoryid"] ?? 0,
        itemmastername: json["itemmastername"] ?? "",
        cost: json["cost"] ?? 0,
        roqty: json["roqty"] ?? 0,
        whprice: json["whprice"] ?? 0,
        pcspertype: json["pcspertype"] ?? 0,
        flag: json["flag"] ?? "",
        qtytype: json["qtytype"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "barcode": barcode,
        "itemcode": itemcode,
        "barcodespecificname": barcodespecificname,
        "cashpriceaftertax": cashpriceaftertax,
        "creditpriceaftertax": creditpriceaftertax,
        "retailerpriceaftertax": retailerpriceaftertax,
        "categoryid": categoryid,
        "itemmastername": itemmastername,
        "cost": cost,
        "roqty": roqty,
        "pcspertype": pcspertype,
        "flag": flag,
        "qtytype": qtytype,
      };
}
