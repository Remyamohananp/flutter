import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/model/online_product_model.dart';
import 'package:qr_scanner/model/product_model.dart';
import 'package:qr_scanner/repository/api_repository.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/snackbar.dart';

class ProductController extends ChangeNotifier {
  OnlineProductModel? barcodeProductDetails;
  int? scannedbarcode;

  getBarcodeDate(OnlineProductModel data) {
    barcodeProductDetails = data;
    notifyListeners();
  }

  getBarcode(int code) {
    barcodeProductDetails = null;
    scannedbarcode = code;
    notifyListeners();
  }

  init() {
    barcodeProductDetails = null;
    scannedbarcode = null;
    notifyListeners();
  }

  // getProductCode(String code, BuildContext context) {
  //   productCode = code;
  //   getProductDetails(code, context);
  //   notifyListeners();
  // }

  // getProduct(ProductModel productData) {
  //   product = productData;
  //   notifyListeners();
  // }

  // initProduct() {
  //   product = null;
  //   isLoading = false;
  // }

  // changeLoading() {
  //   isLoading = !isLoading;
  //   notifyListeners();
  // }

  // getProductDetails(String code, BuildContext context) async {
  //   log("message");
  //   transparantDialog(context);
  //   Map res = await ApiRepository().getProductDetails(barcode: code);
  //   if (res["status"] == "success") {
  //     ProductModel product = res["data"];
  //     getProduct(product);

  //     navigatorKey.currentState?.pop();
  //   } else {
  //     showSnackbar("Failed to fetch Product details", context);

  //     // Fluttertoast.cancel();
  //     // Fluttertoast.showToast(msg: "Failed to fetch Product details");
  //     navigatorKey.currentState?.pop();
  //   }
  // }
}
