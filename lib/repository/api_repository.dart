import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/model/barcode_master_model.dart';
import 'package:qr_scanner/model/barcode_product_model.dart';
import 'package:qr_scanner/model/db_product_model.dart';
import 'package:qr_scanner/model/grn_details_model.dart';
import 'package:qr_scanner/model/item_master_model.dart';
import 'package:qr_scanner/model/online_product_model.dart';
import 'package:qr_scanner/model/po_details_model.dart';
import 'package:qr_scanner/model/po_header_details.dart';
import 'package:qr_scanner/model/product_model.dart';
import 'package:qr_scanner/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/grn_model.dart';
import '../model/grv_details_model.dart';
import '../model/grv_model.dart';

class ApiRepository {
  Map<String, String> headers = {"Content-type": "application/json"};
  // addproduct(
  //     {required String itemCode,
  //     required String masterName,
  //     required String barcode,
  //     required String adjtype,
  //     required String categry,
  //     required String qty,
  //     required String sajno,
  //     required BuildContext context,
  //     required String qtyyype}) async {
  //   try {
  //     SharedPreferences sp = await SharedPreferences.getInstance();
  //     String? ip = sp.getString(
  //       "ip",
  //     );
  //     if (ip != null) {
  //       Map params = {
  //         "itemcode": itemCode,
  //         "mastername": masterName,
  //         "barcode": barcode,
  //         "qtyyype": qtyyype,
  //         "categoryname": categry,
  //         "qty": qty,
  //         "addQTY": 0,
  //         "replaceQTY": 0,
  //         "adjtype": adjtype,
  //         "sajno": sajno
  //       };

  //       log(params.toString(), name: "error");
  //       // var res = await http.post(Uri.parse("http://10.0.2.2:7058/api/Product"),
  //       //     headers: headers, body: jsonEncode(params));
  //       var res = await http.post(Uri.parse("$ip/api/Product"),
  //           headers: headers, body: jsonEncode(params));
  //       log("$ip/api/Product");
  //       log(res.body.toString());
  //       log(res.statusCode.toString());
  //       if (res.statusCode == 200) {
  //         log(res.body.toString(), name: "body");
  //         var body = res.body;
  //         // var body = jsonDecode(res.body);
  //         if (body.toString().trim().toLowerCase() == "updated") {
  //           return {
  //             "status": "success",
  //           };
  //         } else {
  //           return {"status": "failed", "message": "!404"};
  //         }
  //       } else {
  //         return {"status": "failed", "message": "!200"};
  //       }
  //     } else {
  //       showSnackbar("Ip address not configured", context);
  //     }
  //   } catch (e) {
  //     log(e.toString(), name: "errorrrr");
  //     return {"status": "failed", "message": "some server error occured"};
  //   }
  // }

  // //********************************************* */
  // getProductDetails({
  //   required String barcode,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     SharedPreferences sp = await SharedPreferences.getInstance();
  //     String? ip = sp.getString(
  //       "ip",
  //     );
  //     if (ip != null) {
  //       var res = await http.get(Uri.parse("$ip/api/Product/${barcode}"),
  //           // Uri.parse("https://localhost:7058/api/Product/${barcode}"),
  //           headers: headers);
  //       log("$ip/api/Product");

  //       log(res.body.toString());
  //       log(res.statusCode.toString());
  //       if (res.statusCode == 200) {
  //         log(res.body.toString(), name: "body");
  //         var body = jsonDecode(res.body);
  //         if (body != null) {
  //           OnlineProductModel product = OnlineProductModel.fromJson(body);
  //           return {"status": "success", "message": product};
  //         } else {
  //           return {"status": "failed", "message": "!404"};
  //         }
  //         // if (body == "Saved" || body == "updated") {
  //         //   return {
  //         //     "status": "success",
  //         //   };
  //         // } else {
  //         //   return {"status": "failed", "message": "!404"};
  //         // }
  //       } else {
  //         return {"status": "failed", "message": "!200"};
  //       }
  //     } else {
  //       showSnackbar("Ip address not configured", context);
  //     }
  //   } catch (e) {
  //     log(e.toString(), name: "errorrrr");
  //     return {"status": "failed", "message": "some server error occured"};
  //   }
  // }

  //8*****************************************
  uploadAllData(
      {required BuildContext context,
      required DB database,
      required bool isBarcodePrint,
      required Map? barcodePrint,
      required int flag}) async {
    try {
      //****************************** get ip address */
      // SharedPreferences sp = await SharedPreferences.getInstance();
      // String? ip = sp.getString(
      //   "ip",
      // );
      // String? terminal = sp.getString(
      //   "terminal",
      // );
      // log(ip ?? "null");
      List storedata = await database.getAllstoredata();

      if (storedata.isNotEmpty && storedata.last["ip"] != null) {
        String ip = storedata.last["ip"] ?? "";
        String terminal = storedata.last["terminal"] ?? "";
        //********* get all data from local database */
        // List datas = await database.getAllDataFromDB();
        List grns = await database.getAllGrn();
        List grnDetail = await database.getAllGrnDetails();
        List grvs = await database.getAllGrv();
        List grvDetail = await database.getAllGrvDetails();
        List poDetail = await database.getAllPoDetails();
        List poHeader = await database.getAllpoheader();
        // List barcodePrints = await database.getAllbarcodePrint();

        List barcodemaster = await database.getAllbarcodemaster();
        // List vendors = await database.getAllvendors();

        // ***************************** convert to model
        List<DBPRoductModel> prducts = [];
        // chatModelFromJson(datas);
        List<BarcodeMaster> barcodeMasters = [];
        //  getBarcodeMaster(barcodemaster);
        List<Grn> grnsss = grnss(grns);
        List<GrnDetail> grnDetailsss = grnDetails(grnDetail);
        List<Grv> grvsss = grvss(grvs);
        List<GrvDetail> grvDetailsss = grvDetails(grvDetail);
        List<PoHeaderModel> poheader = poHeaderModelFromJson(poHeader);
        List<PoDetailsModel> poDetailsss = poDetailsModelFromJson(poDetail);
        //*************************** barcode prints */
        List prints = [];
        if (barcodePrint != null) {
          Map last = {
            "barcode": barcodePrint["barcode"],
            "itemname": barcodePrint["itemname"],
            "rate": barcodePrint["rate"],
            "printcount": barcodePrint["printcount"],
            "prntdatetime": barcodePrint["printdatetime"],
            "terminal": terminal ?? "",
            // "pdt",
            "status": 'NOT PRINTED'
          };
          prints.add(last);
        }

        // for (var element in barcodePrints) {
        //   Map current = {
        //     "barcode": element["barcode"],
        //     "itemname": element["itemname"],
        //     "rate": element["rate"],
        //     "printcount": element["printcount"],
        //     "printdatetime": element["printdatetime"],
        //     "terminal": terminal ?? "",
        //     // "pdt",
        //     "status": 'NOT PRINTED'
        //   };
        //   prints.add(current);
        // }

        // //************************* products map */
        // List productsList = [];
        // for (var element in prducts) {
        //   Map temp = {
        //     "itemcode": int.parse(element.itemcode),
        //     "mastername": element.itemname,
        //     "barcode": element.barcode.toString(),
        //     "qtyyype": element.qtytype,
        //     "categoryname": element.category,
        //     "qty": element.stock,
        //     "addQTY": 0,
        //     "replaceQTY": 0,
        //     "adjtype": element.flag,
        //     "sajno": element.sajno,
        //     "pcspertype": element.pcspertype
        //   };
        //   productsList.add(temp);
        // }
        //************************* vendors map */
        List vendorList = [];
        // for (var element in vendors) {
        //   Map temp = {
        //     "vendorid": element["vendorid"],
        //     "vendorname": element["vendorname"]
        //   };
        //   vendorList.add(temp);
        // }
        //************************* barcodeMasters map */
        List barcodeMasterList = [];
        for (var element in barcodeMasters) {
          Map temp = {
            "barcode": element.barcode,
            "barcodespecificname": element.barcodespecificname,
            "cashpriceaftertax": element.cashpriceaftertax,
            "creditpriceaftertax": element.creditpriceaftertax,
            "retailerpriceaftertax": element.retailerpriceaftertax,
            "categoryid": element.categoryid,
            "itemmastername": element.itemmastername,
            "itemcode": int.parse(element.itemcode),
          };
          barcodeMasterList.add(temp);
        }
        //************************* grn map */
        List grnList = [];
        for (var element in grnsss) {
          Map temp = {
            "grnno": element.grnno,
            "grndate": element.grndate,
            "vendorid": element.vendorid,
            "grnref": element.grnref,
            "recievedby": element.recievedby,
            "ponumber": element.ponumber,
            "terminal": terminal ?? "",
            "status": "NOT SYNCED"
          };
          grnList.add(temp);
        }
        //************************* grn details map */
        List grnDetailsList = [];
        for (var element in grnDetailsss) {
          Map temp = {
            "grnno": element.grnno,
            "barcode": element.barcode,
            "qty": element.qty,
            "foc": element.foc,
            "cost": element.cost,
            "terminal": terminal ?? "",
            "status": "NOT SYNCED"
          };
          grnDetailsList.add(temp);
        }

        //************************* grv map */
        List grvList = [];
        for (var element in grvsss) {
          Map temp = {
            "grvno": element.grvno,
            "grvdate": element.grvdate,
            "vendorid": element.vendorid,
            "RFRNCE": element.grvref,
            "ENTEREDBY": element.returnedby,
            "REMARKS": element.remark,
            "terminal": terminal ?? "",
            "status": "NOT SYNCED"
          };
          grvList.add(temp);
        }
        //************************* grn details map */
        List grvDetailsList = [];
        for (var element in grvDetailsss) {
          Map temp = {
            "grvno": element.grvno,
            "barcode": element.barcode,
            "qty": element.qty,
            "RETURNFLAG": element.reason,
            "cost": element.cost,
            "terminal": terminal ?? "",
            "status": "NOT SYNCED"
          };
          grvDetailsList.add(temp);
        }
        //************************* po map */
        List poList = [];
        for (var element in poheader) {
          Map temp = {
            "pono": element.pono,
            "podate": element.podate,
            "vendorid": element.vendorid,
            "REMARKS": element.remark,
            "ENTEREDBY": element.enteredby,
            "terminal": terminal ?? "",
            "status": "NOT SYNCED"
          };
          poList.add(temp);
        }
        //************************* po details map */
        List poDetailsList = [];
        for (var element in poDetailsss) {
          Map temp = {
            "pono": element.pono,
            "barcode": element.barcode,
            "qty": element.qty,
            "foc": element.foc,
            "cost": element.rate,
            "terminal": terminal ?? "",
            "status": "NOT SYNCED"
          };
          poDetailsList.add(temp);
        }

//********************** params */
        Map params = {
          "products": [],
          "barcodeMaster": isBarcodePrint ? [] : barcodeMasterList,
          "grn": isBarcodePrint ? [] : grnList,
          "grnDetails": isBarcodePrint ? [] : grnDetailsList,
          "GRVHEADERUPLOAD": isBarcodePrint ? [] : grvList,
          "GRVDETAILSUPLOAD": isBarcodePrint ? [] : grvDetailsList,
          "vendors": isBarcodePrint ? [] : vendorList,
          "categoryList": isBarcodePrint ? [] : [],
          "barcodeprint": isBarcodePrint ? prints : [],
          "poheaderupload": isBarcodePrint ? [] : poList,
          "podetailsupload": isBarcodePrint ? [] : poDetailsList,
          "poheader": isBarcodePrint ? [] : [],
          "podetails": isBarcodePrint ? [] : [],
          "pflag": flag
        };
        log(jsonEncode(params), name: "params");

//********************************** api call */
        var res = await http.post(Uri.parse("$ip/api/Product/addList"),
            headers: headers, body: jsonEncode(params));
        log("$ip/api/Product");
        log(res.body.toString());
        log(res.statusCode.toString());
        if (res.statusCode == 200) {
          if (!isBarcodePrint) {
            await database.clearGrn();
            await database.clearGrnDetails();
            await database.clearpo();
            await database.clearPoDetails();
            await database.clearGrv();
            await database.clearGrvDetails();
          }

          log(res.body.toString(), name: "body");
          var body = res.body;
          if (body.toString().toLowerCase() == "updated") {
            return {
              "status": "success",
            };
          } else {
            return {"status": "failed", "message": "!404"};
          }
        } else {
          return {"status": "failed", "message": "!200"};
        }
      } else {
        showSnackbar("Ip address not configured", context);
        return {"status": "failed", "message": "Ip not configured"};
      }
    } catch (e) {
      log(e.toString(), name: "errorrrr");
      return {"status": "failed", "message": "some server error occured"};
    }
  }

  getAllData(BuildContext context, DB database) async {
    try {
      // var res = await http.post(Uri.parse("http://10.0.2.2:7058/api/Product"),
      //     headers: headers, body: jsonEncode(params));

      // SharedPreferences sp = await SharedPreferences.getInstance();
      // String? ip = sp.getString(
      //   "ip",
      // );
      List storedata = await database.getAllstoredata();
      log(storedata.toString(), name: "store data");
      if (storedata.isNotEmpty && storedata.last["ip"] != null) {
        String ip = storedata.last["ip"] ?? "";
        // String terminal;
        var res = await http.get(
          // Uri.parse("http://mmcentral.dyndns.org:7089/Swagger/index.html"),
          Uri.parse("$ip/api/Product"),
          headers: headers,
        );
        log("$ip/api/Product");
        // log("http://mmcentral.dyndns.org:7089/Swagger/index.html");

        log(res.body.toString(), name: "body");
        log(res.statusCode.toString());
        if (res.statusCode == 200) {
          log(res.body.toString(), name: "body");
          var body = jsonDecode(res.body);
          if (body != null) {
            List<OnlineProductModel> products = [];
            // onlineProductModelFromList(body["products"]);
            List<Grn> grns = [];
            // grnss(body["grn"]);
            List<GrnDetail> grnDetail = [];
            // grnDetails(body["grnDetails"]);
            // List<BarcodeMaster> barcodeMasters =
            //     getBarcodeMaster(body["barcodeMaster"]);
            // onlineProductModelFromJson(res.body);
            List vendors = body["vendors"];
            List storemaster = body["storemaster"];
            List<ItemmasterModel> itemmasters =
                itemmasterModelFromJson(body["barcodeMaster"]);
            List<PoHeaderModel> poeaders =
                poHeaderModelFromJson(body["poheader"]);
            List<PoDetailsModel> podetails =
                poDetailsModelFromJson(body["podetails"]);
            return {
              "vendors": vendors,
              "storemaster": storemaster,
              "status": "success",
              "data": products,
              "grns": grns,
              "grnDetails": grnDetail,
              "categoryList": body["categoryList"],
              // "barcodemasters": barcodeMasters,
              "itemmasters": itemmasters,
              "poheader": poeaders,
              "podetails": podetails
            };
          } else {
            return {"status": "failed", "message": "No data found"};
          }
        } else {
          return {"status": "failed", "message": "!200"};
        }
      } else {
        showSnackbar("Ip address not configured", context);
        return {"status": "failed", "message": "no ip"};
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
      log(e.toString(), name: "errorr");
      return {"status": "failed", "message": "some server error occured"};
    }
  }

  getProductByBarcode(BuildContext context, String barcode, DB database) async {
    try {
      // var res = await http.post(Uri.parse("http://10.0.2.2:7058/api/Product"),
      //     headers: headers, body: jsonEncode(params));

      // SharedPreferences sp = await SharedPreferences.getInstance();
      // String? ip = sp.getString(
      //   "ip",
      // );
      List storedata = await database.getAllstoredata();
      log(storedata.toString(), name: "store data");
      if (storedata.isNotEmpty && storedata.last["ip"] != null) {
        String ip = storedata.last["ip"] ?? "";
        // String terminal;
        var res = await http.get(
          Uri.parse("$ip/api/Product/$barcode"),
          headers: headers,
        );
        log("$ip/api/Product/$barcode");
        // log("http://mmcentral.dyndns.org:7089/Swagger/index.html");

        log(res.body.toString(), name: "body");
        log(res.statusCode.toString());
        if (res.statusCode == 200) {
          log(res.body.toString(), name: "body");
          var body = jsonDecode(res.body);
          BarcodeProductModel product = BarcodeProductModel.fromJson(body);
          return {
            "status": "success",
            "product": product,
          };
        } else {
          return {"status": "failed", "message": "!200"};
        }
      } else {
        showSnackbar("Ip address not configured", context);
        return {"status": "failed", "message": "no ip"};
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
      log(e.toString(), name: "errorr");
      return {"status": "failed", "message": "some server error occured"};
    }
  }

  getbarcodedetailswithStock(
      BuildContext context, String barcode, DB database, int storecode) async {
    try {
      List storedata = await database.getAllstoredata();
      log(storedata.toString(), name: "store data");
      if (storedata.isNotEmpty && storedata.last["ip"] != null) {
        String ip = storedata.last["ip"] ?? "";
        // String terminal;
        var res = await http.get(
          Uri.parse(
              "$ip/api/Product/$barcode/$storecode/getBarcodeDetailsWithStock"),
          headers: headers,
        );
        log("$ip/api/Product/$barcode/$storecode/getBarcodeDetailsWithStock");
        // log("http://mmcentral.dyndns.org:7089/Swagger/index.html");
        var url = Uri.parse(
            "$ip/api/Product/$barcode/$storecode/getBarcodeDetailsWithStock");
        log("Request URL: $url");
        log(res.body.toString(), name: "body");
        log(res.statusCode.toString());
        if (res.statusCode == 200) {
          log(res.body.toString(), name: "body");
          var body = jsonDecode(res.body);
          BarcodeProductModel product = BarcodeProductModel.fromJson(body);
          return {
            "status": "success",
            "product": product,
          };
        } else {
          return {"status": "failed", "message": "!200"};
        }
      } else {
        showSnackbar("Ip address not configured", context);
        return {"status": "failed", "message": "no ip"};
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
      log(e.toString(), name: "errorr");
      return {"status": "failed", "message": "some server error occured"};
    }
  }
}
