//******************************************************************* */
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/barcode_master_controller.dart';
import 'package:qr_scanner/controller/item_master_controller.dart';
import 'package:qr_scanner/controller/product_controller.dart';
import 'package:qr_scanner/controller/stock_controller.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/model/barcode_master_model.dart';
import 'package:qr_scanner/model/db_product_model.dart';
import 'package:qr_scanner/model/item_master_model.dart';
import 'package:qr_scanner/model/online_product_model.dart';
import 'package:qr_scanner/repository/api_repository.dart';
import 'package:qr_scanner/utils/snackbar.dart';

// Future<String> startBarcodeScan(
//     BuildContext context, bool isServerRemote, DB database,
//     {bool isBarcodeMaster = false}) async {
//   String scanResult;
//   try {
//     scanResult = await FlutterBarcodeScanner.scanBarcode(
//       '#ff6666', // color of the scan line
//       'Cancel', // cancel button text
//       true, // show the flash icon
//       ScanMode.BARCODE, // scan mode
//     );

//     if (isServerRemote) {
//       showSnackbar("Change server to local", context);
//       // Map res = await ApiRepository()
//       //     .getProductDetails(barcode: scanResult, context: context);
//       // if (res["status"] == "success") {
//       //   OnlineProductModel product = res["message"];
//       //   context.read<ProductController>().getBarcodeDate(product);
//       // } else {
//       //   context.read<ProductController>().getBarcode(int.parse(scanResult));
//       // }
//     } else {
//       if (isBarcodeMaster) {
//         //************************* get data from barcode master */
//         List barcodeMasterdata =
//             await database.getBarcodeMasterByBarcode(scanResult);

//         if (barcodeMasterdata.isNotEmpty) {
//           List<BarcodeMaster> barcodeMasters =
//               getBarcodeMaster(barcodeMasterdata);
//           context
//               .read<BarcodeMasterController>()
//               .getBarcodeDate(barcodeMasters[0]);
//         } else {
//           context
//               .read<BarcodeMasterController>()
//               .getBarcode(int.parse(scanResult));
//         }
//       } else {
//         List data = await database.getProductByBarcode(int.parse(scanResult));
//         if (data.isNotEmpty) {
//           List<DBPRoductModel> prduct = chatModelFromJson(data);
//           context.read<StockController>().getBarcodeDate(prduct[0]);
//         } else {
//           context.read<StockController>().getBarcode(int.parse(scanResult));
//         }
//       }
//     }
//     return scanResult;
//   } catch (e) {
//     scanResult = 'Failed to get the scan result';
//     showSnackbar(scanResult, context);

//     // Fluttertoast.showToast(msg: scanResult);

//     return "";
//   }
// }

//******************************************************************** */
// getLocalProductBySearch(
//     bool isServerRemote, String barcode, DB database, BuildContext context,
//     {bool isBarcodeMaster = false}) async {
//   try {
//     if (isServerRemote) {
//       showSnackbar("Change server to local", context);

//       // Map res = await ApiRepository()
//       //     .getProductDetails(barcode: barcode, context: context);
//       // if (res["status"] == "success") {
//       //   OnlineProductModel product = res["message"];
//       //   context.read<ProductController>().getBarcodeDate(product);
//       // } else {
//       //   context.read<ProductController>().getBarcode(int.parse(barcode));
//       // }
//     } else {
//       if (isBarcodeMaster) {
//         List barcodeMasterdata =
//             await database.getBarcodeMasterByBarcode(barcode);

//         if (barcodeMasterdata.isNotEmpty) {
//           List<BarcodeMaster> barcodeMasters =
//               getBarcodeMaster(barcodeMasterdata);
//           context
//               .read<BarcodeMasterController>()
//               .getBarcodeDate(barcodeMasters[0]);
//         } else {
//           context
//               .read<BarcodeMasterController>()
//               .getBarcode(int.parse(barcode));
//         }
//       } else {
//         log(barcode);
//         List data = await database.getProductByBarcode(int.parse(barcode));
//         if (data.isNotEmpty) {
//           List<DBPRoductModel> prduct = chatModelFromJson(data);
//           context.read<StockController>().getBarcodeDate(prduct[0]);
//         } else {
//           showSnackbar("No Products Found", context);
//           context.read<StockController>().getBarcode(int.parse(barcode));
//         }
//       }
//     }
//   } catch (e) {
//     log(e.toString());
//     showSnackbar("Something went wrong", context);
//   }
// }

//******************************************************************** */
getLocalProductDetailsFromitemmaster(
    bool isServerRemote, String barcode, DB database, BuildContext context,
    {FocusNode? focus}) async {
  try {
    if (isServerRemote) {
      showSnackbar("Change server to local", context);
    } else {
      log(barcode);
      
      List data = await database.getProductFromitemmasterByBarcode(barcode);
      if (data.isNotEmpty) {
        // List<ItemmasterModel> prduct = itemmasterModelFromJson(data);
        context.read<ItemMasterController>().getBarcodeDate(data[0], false);
      } else {
        if (focus != null) {
          
          focus.requestFocus();
          
        }
        // showSnackbar("No Products Found", context);
        showAlertDialogWhenNoPRoductFound(context);
        // context.read<ItemMasterController>().getBarcode(barcode);
      }
    }
  } catch (e) {
    log(e.toString());
    showSnackbar("Something went wrong", context);
  }
}

Future<String> startBarcodeScanFromItemmaster(
  BuildContext context,
  bool isServerRemote,
  DB database, {
  bool isBarcodeMaster = false,
  FocusNode? focus,
  FocusNode? focus2,
}) async {
  String scanResult;
  try {
    scanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // color of the scan line
      'Cancel', // cancel button text
      true, // show the flash icon
      ScanMode.BARCODE, // scan mode
    );

    if (isServerRemote) {
      showSnackbar("Change server to local", context);
    } else {
      List data = await database.getProductFromitemmasterByBarcode(scanResult);
      if (data.isNotEmpty) {
        context.read<ItemMasterController>().getBarcodeDate(data[0], false);
        if (focus2 != null) {
          focus2.requestFocus();
        }
        // context.read<ItemMasterController>().getBarcodeDate(data[0], false);
      } else {
        // showSnackbar("No Products found", context);
        showAlertDialogWhenNoPRoductFound(context);
        context.read<ItemMasterController>().getBarcode(scanResult);
        if (focus != null) {
          focus.requestFocus();
        }
      }
    }
    return scanResult;
  } catch (e) {
    scanResult = 'Failed to get the scan result';
    showSnackbar(scanResult, context);

    // Fluttertoast.showToast(msg: scanResult);

    return "";
  }
}

getLocalProductDetailsFromitemmasterbyname(
  bool isServerRemote,
  String name,
  List items,
  DB database,
  BuildContext context,
) async {
  try {
    if (isServerRemote) {
      showSnackbar("Change server to local", context);
    } else {
      log(name);
       //List data1 = await database.getAllitemmaster();
      List data = [];
      for (var element in items) {
        if (name.toLowerCase().trim() ==
            element["barcodespname"].toString().toLowerCase().trim()) {
          data.add(element);
        }
      }
      if (data.isNotEmpty) {
        // List<ItemmasterModel> prduct = itemmasterModelFromJson(data);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<ItemMasterController>().getBarcodeDate(data[0], true);
        });
      } else {
        context.read<ItemMasterController>().init();

        // showSnackbar("No Products Found", context);
        // context.read<ItemMasterController>().getBarcode(barcode);
      }
    }
  } catch (e) {
    log(e.toString());
    showSnackbar("Something went wrong", context);
  }
}

////////////////////////////// no product found msg box

void showAlertDialogWhenNoPRoductFound(
  BuildContext context2,
) {
  showDialog(
    context: context2,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              color: Colors.orange.shade600,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              "No Products Found!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white),
                  child: const Text('Go Back'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
