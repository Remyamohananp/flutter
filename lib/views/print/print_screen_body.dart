import 'dart:developer';
import 'dart:ui';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/item_master_controller.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/repository/api_repository.dart';
import 'package:qr_scanner/utils/items_dropdown.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/print_date_format.dart';
import 'package:qr_scanner/utils/scan_barcode.dart';
import 'package:qr_scanner/utils/snackbar.dart';
import 'package:qr_scanner/views/homescreen_body.dart';
import 'package:qr_scanner/views/print/print_screen_modal_sheet.dart';




class PrintScreenBody extends StatefulWidget {

  final bool isServerRemote;
  final DB database;
  final TextEditingController barcodeCtrl;
  final TextEditingController qtytypeCtrl;
  final TextEditingController pcsCtrl;
  final TextEditingController priceCtrl;
  final TextEditingController printCountCtrl;
  final TextEditingController itemnameCtrl;
  final SingleSelectController<Map?> itemDropCtrl;

  final List<Map> items;
  Map? selectedItem;
  PrintScreenBody(
      {super.key,
      required this.selectedItem,
      required this.isServerRemote,
      required this.itemnameCtrl,
      required this.barcodeCtrl,
      required this.database,
      required this.qtytypeCtrl,
      required this.pcsCtrl,
      required this.priceCtrl,
      required this.printCountCtrl,

      required this.itemDropCtrl,
      required this.items});

  @override
  State<PrintScreenBody> createState() => _PrintScreenBodyState();
}

class _PrintScreenBodyState extends State<PrintScreenBody> {
  final FocusNode focusBarcode = FocusNode();
  final FocusNode focusPrint = FocusNode();

  @override
  void initState() {
    focusBarcode.requestFocus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      final Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: field(
                  context: context,
                  cntr: widget.barcodeCtrl,
                  focusnode: focusBarcode,
                  txt: "Barcode",
                  onFieldSubmitted: (p0) {
                    // context.read<ItemMasterController>().init();

                    String barcode = widget.barcodeCtrl.text.trim();
                    getLocalProductDetailsFromitemmaster(
                      widget.isServerRemote,
                      barcode,
                      widget.database,
                      context,
                    ); focusPrint.requestFocus();

                  },
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
                  // startBarcodeScan(context, isServerRemote, database);
                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    context.read<ItemMasterController>().init();
                  });

                  startBarcodeScanFromItemmaster(
                      context, widget.isServerRemote, widget.database);
                  focusPrint.requestFocus();
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
          height: 16,
        ),
        // ItemsDropdown(
        //   item: widget.selectedItem,
        //   ctrl: widget.itemDropCtrl,
        //   items: widget.items,
        //   onValueChanged: (p0) {
        //     // context.read<ItemMasterController>().init();
        //     widget.itemnameCtrl.text = p0 != null ? p0['barcodespname'] : "";
        //
          //   getLocalProductDetailsFromitemmasterbyname(
        //       widget.isServerRemote,
        //       widget.itemnameCtrl.text,
        //       widget.items,
        //       widget.database,
        //       context,
        //     );
        //     focusPrint.requestFocus();
        //   },
        // ),
        // field(
        //     context: context,
        //     cntr: itemNameCtrl,
        //     txt: "Item Name",
        //     number: true,
        //     isRead: true),

  
        // Row(
        //   children: [
        //     field(
        //         context: context,
        //         cntr: widget.itemnameCtrl,
        //         txt: "Item Name",
        //         isRead: true),


        //     SizedBox(
        //       width: 3,
        //     ),
        //     ElevatedButton(
        //         style: ElevatedButton.styleFrom(
        //             foregroundColor: Colors.white,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(10)),
        //             backgroundColor: Colors.black),
        //         onPressed: () async {
        //       //      getLocalProductDetailsFromitemmasterbyname(
        //       // widget.isServerRemote,
        //       // widget.itemnameCtrl.text,
        //       // widget.items,
        //       // widget.database,
        //       // context,
        //    // );
        //         },
        //         child: const Icon(Icons.menu)),
        //   ],

        // ),
        Row(
          children: [
            Expanded(
              child: field(
                  context: context,
                  cntr: widget.itemnameCtrl,
                  txt: "Item Name",
                  number: true,
                  isRead: true),
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
                  showSearch(
                    context: context,
                    delegate: ItemsList(
                        widget.items,
                        widget.barcodeCtrl,
                        widget.itemnameCtrl,
                        widget.qtytypeCtrl,
                        widget.pcsCtrl,
                        widget.priceCtrl),
                  );
                },
                child: Icon(Icons.list)),
          ],
        ),

        const SizedBox(
          height: 16,
        ),
        field(
            context: context,
            cntr: widget.qtytypeCtrl,
            txt: "Qtytype",
            number: true,
            isRead: true),
        const SizedBox(
          height: 16,
        ),
        field(
            context: context,
            cntr: widget.pcsCtrl,
            txt: "Pcs",
            number: true,
            isRead: true),
        const SizedBox(
          height: 16,
        ),
        field(
          isRead: true,
          context: context,
          cntr: widget.priceCtrl,
          txt: "Price",
          number: true,
        ),
        const SizedBox(
          height: 16,
        ),
        field(
            context: context,
            focusnode: focusPrint,
            cntr: widget.printCountCtrl,
            txt: "Print Count",
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
                      validate(
                        context,
                      );
                    },
                    child: const Text("Print"))),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.red.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    widget.barcodeCtrl.text = "";
                    widget.itemDropCtrl.clear();
                    widget.qtytypeCtrl.text = "";
                    widget.itemnameCtrl.text = "";
                    widget.pcsCtrl.text = "";
                    widget.priceCtrl.text = "";
                    widget.printCountCtrl.text = "";
                   // showAlertDialog(context);
                    focusBarcode.requestFocus();
                  },
                  child: const Text("Clear")),
            ),
            const SizedBox(
              width: 12,
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
    );
  }

  //validate
  validate(BuildContext context) async {
    int printCountCtrl = int.tryParse(widget.printCountCtrl.text.trim()) ?? 1;
    if (printCountCtrl > 99) {
      showSnackbar("Enter valid  print count", context);
      return;
    }
    try {
      transparantDialog(context);
      log(widget.itemnameCtrl.text.trim());
      await widget.database.insertprintbarcode(
          widget.barcodeCtrl.text.trim(),
          widget.itemnameCtrl.text.trim(),
          widget.priceCtrl.text.trim(),
          widget.printCountCtrl.text.isEmpty
              ? 1
              : int.parse(widget.printCountCtrl.text.trim()),
          printDateTimeFormat());
      List prints = await widget.database.getAllbarcodePrint();
      Map res = await ApiRepository().uploadAllData(
          context: context,
          database: widget.database,
          isBarcodePrint: true,
          barcodePrint: prints.last,
          flag: 0);

      if (res["status"] == "success") {
        navigatorKey.currentState?.pop();
        // WidgetsBinding.instance.addPostFrameCallback((timestamp) {
        // context.read<ItemMasterController>().init();

        // });
        // ItemMasterController().init();
        showSnackbar("Uploaded data successfully", context);
        widget.database.clearAllBarcodePrint();
        widget.qtytypeCtrl.text = "";
        widget.pcsCtrl.text = "";
        widget.barcodeCtrl.text = "";
        widget.itemDropCtrl.clear();

        widget.itemnameCtrl.text = "";
        widget.pcsCtrl.text = "";
        widget.priceCtrl.text = "";
        widget.printCountCtrl.text = "";
        focusBarcode.requestFocus();
      } else {
        navigatorKey.currentState?.pop();
        showSnackbar("Failed to upload", context);
      }
    } catch (e) {
      log(e.toString());
      navigatorKey.currentState?.pop();
      showSnackbar("Failed to upload", context);
    }
  }

  //*************************************** clear data alert */
  void showAlertDialog(
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
                "Are you sure to clear?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white),
                    child: const Text('Yes'),
                    onPressed: () async {
                      // WidgetsBinding.instance.addPostFrameCallback((timestamp) {
                      context2.read<ItemMasterController>().init();
                      // });
                      widget.barcodeCtrl.text = "";
                      widget.itemDropCtrl.clear();
                      widget.qtytypeCtrl.text = "";
                      widget.itemnameCtrl.text = "";
                      widget.pcsCtrl.text = "";
                      widget.priceCtrl.text = "";
                      widget.printCountCtrl.text = "";
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white),
                    child: const Text('No'),
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
}
