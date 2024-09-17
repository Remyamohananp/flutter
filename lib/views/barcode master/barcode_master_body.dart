import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/barcode_master_controller.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/utils/categories_dropdown.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/scan_barcode.dart';
import 'package:qr_scanner/utils/snackbar.dart';

import '../../db services/db_services.dart';

class BarcodeMAsterBody extends StatelessWidget {
  final String server;
  final DB database;
  final bool isServerRemote;
  final TextEditingController barcodeCtrl;
  final TextEditingController barcodeSpecificNameCtrl;
  final TextEditingController cashPriceAfterTaxCtrl;
  final TextEditingController masteritemnameCtrl;
  final TextEditingController categorynameCtrl;
  final TextEditingController retailPriceAfterTaxCtrl;
  final TextEditingController creditPriceAfterTaxCtrl;
  final TextEditingController itemCodeCtrl;
  final TextEditingController categoryIdCtrl;
  final SingleSelectController<Map?> ctrl;
  Map? selectedCategory;
  final List<Map> categories;
  final Function(Map? cat) onvalueChanged;
  BarcodeMAsterBody(
      {super.key,
      required this.categories,
      required this.selectedCategory,
      required this.isServerRemote,
      required this.onvalueChanged,
      required this.database,
      required this.server,
      required this.barcodeCtrl,
      required this.barcodeSpecificNameCtrl,
      required this.cashPriceAfterTaxCtrl,
      required this.masteritemnameCtrl,
      required this.categorynameCtrl,
      required this.retailPriceAfterTaxCtrl,
      required this.creditPriceAfterTaxCtrl,
      required this.itemCodeCtrl,
      required this.categoryIdCtrl,
      required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                // getLocalProductBySearch(
                //     isServerRemote, barcodeCtrl.text.trim(), database, context,
                //     isBarcodeMaster: true);
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
                // startBarcodeScan(context, isServerRemote, database,
                //     isBarcodeMaster: true);
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
        field(
          cntr: itemCodeCtrl,
          context: context,
          txt: "ITEM CODE",
        ),
        const SizedBox(
          height: 16,
        ),
        field(
          cntr: masteritemnameCtrl,
          context: context,
          txt: "ITEM MASTER NAME",
        ),
        const SizedBox(
          height: 16,
        ),
        field(
            onchanged: (v) {
              if (v.isNotEmpty) {
                ctrl.clear();
                List<Map> s = categories
                    .where((e) => e["categoryid"].toString().toLowerCase() == v)
                    .toList();
                if (s.isNotEmpty) {
                  // selectedCategory = s[0];
                  onvalueChanged(s[0]);
                  ctrl.value = s[0];
                }
              }
            },
            number: true,
            cntr: categoryIdCtrl,
            context: context,
            txt: "CATEGORY ID"),
        const SizedBox(
          height: 16,
        ),
        CategoriesDropdown(
          ctrl: ctrl,
          categories: categories,
          onValueChanged: (p0) {
            // log(p0.toString());
            if (p0 != null) {
              categoryIdCtrl.text = p0["categoryid"].toString();
              selectedCategory = p0;
              // onvalueChanged(p0);
            }
          },
        ),
        // field(
        //   cntr: categorynameCtrl,
        //   context: context,
        //   txt: "CATEGORY NAME",
        // ),
        const SizedBox(
          height: 16,
        ),
        field(
          cntr: barcodeSpecificNameCtrl,
          context: context,
          txt: "BARCODE SPECIFIC NAME",
        ),
        const SizedBox(
          height: 16,
        ),
        field(
            cntr: cashPriceAfterTaxCtrl,
            context: context,
            txt: "CASH PRICE AFTER TAX",
            number: true),
        const SizedBox(
          height: 16,
        ),
        field(
            cntr: creditPriceAfterTaxCtrl,
            context: context,
            txt: "CREDIT PRICE AFTER TAX",
            number: true),
        const SizedBox(
          height: 16,
        ),
        field(
            cntr: retailPriceAfterTaxCtrl,
            context: context,
            txt: "RETAIL PRICE AFTER TAX",
            number: true),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    validation(context);
                  },
                  child: const Text("Update")),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.red.shade800,
                    foregroundColor: const Color.fromARGB(255, 231, 172, 172),
                  ),
                  onPressed: () {
                    barcodeCtrl.text = "";
                    barcodeSpecificNameCtrl.text = "";
                    cashPriceAfterTaxCtrl.text = "";
                    masteritemnameCtrl.text = "";
                    categorynameCtrl.text = "";
                    retailPriceAfterTaxCtrl.text = "";
                    creditPriceAfterTaxCtrl.text = "";
                    itemCodeCtrl.text = "";
                    categorynameCtrl.text = "";
                    selectedCategory = null;
                    categoryIdCtrl.text = "";
                    ctrl.clear();
                    onvalueChanged(null);

                    context.read<BarcodeMasterController>().init();
                  },
                  child: const Text("Clear")),
            ),
          ],
        )
      ],
    );
  }

  //***************************************** validation */
  validation(BuildContext context) async {
    if (barcodeCtrl.text.trim().isEmpty) {
      showSnackbar("Select Product", context);
      return;
    }
    if (itemCodeCtrl.text.trim().isEmpty) {
      showSnackbar("Item code is empty", context);
      return;
    }
    if (masteritemnameCtrl.text.trim().isEmpty) {
      showSnackbar("Master item name is empty", context);
      return;
    }
    if (selectedCategory == null) {
      showSnackbar("Select category", context);
      return;
    }
    if (barcodeSpecificNameCtrl.text.trim().isEmpty) {
      showSnackbar("Barcode specific name is empty", context);
      return;
    }
    if (cashPriceAfterTaxCtrl.text.trim().isEmpty) {
      showSnackbar("Cash price after tax is empty", context);
      return;
    }
    if (creditPriceAfterTaxCtrl.text.trim().isEmpty) {
      showSnackbar("Credit price after tax is empty", context);
      return;
    }
    if (retailPriceAfterTaxCtrl.text.trim().isEmpty) {
      showSnackbar("Retail price after tax is empty", context);
      return;
    }
    try {
      transparantDialog(context);
      await database.insertBarcodeMaster(
        barcodeCtrl.text.trim(),
        barcodeSpecificNameCtrl.text.trim(),
        double.parse(cashPriceAfterTaxCtrl.text.trim()),
        double.parse(creditPriceAfterTaxCtrl.text.trim()),
        double.parse(retailPriceAfterTaxCtrl.text.trim()),
        selectedCategory!["categoryid"],
        masteritemnameCtrl.text.trim(),
        itemCodeCtrl.text.trim(),
      );
      navigatorKey.currentState?.pop();
      barcodeCtrl.text = "";
      barcodeSpecificNameCtrl.text = "";
      cashPriceAfterTaxCtrl.text = "";
      masteritemnameCtrl.text = "";
      categorynameCtrl.text = "";
      retailPriceAfterTaxCtrl.text = "";
      creditPriceAfterTaxCtrl.text = "";
      itemCodeCtrl.text = "";
      categorynameCtrl.text = "";
      selectedCategory = null;
      onvalueChanged(null);

      ctrl.clear();
      context.read<BarcodeMasterController>().init();

      showSnackbar("Barcode Master added Successfully", context);
    } catch (e) {
      navigatorKey.currentState?.pop();
      showSnackbar("Barcode Master Failed to add", context);
    }
  }
}
