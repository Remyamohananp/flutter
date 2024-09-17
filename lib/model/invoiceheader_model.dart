//
// List<InvoiceHeader> invoice(List data) => List<InvoiceHeader>.from(data.map((x) => InvoiceHeader.fromJson(x)));
//
// class InvoiceHeader {
//   int invoiceno;
//   String invoicedate;
//   int customerid;
//   String invoicetype;
//   int lpono;
//   int storecode;
//   double invoiceamount;
//   double taxamount;
//   double discount;
//   double paidamount;
//   String duedate;
//   InvoiceHeader({
//     required this.invoiceno,
//     required this.invoicedate,
//     required this.customerid,
//     required this.invoicetype,
//     required this.lpono,
//     required this.storecode,
//     required this.invoiceamount,
//     required this.taxamount,
//     required this.discount,
//     required this.paidamount,
//     required this.duedate,
//     required this.storecode,
//   });
//
//   factory InvoiceHeader.fromJson(Map<String, dynamic> json) => InvoiceHeader(
//     invoiceno: json["invoiceno"] ?? 0,
//     invoicedate: json["invoicedate"] ?? "",
//     customerid: json["customerid"] ?? 0,
//     invoicetype: json["invoicetype"] ?? "",
//     lpono: json["lpono"] ??  0,
//     storecode: json["storecode"] ??  0,
//     invoiceamount: json["invoiceamount"] ?? 0.0,
//     taxamount: json["taxamount"] ?? 0.0,
//     discount: json["discount"] ?? 0.0,
//     paidamount: json["paidamount"] ?? 0.0,
//     duedate: json["duedate"] ??  "",
//     storecode: json["ivtime"] ??  0,
//       );
//   Map<String, dynamic> toJson() => {
//     'invoiceno': invoiceno,
//     'invoicedate': invoicedate,
//     'customerid': customerid,
//     "invoicetype": invoicetype,
//     "lpono": lpono,
//     'storecode': storecode,
//     'invoiceamount': invoiceamount,
//     'taxamount': taxamount,
//     "discount": discount,
//     "paidamount": paidamount,
//     "duedate": duedate,
//     'ivtime': ivtime,
//     'cashtendered': cashtendered,
//     'status': status,
//     "reason": reason,
//     "crlogin": crlogin,
//     "crdate": crdate,
//     'totaldiscount': totaldiscount,
//     'specificname': specificname,
//     'trn': trn,
//     "salesource": salesource,
//     "companycode": companycode,
//     "salesman": salesman,
//     "ivseries": ivseries
//   };
// }
