import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/model/barcode_product_model.dart';
import 'package:qr_scanner/repository/api_repository.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/print_date_format.dart';
import 'package:qr_scanner/utils/snackbar.dart';

class PurchaseEnquiryOnline extends StatefulWidget {
  final DB database;
  PurchaseEnquiryOnline({super.key, required this.database});

  @override
  State<PurchaseEnquiryOnline> createState() => _PurchaseEnquiryOnlineState();
}

class _PurchaseEnquiryOnlineState extends State<PurchaseEnquiryOnline> {
  final FocusNode focusBarcode = FocusNode();
  final FocusNode focusPrintCount = FocusNode();

  final TextEditingController barcodeCtrl = TextEditingController();

  final TextEditingController itemcodeCtrl = TextEditingController();

  final TextEditingController itemnameCtrl = TextEditingController();

  final TextEditingController categoryCtrl = TextEditingController();

  final TextEditingController pcspertypeCtrl = TextEditingController();

  final TextEditingController qtytypeCtrl = TextEditingController();

  final TextEditingController costCtrl = TextEditingController();

  final TextEditingController sellingPriceCtrl = TextEditingController();
  final TextEditingController newsellingPriceCtrl = TextEditingController();
  final TextEditingController printCountCtrl = TextEditingController();

  ValueNotifier<bool> showSaveButton = ValueNotifier(false);
  @override
  void initState() {
    focusBarcode.requestFocus();
    focusBarcode.addListener(() {
      if (!focusBarcode.hasFocus) {
        // Run your function here
        onUnfocus();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    focusBarcode.removeListener(onUnfocus);
    focusBarcode.dispose();
    super.dispose();
  }

  void onUnfocus() async {
    if (barcodeCtrl.text.trim().isNotEmpty) {
      searchBarcode(barcodeCtrl.text.trim(), widget.database);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Product Enquiry (Online)"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: field(
                        onEditingCompleted: () {
                          searchBarcode(
                              barcodeCtrl.text.trim(), widget.database);
                        },
                        onFieldSubmitted: (p0) {
                          searchBarcode(p0, widget.database);
                        },
                        focusnode: focusBarcode,
                        cntr: barcodeCtrl,
                        context: context,
                        txt: "Barcode",
                        number: true),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        focusBarcode.unfocus();
                        searchBarcode(barcodeCtrl.text, widget.database);
                      },
                      child: const Icon(Icons.search)),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        scanBarcode(widget.database);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.asset(
                          "assets/qr-code.png",
                          height: 30,
                          width: 30,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              field(
                  cntr: itemcodeCtrl,
                  context: context,
                  txt: "Item code",
                  isRead: true),
              const SizedBox(
                height: 12,
              ),
              field(
                  cntr: itemnameCtrl,
                  context: context,
                  txt: "Item Name",
                  isRead: true),
              const SizedBox(
                height: 12,
              ),
              field(
                  cntr: categoryCtrl,
                  context: context,
                  txt: "Category Name",
                  isRead: true),
              const SizedBox(
                height: 12,
              ),
              field(
                  cntr: qtytypeCtrl,
                  context: context,
                  txt: "Qty Type",
                  isRead: true),
              const SizedBox(
                height: 12,
              ),
              field(
                  cntr: pcspertypeCtrl,
                  context: context,
                  txt: "Pcs per Type",
                  isRead: true),
              const SizedBox(
                height: 12,
              ),
              field(
                  cntr: costCtrl, context: context, txt: "Cost", isRead: true),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: field(
                        cntr: sellingPriceCtrl,
                        context: context,
                        txt: "Selling Price",
                        isRead: true),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Expanded(
                    child: field(
                        onchanged: (p0) {
                          checkPriceChange();
                        },
                        cntr: newsellingPriceCtrl,
                        context: context,
                        txt: "New Selling Price",
                        number: true),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              field(
                  focusnode: focusPrintCount,
                  cntr: printCountCtrl,
                  context: context,
                  txt: "Print Count",
                  number: true),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                      valueListenable: showSaveButton,
                      builder: (context, val, _) {
                        return val
                            ? Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.green.shade800,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text("Save"),
                                    onPressed: () {
                                      validate(context);
                                    }),
                              )
                            : const SizedBox.shrink();
                      }),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.red.shade800,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Clear"),
                        onPressed: () {
                          qtytypeCtrl.text = "";
                          barcodeCtrl.text = "";
                          itemcodeCtrl.text = "";
                          itemnameCtrl.text = "";
                          pcspertypeCtrl.text = "";
                          costCtrl.text = "";
                          categoryCtrl.text = "";
                          sellingPriceCtrl.text = "";
                          newsellingPriceCtrl.text = "";
                          // isPrintBarcode.value = false;
                          printCountCtrl.text = "";
                          showSaveButton.value = false;
                           focusBarcode.requestFocus();
                        }),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.red.shade800,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("Close"),
                        onPressed: () {
                          navigatorKey.currentState?.pop();
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //*********************** */
  checkPriceChange() {
    if (sellingPriceCtrl.text.isNotEmpty &&
        newsellingPriceCtrl.text.isNotEmpty) {
      // double sellingPrice = double.tryParse(sellingPriceCtrl.text.trim()) ?? 0;
      double newsellingPrice =
          double.tryParse(newsellingPriceCtrl.text.trim()) ?? 0;
      double cost = double.tryParse(costCtrl.text.trim()) ?? 0;

      if (newsellingPrice > 0 && newsellingPrice > cost) {
        showSaveButton.value = true;
      } else {
        showSaveButton.value = false;
      }
      //if(newsellingPrice>0 || newsellingPrice>){  showSaveButton.value = false;}
    }
  }

  //********************************** */
  validate(BuildContext context) async {
    if (barcodeCtrl.text.trim().isEmpty) {
      showSnackbar("Select Product", context);
      return;
    }
    int print = int.tryParse(printCountCtrl.text.trim()) ?? 1;
    if (print > 99) {
      showSnackbar("Enter valid  print count", context);
      return;
    }

    try {
      transparantDialog(context);
      // double oldPrice = double.tryParse(sellingPriceCtrl.text.trim()) ?? 0;
      double newPrice = double.tryParse(newsellingPriceCtrl.text.trim()) ?? 0;
      double cost = double.tryParse(costCtrl.text.trim()) ?? 0;

      int flag = newPrice > 0 && newPrice > cost ? 1 : 0;

      int printCount = printCountCtrl.text.trim().isNotEmpty
          ? int.tryParse(printCountCtrl.text.trim()) ?? 0
          : 1;
// if (newPrice <= 0){
//   showSaveButton.value = false;
// }
      if (flag == 1) {
        await widget.database.insertprintbarcode(
            barcodeCtrl.text.trim(),
            itemnameCtrl.text.trim(),
            newsellingPriceCtrl.text.trim(),
            printCount,
            printDateTimeFormat());
      }
      // if (flag == 1 ) {
      //   await widget.database.insertprintbarcode(
      //       barcodeCtrl.text.trim(),
      //       itemnameCtrl.text.trim(),
      //       newsellingPriceCtrl.text.trim(),
      //       printCount,
      //       printDateTimeFormat());
      // }

      Map lastPrint = {
        "barcode": barcodeCtrl.text.trim(),
        "itemname": itemnameCtrl.text.trim(),
        "rate": flag == 1
            ? newsellingPriceCtrl.text.trim()
            : sellingPriceCtrl.text.trim(),
        "printcount": printCount,
        "printdatetime": printDateTimeFormat(),
      };
      if (flag == 1) {
        await widget.database
            .updateItemCashPrice(barcodeCtrl.text.trim(), newPrice);
      }
      // List prints =
      //     printBarcode ? await widget.database.getAllbarcodePrint() : [];

      Map res = await ApiRepository().uploadAllData(
          context: context,
          database: widget.database,
          isBarcodePrint: true,
          barcodePrint: lastPrint,
          flag: flag);
      if (res["status"] == "success") {
        navigatorKey.currentState?.pop();
        barcodeCtrl.text = "";
        itemcodeCtrl.text = "";
        itemnameCtrl.text = "";
        pcspertypeCtrl.text = "";
        costCtrl.text = "";
        categoryCtrl.text = "";
        sellingPriceCtrl.text = "";
        newsellingPriceCtrl.text = "";
        qtytypeCtrl.text = "";
        showSaveButton.value = false;
        printCountCtrl.text = "";
        focusBarcode.requestFocus();

        showSnackbar("Price Updated", context);
      } else {
        navigatorKey.currentState?.pop();
        showSnackbar("Failed to update price", context);
      }
    } catch (e) {
      log(e.toString());
      navigatorKey.currentState?.pop();
      showSnackbar("Failed to update price", context);
    }
  }

  //****************************************  */
  scanBarcode(DB database) async {
    String scanResult = "";
    scanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // color of the scan line
      'Cancel', // cancel button text
      true, // show the flash icon
      ScanMode.BARCODE, // scan mode
    );
    if (scanResult.isNotEmpty && scanResult != "-1") {
      transparantDialog(context);
      Map res = await ApiRepository()
          .getProductByBarcode(context, scanResult.trim(), database);
      if (res["status"] == "success") {
        BarcodeProductModel product = res["product"];
        focusPrintCount.requestFocus();
        barcodeCtrl.text = product.barcode;
        itemcodeCtrl.text = product.itemcode;
        itemnameCtrl.text = product.itemname;
        pcspertypeCtrl.text = product.pcspertype;
        costCtrl.text = product.cost;
        categoryCtrl.text = product.categoryname;
        sellingPriceCtrl.text = product.sp;
        qtytypeCtrl.text = product.qtype;
        newsellingPriceCtrl.text = product.sp;
        showSaveButton.value = false;

        navigatorKey.currentState?.pop();
      } else {
        barcodeCtrl.text = scanResult;
        itemcodeCtrl.text = "";
        itemnameCtrl.text = "";
        pcspertypeCtrl.text = "";
        costCtrl.text = "";
        categoryCtrl.text = "";
        sellingPriceCtrl.text = "";
        qtytypeCtrl.text = "";
        newsellingPriceCtrl.text = "";
        navigatorKey.currentState?.pop();
        showNoProductDialog(context);
      }
    }
  }

//**************************************************** */
  searchBarcode(String barcode, DB database) async {
    if (barcode.isNotEmpty) {
      transparantDialog(context);
      Map res = await ApiRepository()
          .getProductByBarcode(context, barcode.trim(), database);
      if (res["status"] == "success") {
        BarcodeProductModel product = res["product"];
        focusPrintCount.requestFocus();

        // barcodeCtrl.text = product.barcode;
        itemcodeCtrl.text = product.itemcode;
        itemnameCtrl.text = product.itemname;
        pcspertypeCtrl.text = product.pcspertype;
        costCtrl.text = product.cost;
        categoryCtrl.text = product.categoryname;
        sellingPriceCtrl.text = product.sp;
        qtytypeCtrl.text = product.qtype;
        newsellingPriceCtrl.text = product.sp;
        showSaveButton.value = false;

        navigatorKey.currentState?.pop();
      } else {
        barcodeCtrl.text = barcode;
        itemcodeCtrl.text = "";
        itemnameCtrl.text = "";
        pcspertypeCtrl.text = "";
        costCtrl.text = "";
        categoryCtrl.text = "";
        sellingPriceCtrl.text = "";
        qtytypeCtrl.text = "";
        navigatorKey.currentState?.pop();
        newsellingPriceCtrl.text = "";
        showNoProductDialog(context);
         barcodeCtrl.text = "";
      }
    }
  }

  //*********************************************** */

  void showNoProductDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.search_off,
                  size: 50,
                  color: Colors.red,
                ),
                SizedBox(height: 16),
                Text(
                  'No Product Found',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Automatically close the dialog after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
}
