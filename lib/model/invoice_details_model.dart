List<InvoiceDetail> invoiceDetails(List data) =>
    List<InvoiceDetail>.from(data.map((x) => InvoiceDetail.fromJson(x)));

class InvoiceDetail {
  int invoiceno;
  String barcode;
  int qty;
  double rate;
  double cost;
  double foc;
  String itemname;
  String qtytype;
  double discper;
  double discount;
  double tbt;
  double taxper;
  double tax;
  String batch;
  String expiry;
  String serial;
  String status;
  String returnflag;
  String crlogin;
  String crdate;
  String salesource;
  int companycode;
  String ivid;
  String ivseries;
  InvoiceDetail(
      {required this.invoiceno,
      required this.barcode,
      required this.qty,
      required this.rate,
      required this.cost,
        required this.foc,
        required this.itemname,
        required this.qtytype,
        required this.discper,
        required this.discount,
        required this.tbt,
        required this.taxper,
        required this.tax,
        required this.batch,
        required this.expiry,
        required this.serial,
        required this.status,
        required this.returnflag,
        required this.crlogin,
        required this.crdate,
        required this.salesource,
        required this.companycode,
        required this.ivid,
        required this.ivseries

      });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
      invoiceno: json["invoiceno"] ?? 0,
      barcode: json["barcode"] ?? "",
      qty: json["qty"].toInt() ?? 0,
      rate: json["rate"] != null
          ? json["rate"].toString().isNotEmpty
          ? double.parse(json["rate"].toString())
          : 0.0
          : 0.0,

      cost: json["cost"] ?? 0.0,
      foc: json["foc"] != null
         ? json["foc"].toString().isNotEmpty
         ? double.parse(json["foc"].toString())
         : 0.0
        : 0.0,
      itemname: json["itemname"] ?? "",
      qtytype: json["qtytype"] ?? "",

         discper: json["discper"] != null
          ? json["discper"].toString().isNotEmpty
          ? double.parse(json["discper"].toString())
          : 0.0
          : 0.0,
      discount: json["discount"] != null
          ? json["discount"].toString().isNotEmpty
          ? double.parse(json["discount"].toString())
          : 0.0
          : 0.0,

      tbt: json["tbt"].toInt() ?? 0,
      taxper: json["taxper"] ?? 0.0,
      tax: json["tax"].toInt() ?? 0.0,
      batch: json["batch"]?? "",
      expiry: json["expiry"] ?? "",
      serial: json["serial"]?? "",
      status: json["status"]?? "",
      returnflag: json["returnflag"]?? "",
      crlogin:json["crlogin"]??"",
      crdate: json["crdate"]?? "",
      salesource: json["salesource"]?? "",
      companycode: json["companycode"] ?? 0,
      ivid: json[" ivid"]?? "",
      ivseries: json["ivseries"] ??"");

  Map<String, dynamic> toJson() => {
    'invoiceno': invoiceno,
    'barcode': barcode,
    'itemname': itemname,
    'qtytype': qtytype,
    "qty": qty,
    'foc': foc,
    'rate': rate,
    'cost': cost,
    'discper': discper,
    'discount': discount,
    'tbt': tbt,
    'taxper': taxper,
    'tax': tax,
    'batch': batch,
    'expiry': expiry,
    'serial': serial,
    'status': status,
    'returnflag': returnflag,
    'crlogin': crlogin,
    'crdate': crdate,
    'salesource': salesource,
    'companycode': companycode,
    'ivid': ivid,
    'ivseries': ivseries,

  };
}
