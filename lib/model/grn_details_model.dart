List<GrnDetail> grnDetails(List data) =>
    List<GrnDetail>.from(data.map((x) => GrnDetail.fromJson(x)));

class GrnDetail {
  int grnno;
  String barcode;
  int qty;
  double foc;
  double cost;

  GrnDetail(
      {required this.grnno,
      required this.barcode,
      required this.qty,
      required this.foc,
      required this.cost});

  factory GrnDetail.fromJson(Map<String, dynamic> json) => GrnDetail(
      grnno: json["grnno"] ?? 0,
      barcode: json["barcode"] ?? "",
      qty: json["qty"].toInt() ?? 0,
      foc: json["foc"].toDouble() ?? 0.0,
      cost: json["cost"] ?? 0.0);

  Map<String, dynamic> toJson() => {
        "grnno": grnno,
        "barcode": barcode,
        "qty": qty,
        "foc": foc,
      };
}
