import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/item_master_controller.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/utils/change_textfield_focus.dart';
import 'package:qr_scanner/utils/items_dropdown.dart';
import 'package:qr_scanner/utils/scan_barcode.dart';

import '../../utils/snackbar.dart';
import '../print/print_screen_modal_sheet.dart';
import 'grn_popUp_modal_sheet.dart';

class GrnPopUpFormBody extends StatefulWidget {
  final List<Map> items;
  final TextEditingController barcodeCtrl;
  final TextEditingController qtytypeCtrl;
  final TextEditingController itemnameCtrl;
  final TextEditingController pcsCtrl;
  final TextEditingController qtyCtrl;
  final TextEditingController focCtrl;
  final TextEditingController costCtrl;
  final SingleSelectController<Map?> itemDropCtrl;
  Map? selectedItem;
  final FocusNode focus1;
  final FocusNode focus2;
  final FocusNode focus3;
  final bool isServerRemote;
  final DB database;
  GrnPopUpFormBody(
      {super.key,
      required this.barcodeCtrl,
      required this.items,
      required this.focus1,
      required this.focus3,
      required this.focus2,
      required this.costCtrl,
      required this.qtytypeCtrl,
      required this.itemnameCtrl,
      required this.pcsCtrl,
      required this.qtyCtrl,
      required this.itemDropCtrl,
      required this.focCtrl,
      required this.isServerRemote,
      required this.selectedItem,
      required this.database});

  @override
  State<GrnPopUpFormBody> createState() => _GrnPopUpFormBodyState();
}

class _GrnPopUpFormBodyState extends State<GrnPopUpFormBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.focus1.requestFocus();
    });
    widget.focus1.addListener(() {
      if (!widget.focus1.hasFocus) {
        // Run your function here
        onUnfocus();
      }
    });
  }

  // @override
  // void dispose() {
  //   widget.focus1.dispose();
  //   widget.focus2.dispose();
  //   widget.focus3.dispose();
  //   super.dispose();
  // }

  void onUnfocus() {
    // Your function logic here
    // if (widget.barcodeCtrl.text.trim().isNotEmpty) {
    //   String barcode = widget.barcodeCtrl.text.trim();
    //   getLocalProductDetailsFromitemmaster(
    //       widget.isServerRemote, barcode, widget.database, context,
    //       focus: widget.focus1);
    //   changeFocus(context, widget.focus1, widget.focus2);
    // }
    log('TextFormField lost focus');
  }

  // final FocusNode _focus1 = FocusNode();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Item Details",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: field(
                  onEditingCompleted: () {
                    WidgetsBinding.instance.addPostFrameCallback((t) {
                      context.read<ItemMasterController>().init();
                    });
                    String barcode = widget.barcodeCtrl.text.trim();
                    getLocalProductDetailsFromitemmaster(widget.isServerRemote,
                        barcode, widget.database, context,
                        focus: widget.focus1);
                    changeFocus(context, widget.focus1, widget.focus2);
                  },
                  onFieldSubmitted: (p0) {
                    WidgetsBinding.instance.addPostFrameCallback((t) {
                      context.read<ItemMasterController>().init();
                    });
                    String barcode = widget.barcodeCtrl.text.trim();
                    getLocalProductDetailsFromitemmaster(widget.isServerRemote,
                        barcode, widget.database, context,
                        focus: widget.focus1);
                    changeFocus(context, widget.focus1, widget.focus2);
                    log('TextFormField lost focus');
                  },
                  focusnode: widget.focus1,
                  cntr: widget.barcodeCtrl,
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<ItemMasterController>().init();
                  });
                  // startBarcodeScan(context, isServerRemote, database);
                  startBarcodeScanFromItemmaster(
                      context, widget.isServerRemote, widget.database,
                      focus: widget.focus1);
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
        // const SizedBox(
        //   height: 6,
        // ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(10)),
        //               backgroundColor: Colors.black,
        //               foregroundColor: Colors.white),
        //           onPressed: () {
        //             if (barcodeCtrl.text.trim().isNotEmpty) {
        //               // getLocalProductBySearch(isServerRemote,
        //               //     barcodeCtrl.text.trim(), database, context);
        //               getLocalProductDetailsFromitemmaster(isServerRemote,
        //                   barcodeCtrl.text.trim(), database, context);
        //             } else {
        //               showSnackbar("Enter barcode", context);
        //             }
        //           },
        //           child: Icon(Icons.search)),
        //     ),
        //     const SizedBox(
        //       width: 12,
        //     ),
        //     Expanded(
        //       child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //               backgroundColor: Colors.black,
        //               foregroundColor: Colors.white,
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(10))),
        //           onPressed: () {
        //             // startBarcodeScan(context, isServerRemote, database);
        //             startBarcodeScanFromItemmaster(
        //                 context, isServerRemote, database);
        //           },
        //           child: Padding(
        //             padding: const EdgeInsets.all(0.0),
        //             child: Image.asset(
        //               "assets/qr-code.png",
        //               height: 30,
        //               width: 30,
        //               color: Colors.white,
        //             ),
        //           )),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 12,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //         child: ItemsDropdown(
        //       item: widget.selectedItem,
        //       ctrl: widget.itemDropCtrl,
        //       items: widget.items,
        //       onValueChanged: (p0) {
        //         WidgetsBinding.instance.addPostFrameCallback((_) {
        //           context.read<ItemMasterController>().init();
        //         });
        //         widget.itemnameCtrl.text = p0 != null ? p0['mastername'] : "";
        //         bool isServerRemote = false;
        //         widget.itemnameCtrl.text = widget.itemDropCtrl.value != null
        //             ? widget.itemDropCtrl.value!['mastername']
        //             : "";
        //         widget.selectedItem = widget.itemDropCtrl.value != null
        //             ? widget.itemDropCtrl.value
        //             : null;
        //         getLocalProductDetailsFromitemmasterbyname(
        //             isServerRemote,
        //             widget.itemnameCtrl.text.trim(),
        //             widget.items,
        //             widget.database,
        //             context);
        //         widget.focus2.requestFocus();
        //       },
        //     )
        //         // field(
        //         //     cntr: itemnameCtrl, context: context, txt: "ITEM NAME")
        //         ),
        //     // SizedBox(
        //     //   width: 8,
        //     // ),
        //     // ElevatedButton(
        //     //     style: ElevatedButton.styleFrom(
        //     //         foregroundColor: Colors.white,
        //     //         shape: RoundedRectangleBorder(
        //     //             borderRadius: BorderRadius.circular(10)),
        //     //         backgroundColor: Colors.black),
        //     //     onPressed: () {
        //     //       // getLocalProductBySearch(
        //     //       //     isServerRemote, barcodeCtrl.text.trim(), database, context);
        //     //     },
        //     //     child: const Icon(Icons.search)),
        //   ],
        // ),
        // field(
        //     cntr: widget.itemnameCtrl,
        //     context: context,
        //     txt: "Item name",
        //     isRead: true),
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
                    delegate: ItemsListGrn(
                        widget.items,
                        widget.barcodeCtrl,
                        widget.itemnameCtrl,
                        widget.qtytypeCtrl,
                        widget.pcsCtrl,
                        widget.focCtrl,
                        widget.qtyCtrl,
                        widget.costCtrl
                       ),
                  );
                },
                child: Icon(Icons.list)),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        field(
            cntr: widget.qtytypeCtrl,
            context: context,
            txt: "Qty type",
            isRead: true),
        const SizedBox(
          height: 12,
        ),
        field(cntr: widget.pcsCtrl, context: context, txt: "Pcs", isRead: true),
        const SizedBox(
          height: 12,
        ),

        field(
          cntr: widget.costCtrl,
          context: context,
          txt: "Cost",
          number: true,
        ),
        const SizedBox(
          height: 16,
        ),
        field(
          cntr: widget.qtyCtrl,
          context: context,
          txt: "Qty",
          number: true,
          focusnode: widget.focus2,
          onFieldSubmitted: (p0) =>
              changeFocus(context, widget.focus2, widget.focus3),
        ),
        const SizedBox(
          height: 12,
        ),
        field(
            cntr: widget.focCtrl,
            context: context,
            txt: "Foc",
            number: true,
            onFieldSubmitted: (p0) => widget.focus3.unfocus(),
            focusnode: widget.focus3),
      ],
    );
  }
}
