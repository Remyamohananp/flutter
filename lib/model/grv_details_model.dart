List<GrvDetail> grvDetails(List data) =>
    List<GrvDetail>.from(data.map((x) => GrvDetail.fromJson(x)));

class GrvDetail {
  int grvno;
  String barcode;
  int qty;
  String reason;
  double cost;

  GrvDetail(
      {required this.grvno,
      required this.barcode,
      required this.qty,
      required this.reason,
      required this.cost});

  factory GrvDetail.fromJson(Map<String, dynamic> json) => GrvDetail(
      grvno: json["grvno"] ?? 0,
      barcode: json["barcode"] ?? "",
      qty: json["qty"].toInt() ?? 0,
      reason: json["reason"]?? "",
      cost: json["cost"] ?? 0.0);

  Map<String, dynamic> toJson() => {
        "grvno": grvno,
        "barcode": barcode,
        "qty": qty,
        "reason": reason,
      };
}
