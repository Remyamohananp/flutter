import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
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

import '../../utils/storemaster_dropdown.dart';

class PhysicalStockOnline extends StatefulWidget {
  final DB database;

  PhysicalStockOnline({super.key, required this.database});

  @override
  State<PhysicalStockOnline> createState() => _PhysicalStockOnlineState();
}

class _PhysicalStockOnlineState extends State<PhysicalStockOnline> {
  final FocusNode focusBarcode = FocusNode();
  final FocusNode focusPrintCount = FocusNode();

  final TextEditingController barcodeCtrl = TextEditingController();
  final TextEditingController storecodeCtrl = TextEditingController();
  final TextEditingController itemcodeCtrl = TextEditingController();

  final TextEditingController itemnameCtrl = TextEditingController();

  final TextEditingController categoryCtrl = TextEditingController();

  final TextEditingController pcspertypeCtrl = TextEditingController();

  final TextEditingController qtytypeCtrl = TextEditingController();

  final TextEditingController costCtrl = TextEditingController();

  final TextEditingController sellingPriceCtrl = TextEditingController();
  final TextEditingController currentstockCtrl = TextEditingController();
  final TextEditingController replacingCtrl = TextEditingController();
  final TextEditingController addcurrCtrl = TextEditingController();
  ValueNotifier<bool> showSaveButton = ValueNotifier(false);
  List<Map> storemaster = [];
  late SingleSelectController<Map?> storeMasterCtrl;

  Map? selectedstorecode;

  @override
  void initState() {
    focusBarcode.requestFocus();
    focusBarcode.addListener(() {
      if (!focusBarcode.hasFocus) {
        // Run your function here
      }
    });

    super.initState();
    storeMasterCtrl = SingleSelectController<Map?>(null);
    loadStoreData();
  }

  Future<void> loadStoreData() async {
    try {
      List<dynamic> storeDataDynamic =
          await widget.database.getAllstoremaster();

      List<Map<String, dynamic>> storeData =
          storeDataDynamic.cast<Map<String, dynamic>>();
      print(storeData);
      setState(() {
        storemaster = storeData;
      });
    } catch (e) {
      log('Failed to load store data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Physical Stock (Online)"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 12),
          child: Column(
            children: [
              storemasterdropdown(
                ctrl: storeMasterCtrl,
                storemaster: storemaster,
                onValueChanged: (p0) {
                  log(p0.toString());
                  if (p0 != null) {
                    storecodeCtrl.text = p0["storecode"].toString();
                    selectedstorecode = p0;
                  }
                },
              ),

              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: field(
                        onEditingCompleted: () {
                          int storecode =
                              int.tryParse(storecodeCtrl.text.trim()) ?? 0;
                          searchBarcode(barcodeCtrl.text.trim(),
                              widget.database, storecode);
                        },
                        // onFieldSubmitted: (p0) {
                        //   searchBarcode(p0, widget.database,storecode);
                        // },
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
                        int storecode =
                            int.tryParse(storecodeCtrl.text.trim()) ?? 0;
                        searchBarcode(
                            barcodeCtrl.text, widget.database, storecode);
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
              // field(
              //     cntr: costCtrl, context: context, txt: "Cost", isRead: true),
              // const SizedBox(
              //   height: 12,
              // ),
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
                          // checkPriceChange();
                        },
                        cntr: currentstockCtrl,
                        context: context,
                        txt: "Current Stock",
                        number: true),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              field(
                  focusnode: focusPrintCount,
                  cntr: replacingCtrl,
                  context: context,
                  txt: "Replacing stock",
                  number: true),
              const SizedBox(
                height: 12,
              ),
              field(
                  focusnode: focusPrintCount,
                  cntr: addcurrCtrl,
                  context: context,
                  txt: "Add to current stock",
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

                          // isPrintBarcode.value = false;

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

  validate(BuildContext context) async {}

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
        currentstockCtrl.text = product.sp;

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
        currentstockCtrl.text = "";
        navigatorKey.currentState?.pop();
        showNoProductDialog(context);
      }
    }
  }

//**************************************************** */
  searchBarcode(String barcode, DB database, int storecode) async {
    if (barcode.isNotEmpty) {
      transparantDialog(context);
      Map res = await ApiRepository().getbarcodedetailswithStock(
          context, barcode.trim(), database, storecode);
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
        currentstockCtrl.text = product.custock;
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
        currentstockCtrl.text = "";
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
