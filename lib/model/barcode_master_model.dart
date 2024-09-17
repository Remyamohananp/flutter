List<BarcodeMaster> getBarcodeMaster(List data) =>
    List<BarcodeMaster>.from(data.map((x) => BarcodeMaster.fromJson(x)));

class BarcodeMaster {
  String barcode;
  String barcodespecificname;
  double cashpriceaftertax;
  double creditpriceaftertax;
  double retailerpriceaftertax;
  int categoryid;
  String itemmastername;
  String itemcode;

  BarcodeMaster({
    required this.barcode,
    required this.barcodespecificname,
    required this.itemcode,
    required this.cashpriceaftertax,
    required this.creditpriceaftertax,
    required this.retailerpriceaftertax,
    required this.categoryid,
    required this.itemmastername,
  });

  factory BarcodeMaster.fromJson(Map<String, dynamic> json) => BarcodeMaster(
        barcode: json["barcode"],
        barcodespecificname: json["barcodespecificname"],
        cashpriceaftertax: json["cashpriceaftertax"].toDouble(),
        creditpriceaftertax: json["creditpriceaftertax"].toDouble(),
        retailerpriceaftertax: json["retailerpriceaftertax"].toDouble(),
        categoryid: json["categoryid"],
        itemmastername: json["itemmastername"],
        itemcode: json["itemcode"].toString(),
        // itemcode: json["ItemCode"],
      );

  Map<String, dynamic> toJson() => {
        "barcode": barcode,
        "barcodespecificname": barcodespecificname,
        "cashpriceaftertax": cashpriceaftertax,
        "creditpriceaftertax": creditpriceaftertax,
        "retailerpriceaftertax": retailerpriceaftertax,
        "categoryid": categoryid,
        "itemmastername": itemmastername,
      };
}
