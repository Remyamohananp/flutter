import 'package:flutter/material.dart';
import 'package:qr_scanner/model/item_master_model.dart';

class ItemMasterController extends ChangeNotifier {
  Map? barcodeReadedData;
  String? scannedbarcode;
  bool isItemSearched = false;

  getBarcodeDate(Map data, bool _isItemSearched) {
    barcodeReadedData = data;
    isItemSearched = _isItemSearched;
    notifyListeners();
  }

  getBarcode(String code) {
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
