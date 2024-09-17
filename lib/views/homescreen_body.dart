import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/item_master_controller.dart';
import 'package:qr_scanner/controller/product_controller.dart';
import 'package:qr_scanner/controller/stock_controller.dart';
import 'package:qr_scanner/custom%20widgets/flag_dropdwon_widget.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/model/db_product_model.dart';
import 'package:qr_scanner/model/online_product_model.dart';
import 'package:qr_scanner/model/product_model.dart';
import 'package:qr_scanner/repository/api_repository.dart';
import 'package:qr_scanner/utils/items_dropdown.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/scan_barcode.dart';
import 'package:qr_scanner/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomescreenBody extends StatelessWidget {
  DB database;
  Map? barcodeReadedData;
  List<Map> items;
  SingleSelectController<Map?> itemDropCtrl;
  TextEditingController itemCodeCtrl;
  TextEditingController itemnameCtrl;
  TextEditingController qtyTypeCtrl;
  TextEditingController categoryCtrl;
  TextEditingController categoryIdCtrl;
  TextEditingController currentStockCtrl;
  TextEditingController barcodeCtrl;
  TextEditingController addToCurrentStock;
  TextEditingController spriceCtrl;
  TextEditingController replaceStockCtrl;
  TextEditingController flagCtrl;
  TextEditingController pcspertype;
  TextEditingController sajnoCtrl;
  TextEditingController remarkCtrl;
  Map? selectedItem;

  bool isServerRemote;
  HomescreenBody(
      {super.key,
      required this.flagCtrl,
      required this.items,
      required this.sajnoCtrl,
      required this.itemDropCtrl,
      required this.pcspertype,
      required this.addToCurrentStock,
      required this.remarkCtrl,
      required this.isServerRemote,
      required this.database,
      required this.barcodeCtrl,
      required this.categoryCtrl,
      required this.categoryIdCtrl,
      required this.currentStockCtrl,
      required this.replaceStockCtrl,
      required this.itemCodeCtrl,
      required this.itemnameCtrl,
      required this.qtyTypeCtrl,
      required this.spriceCtrl,
      this.barcodeReadedData});

  // final flags = [
  //   "none",
  //   "Damage",
  //   'Scrap',
  //   "Adjustment",
  //   'Stock Inward adjustment',
  //   'Opening Stock Provision',
  //   'Internal Usage',
  //   'Physical Stock Adjustment',
  // ];

  @override
  Widget build(BuildContext context) {
    isServerRemote = false;
    return Column(
      children: [
        field(
          cntr: sajnoCtrl,
          context: context,
          txt: "SAJNO",
          isRead: true,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(children: [
          Expanded(
            child: field(
              cntr: barcodeCtrl,
              context: context,
              txt: "Barcode",
              number: true,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.black),
              onPressed: () {
                isServerRemote = false;
                getLocalProductDetailsFromitemmaster(
                    isServerRemote, barcodeCtrl.text.trim(), database, context);
                // getLocalProductBySearch(
                //     isServerRemote, barcodeCtrl.text.trim(), database, context);
              },
              child: const Icon(Icons.search)),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                // builder: (_) => const QrScanner()));
                startBarcodeScanFromItemmaster(
                    context, isServerRemote, database);
                // startBarcodeScan(context, isServerRemote, database);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  "assets/qr-code.png",
                  height: 30,
                  width: 30,
                  color: Colors.white,
                ),
              )),
        ]),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
                child: ItemsDropdown(
              item: selectedItem,
              ctrl: itemDropCtrl,
              items: items,
              onValueChanged: (p0) {
                // itemnameCtrl.text = p0 != null ? p0['mastername'] : "";
              },
            )
                // field(
                //     cntr: itemnameCtrl, context: context, txt: "ITEM NAME")
                ),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.black),
                onPressed: () {
                  isServerRemote = false;
                  itemnameCtrl.text = itemDropCtrl.value != null
                      ? itemDropCtrl.value!['mastername']
                      : "";
                  getLocalProductDetailsFromitemmasterbyname(isServerRemote,
                      itemnameCtrl.text.trim(), items, database, context);
                  // getLocalProductBySearch(
                  //     isServerRemote, barcodeCtrl.text.trim(), database, context);
                },
                child: const Icon(Icons.search)),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        field(
          cntr: itemCodeCtrl,
          context: context,
          txt: "ITEM CODE",
          isRead: true,
        ),
        const SizedBox(
          height: 16,
        ),
        field(
          cntr: qtyTypeCtrl,
          context: context,
          txt: "QTY TYPE",
          isRead: true,
        ),
        const SizedBox(
          height: 16,
        ),
        field(
          cntr: pcspertype,
          context: context,
          txt: "PCS",
          number: true,
          isRead: true,
        ),
        const SizedBox(
          height: 16,
        ),
        field(
          cntr: categoryCtrl,
          context: context,
          txt: "CATEGORY",
          isRead: true,
        ),
        const SizedBox(
          height: 16,
        ),
        field(
          number: true,
          cntr: spriceCtrl,
          context: context,
          txt: "S PRICE",
          isRead: true,
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(),
        const SizedBox(
          height: 8,
        ),
        field(
          number: true,
          cntr: currentStockCtrl,
          context: context,
          txt: "CURRENT STOCK",
          isRead: true,
        ),
        const SizedBox(
          height: 16,
        ),
        field(
            number: true,
            cntr: replaceStockCtrl,
            context: context,
            txt: "REPLACE STOCK"),
        const SizedBox(
          height: 16,
        ),
        field(
            cntr: addToCurrentStock,
            number: true,
            context: context,
            txt: "Add TO CURRENT STOCK"),
        const SizedBox(
          height: 16,
        ),
        field(cntr: remarkCtrl, context: context, txt: "REMARK"),
        const SizedBox(
          height: 12,
        ),
        FlagDropdwonWidget(
          flagCtrl: flagCtrl,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    // validate(val);
                    if (isServerRemote) {
                      // validateOnlineProduct(
                      //     context,
                      //     barcodeCtrl,
                      //     replaceStockCtrl,
                      //     addToCurrentStock,
                      //     currentStockCtrl,
                      //     itemCodeCtrl,
                      //     itemnameCtrl,
                      //     qtyTypeCtrl,
                      //     spriceCtrl,
                      //     categoryCtrl,
                      //     flagCtrl,

                      //     database);
                    } else {
                      validate(
                        context,
                        barcodeCtrl,
                        replaceStockCtrl,
                        addToCurrentStock,
                        currentStockCtrl,
                        itemCodeCtrl,
                        itemnameCtrl,
                        qtyTypeCtrl,
                        spriceCtrl,
                        categoryCtrl,
                        flagCtrl,
                        pcspertype,
                        remarkCtrl,
                        sajnoCtrl,
                        barcodeReadedData,
                        database,
                      );
                    }
                  },
                  child: const Text("Add")),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    context.read<ProductController>().init();
                    context.read<StockController>().init();
                    context.read<ItemMasterController>().init();
                    itemCodeCtrl.text = "";
                    itemnameCtrl.text = "";
                    qtyTypeCtrl.text = "";
                    categoryCtrl.text = "";
                    categoryIdCtrl.text = "";
                    currentStockCtrl.text = "";
                    barcodeCtrl.text = "";
                    addToCurrentStock.text = "";
                    spriceCtrl.text = "";
                    replaceStockCtrl.text = "";
                    flagCtrl.text = "";
                    pcspertype.text = "";
                    remarkCtrl.text = "";
                    sajnoCtrl.text = sajnoCtrl.text;
                    itemDropCtrl.clear();
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    int sajno = sp.getInt(
                          "newSaj",
                        ) ??
                        1;
                    sajnoCtrl.text = sajno.toString();
                    database.getAllsajDetails();
                    database.getAllsajheader();
                  },
                  child: const Text("Clear")),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

//******************************************* local products validation */
validate(
    BuildContext context,
    TextEditingController barcodeCtrl,
    TextEditingController replaceStockCtrl,
    TextEditingController addToCurrentStock,
    TextEditingController currentStockCtrl,
    TextEditingController itemCodeCtrl,
    TextEditingController itemnameCtrl,
    TextEditingController qtyTypeCtrl,
    TextEditingController spriceCtrl,
    TextEditingController categoryCtrl,
    TextEditingController flagCtrl,
    TextEditingController pcspertype,
    TextEditingController remarkCtrl,
    TextEditingController sajnoCtrl,
    Map? barcodeReadedData,
    DB database) async {
  //TODO uncomment below validation
  // if (barcodeReadedData == null) {
  //   showSnackbar("No products selected", context);
  // } else
  if (barcodeCtrl.text.trim().isEmpty) {
    showSnackbar(barcodeCtrl.text, context);
  } else if (itemCodeCtrl.text.trim().isEmpty) {
    showSnackbar("Enter itemcode", context);
  } else if (itemnameCtrl.text.trim().isEmpty) {
    showSnackbar("Enter item name", context);
  } else if (qtyTypeCtrl.text.trim().isEmpty) {
    showSnackbar("Enter qty type", context);
  } else if (pcspertype.text.trim().isEmpty) {
    showSnackbar("Enter pcs", context);
  } else if (categoryCtrl.text.trim().isEmpty) {
    showSnackbar("Enter category", context);
  } else if (spriceCtrl.text.trim().isEmpty) {
    showSnackbar("Enter sprice", context);
  } else if (currentStockCtrl.text.trim().isEmpty) {
    showSnackbar("Enter stock", context);
  } else if (flagCtrl.text.isEmpty) {
    showSnackbar("Please select flag", context);
  } else {
    transparantDialog(context);
    try {
      int replaceStockCount = replaceStockCtrl.text.trim().isNotEmpty
          ? int.parse(replaceStockCtrl.text.trim())
          : 0;
      int addStockCount = addToCurrentStock.text.trim().isNotEmpty
          ? int.parse(addToCurrentStock.text.trim())
          : 0;
      int stock = currentStockCtrl.text.trim().isNotEmpty
          ? int.parse(currentStockCtrl.text.trim())
          : 0;

      stock =
          replaceStockCtrl.text.trim().isNotEmpty ? replaceStockCount : stock;
      stock = addToCurrentStock.text.trim().isNotEmpty
          ? stock + addStockCount
          : stock + 0;
      currentStockCtrl.text = stock.toString();
      // get username and new sajno
      SharedPreferences sp = await SharedPreferences.getInstance();
      int sajno = sp.getInt(
            "newSaj",
          ) ??
          1;
      String userName = sp.getString(
            "userName",
          ) ??
          "";

      // format date
      final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      String formattedsajDate = formatter.format(DateTime.now());
      await database.insertsajheader(
          sajno,
          formattedsajDate,
          remarkCtrl.text.isEmpty ? "" : remarkCtrl.text.trim(),
          userName,
          1000);
      await database.insertsajDetails(
          sajno,
          barcodeCtrl.text.trim(),
          itemnameCtrl.text.trim(),
          qtyTypeCtrl.text.trim(),
          flagCtrl.text.trim(),
          1000,
          1000,
          stock,
          double.parse(
              spriceCtrl.text.trim().isEmpty ? "0" : spriceCtrl.text.trim()));
      //set new sajno
      int newSajno = sajno + 1;
      sp.setInt("newSaj", newSajno);
      replaceStockCtrl.text = "";
      addToCurrentStock.text = "";
      navigatorKey.currentState?.pop();

      showSnackbar("Stock updated", context);
      // await database.insertdata(
      //   int.parse(barcodeCtrl.text.trim()),
      //   itemCodeCtrl.text.trim(),
      //   itemnameCtrl.text.trim(),
      //   qtyTypeCtrl.text.trim(),
      //   categoryCtrl.text.trim(),
      //   double.parse(spriceCtrl.text.trim()),
      //   stock,
      //   double.parse(
      //       pcspertype.text.trim().isEmpty ? "0.0" : pcspertype.text.trim()),
      //   sajno,
      //   flagCtrl.text.trim(),
      // );
      // showSnackbar(
      //     barcodeReadedData == null ? "Product Added" : "Product Updated",
      //     context);
      // navigatorKey.currentState?.pop();
      // currentStockCtrl.text = stock.toString();
      // addToCurrentStock.text = "";
      // replaceStockCtrl.text = "";
    } catch (e) {
      navigatorKey.currentState?.pop();

      showSnackbar("Failed to update stock", context);

      // showSnackbar(
      //     barcodeReadedData == null
      //         ? "Failed to add product"
      //         : "failed to update product",
      //     context);
    }
  }
}

// //******************************************* remote products validation */
// validateOnlineProduct(
//     BuildContext context,
//     TextEditingController barcodeCtrl,
//     TextEditingController replaceStockCtrl,
//     TextEditingController addToCurrentStock,
//     TextEditingController currentStockCtrl,
//     TextEditingController itemCodeCtrl,
//     TextEditingController itemnameCtrl,
//     TextEditingController qtyTypeCtrl,
//     TextEditingController spriceCtrl,
//     TextEditingController categoryCtrl,
//     TextEditingController flagCtrl,
//     int sajno,
//     OnlineProductModel? scannedProduct,
//     DB database) async {
//   if (scannedProduct == null) {
//     showSnackbar("No products selected", context);
//   } else if (barcodeCtrl.text.trim().isEmpty) {
//     showSnackbar(barcodeCtrl.text, context);
//   } else if (flagCtrl.text.isEmpty) {
//     showSnackbar("Please select flag", context);
//   } else {
//     transparantDialog(context);

//     try {
//       int replaceStockCount = replaceStockCtrl.text.trim().isNotEmpty
//           ? int.parse(replaceStockCtrl.text.trim())
//           : 0;
//       int addStockCount = addToCurrentStock.text.trim().isNotEmpty
//           ? int.parse(addToCurrentStock.text.trim())
//           : 0;
//       int stock = currentStockCtrl.text.trim().isNotEmpty
//           ? int.parse(currentStockCtrl.text.trim())
//           : 0;
//       stock =
//           replaceStockCtrl.text.trim().isNotEmpty ? replaceStockCount : stock;
//       stock = addToCurrentStock.text.trim().isNotEmpty
//           ? stock + addStockCount
//           : stock + 0;
//       Map res = await ApiRepository().addproduct(
//           context: context,
//           itemCode: itemCodeCtrl.text.trim(),
//           masterName: itemnameCtrl.text.trim(),
//           adjtype: flagCtrl.text.trim(),
//           barcode: barcodeCtrl.text.trim(),
//           categry: categoryCtrl.text.trim(),
//           qtyyype: qtyTypeCtrl.text.trim(),
//           qty: stock.toString(),
//           sajno: sajno.toString());
//       if (res["status"] == "success") {
//         showSnackbar(
//             scannedProduct == null ? "Product Added" : "Product Updated",
//             context);
//         navigatorKey.currentState?.pop();
//         currentStockCtrl.text = stock.toString();
//         addToCurrentStock.text = "";
//         replaceStockCtrl.text = "";
//       } else {
//         navigatorKey.currentState?.pop();

//         showSnackbar("Failed to update product", context);
//       }
//     } catch (e) {
//       navigatorKey.currentState?.pop();

//       showSnackbar("Failed to update product", context);
//     }
//   }
// }
