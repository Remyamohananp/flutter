import 'package:flutter/material.dart';
import 'package:qr_scanner/model/db_product_model.dart';

class StockController extends ChangeNotifier {
  DBPRoductModel? barcodeReadedData;
  int? scannedbarcode;

  getBarcodeDate(DBPRoductModel data) {
    barcodeReadedData = data;
    notifyListeners();
  }

  getBarcode(int code) {
    barcodeReadedData = null;
    scannedbarcode = code;
    notifyListeners();
  }

  init() {
    barcodeReadedData = null;
    scannedbarcode = null;
    notifyListeners();
  }
}
