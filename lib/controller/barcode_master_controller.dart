import 'package:flutter/foundation.dart';
import 'package:qr_scanner/model/db_product_model.dart';
import 'package:qr_scanner/model/online_product_model.dart';

import '../model/barcode_master_model.dart';

class BarcodeMasterController extends ChangeNotifier {
  BarcodeMaster? barcodeMasterDetails;
  int? scannedbarcode;

  getBarcodeDate(
    BarcodeMaster data,
  ) {
    barcodeMasterDetails = data;
    notifyListeners();
  }

  getBarcode(int code) {
    barcodeMasterDetails = null;

    scannedbarcode = code;
    notifyListeners();
  }

  init() {
    barcodeMasterDetails = null;
    scannedbarcode = null;
    notifyListeners();
  }
}
