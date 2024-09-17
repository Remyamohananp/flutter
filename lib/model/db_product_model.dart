List<DBPRoductModel> chatModelFromJson(List str) =>
    str.map((e) => DBPRoductModel.fromJson(e)).toList();

//  str..map((x) =>DBPRoductModel.fromJson(x)).toList();

// List<Message>.from(
//             json["messages"].map((x) => Message.fromJson(x))),
class DBPRoductModel {
  int id;
  int barcode;
  int stock;
  int sajno;
  double pcspertype;
  double sprice;
  String itemcode;
  String itemname;
  String qtytype;
  String category;
  String flag;
  DBPRoductModel({
    required this.pcspertype,
    required this.barcode,
    required this.sajno,
    required this.flag,
    required this.category,
    required this.id,
    required this.itemcode,
    required this.itemname,
    required this.qtytype,
    required this.sprice,
    required this.stock,
  });

  factory DBPRoductModel.fromJson(Map<String, dynamic> json) => DBPRoductModel(
      id: json["id"] ?? 0,
      barcode: json["barcode"] ?? 0,
      category: json["category"] ?? "",
      flag: json["flag"] ?? "",
      itemcode: json["itemcode"] ?? "",
      itemname: json["itemname"] ?? "",
      qtytype: json["qtytype"] ?? "",
      sprice: json["sprice"] ?? 0.0,
      sajno: json["sajno"] ?? 0,
      stock: json["stock"] ?? 0,
      pcspertype: json["pcspertype"] ?? 0.0);
}
