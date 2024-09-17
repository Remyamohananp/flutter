// List<Grn>.from(json["grn"].map((x) => Grn.fromJson(x))),
List<Grn> grnss(List data) => List<Grn>.from(data.map((x) => Grn.fromJson(x)));

class Grn {
  int grnno;
  String grndate;
  int vendorid;
  String grnref;
  String recievedby;
  String ponumber;

  Grn({
    required this.grnno,
    required this.grndate,
    required this.vendorid,
    required this.grnref,
    required this.recievedby,
    required this.ponumber,
  });

  factory Grn.fromJson(Map<String, dynamic> json) => Grn(
        grnno: json["grnno"] ?? 0,
        grndate: json["grndate"] ?? "",
        vendorid: json["vendorid"] ?? 0,
        grnref: json["grnref"] ?? "",
        recievedby: json["recievedby"] ?? "",
        ponumber: json["ponumber"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //     "grnno": grnno,
  //     "grndate": grndate.toIso8601String(),
  //     "vendorid": vendorid,
  //     "grnref": grnref,
  //     "recievedby": recievedby,
  //     "ponumber": ponumber,
  // };
}
