// List<Grn>.from(json["grn"].map((x) => Grn.fromJson(x))),
List<Grv> grvss(List data) => List<Grv>.from(data.map((x) => Grv.fromJson(x)));

class Grv {
  int grvno;
  String grvdate;
  int vendorid;
  String grvref;
  String returnedby;
  String remark;

  Grv({
    required this.grvno,
    required this.grvdate,
    required this.vendorid,
    required this.grvref,
    required this.returnedby,
    required this.remark,
  });

  factory Grv.fromJson(Map<String, dynamic> json) => Grv(
        grvno: json["grvno"] ?? 0,
        grvdate: json["grvdate"] ?? "",
        vendorid: json["vendorid"] ?? 0,
        grvref: json["grvref"] ?? "",
            returnedby: json["returnedby"] ?? "",
          remark: json["remarkCtrl"] ?? "",
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
