import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/item_master_controller.dart';
import 'package:qr_scanner/controller/product_controller.dart';
import 'package:qr_scanner/controller/stock_controller.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/utils/change_textfield_focus.dart';
import 'package:qr_scanner/utils/download_all_data.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/snackbar.dart';
import 'package:qr_scanner/utils/vendor_dropdown.dart';
import 'package:qr_scanner/views/GRN/po_number_modelsheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db services/db_services.dart';
import 'grv_popUp_form_body.dart';

class GrvFormBody extends StatefulWidget {
  final int lastGrvno;
  final String server;
  final bool isServerRemote;
  final TextEditingController grvDateCtrl;
  // final TextEditingController reasonCtrl;
  final TextEditingController remarkCtrl;
  final TextEditingController grvNoCtrl;
  final TextEditingController vendorIDCtrl;
  final TextEditingController vendorNameCtrl;
    SingleSelectController<Map?> ctrl;
  final TextEditingController grvRefCtrl;
  final TextEditingController returnedByCtrl;
  final DateTime grvDatePreselected;
  final DB database;
  final List<Map> vendors;
  final List<Map> items;
  final List<Map> gridDateList;


  GrvFormBody(
      {super.key,
      required this.items,
      required this.gridDateList,
        required this.server,
      required this.isServerRemote,
      required this.grvDateCtrl,
      required this.grvNoCtrl,
      required this.vendorIDCtrl,
      required this.vendorNameCtrl,
      required this.ctrl,
      required this.grvRefCtrl,
      required this.returnedByCtrl,
      required this.database,
      required this.vendors,
      required this. remarkCtrl,
        //required this. reasonCtrl,
      required this.grvDatePreselected,
      required this.lastGrvno});

  @override
  State<GrvFormBody> createState() => _GrvFormBodyState();
}

class _GrvFormBodyState extends State<GrvFormBody> {
  Map? selectedVendor;

  DateTime? selectedGrvDate;
  ValueNotifier<bool> showDelete = ValueNotifier(false);
  ValueNotifier<List<Map>> gridData = ValueNotifier([]);

  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();
  final FocusNode _focus3 = FocusNode();
  final FocusNode _focus4 = FocusNode();
  final FocusNode _focus5 = FocusNode();
  final FocusNode _focus6 = FocusNode();
  final FocusNode barcodefocus = FocusNode();
  final FocusNode qtyfocus = FocusNode();
  final FocusNode reasonfocus = FocusNode();



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gridData.value = widget.gridDateList;
      selectedGrvDate = widget.grvDatePreselected;
      _focus1.addListener(() {
        if (!_focus1.hasFocus) {
          // Run your function here
          onUnfocus();
        }
      });
      // .value = widget.grnNoCtrl.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _focus1.removeListener(onUnfocus);
    _focus1.dispose();
    super.dispose();
  }

  void onUnfocus() async {
    // Your function logic here
    if (widget.grvNoCtrl.text.trim().isNotEmpty) {
      showDelete.value = await searchGrv();
      if (showDelete.value == false) {
        widget.grvDateCtrl.text = "";
        widget.vendorIDCtrl.text = "";
        widget.vendorNameCtrl.text = "";

      
        widget.ctrl.clear();
        selectedVendor = null;
        selectedGrvDate = null;
        widget.grvRefCtrl.text = "";
        gridData.value = [];

        selectedGrvDate = DateTime.now();
        widget.grvDateCtrl.text =
            DateFormat('dd-MM-yyyy').format(selectedGrvDate!);

        showDelete.value = false;

        _focus1.requestFocus();
      }
      // currentGrnNo.value = p0;
      changeFocus(context, _focus1, _focus2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Server : ${widget.server}",
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        const SizedBox(
          height: 12,
        ),
        ExpansionTile(
          enabled: true,
          initiallyExpanded: true,
          shape: const Border(
            top: BorderSide(
              color: Colors.transparent,
            ),
            bottom: BorderSide(
              color: Colors.transparent,
            ),
          ),
          title: const Text(
            "Details",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          children: [
            // field(
            //   cntr: widget.grnNoCtrl,
            //   context: context,
            //   txt: "GRN NUMBER",
            //   onFieldSubmitted: (p0) => searchGrn(),
            // ),
            Row(
              children: [
                // Expanded(
                //   child: field(
                //     cntr: widget.grnNoCtrl,
                //     context: context,
                //     txt: "GRN NUMBER",
                //   ),
                // ),
                Expanded(
                  child: field(
                    number: true,
                    focusnode: _focus1,
                    onFieldSubmitted: (p0) async {
                      showDelete.value = await searchGrv();
                      if (showDelete.value == false) {
                        widget.grvDateCtrl.text = "";
                        widget.vendorIDCtrl.text = "";
                        widget.vendorNameCtrl.text = "";

                      
                        widget.ctrl.clear();
                        selectedVendor = null;
                        selectedGrvDate = null;
                        widget.grvRefCtrl.text = "";
                        gridData.value = [];

                        selectedGrvDate = DateTime.now();
                        widget.grvDateCtrl.text =
                            DateFormat('dd-MM-yyyy').format(selectedGrvDate!);
                        Navigator.of(context).pop();
                        showDelete.value = false;
                        _focus1.requestFocus();
                      }
                      changeFocus(context, _focus1, _focus2);
                    },
                    cntr: widget.grvNoCtrl,
                    context: context,
                    txt: "GRV NUMBER",
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.black),
                    onPressed: () async {
                      showDelete.value = await searchGrv();
                      if (showDelete.value == false) {
                        widget.grvDateCtrl.text = "";
                        widget.vendorIDCtrl.text = "";
                        widget.vendorNameCtrl.text = "";
                         widget.ctrl.clear();
                        selectedVendor = null;
                        selectedGrvDate = null;
                        widget.grvRefCtrl.text = "";
                        gridData.value = [];

                        selectedGrvDate = DateTime.now();
                        widget.grvDateCtrl.text =
                            DateFormat('dd-MM-yyyy').format(selectedGrvDate!);
                        Navigator.of(context).pop();
                        showDelete.value = false;
                        _focus1.requestFocus();
                      }
                      changeFocus(context, _focus1, _focus2);
                    },
                    child: const Icon(Icons.search)),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            field(
                onFieldSubmitted: (p0) =>
                    changeFocus(context, _focus2, _focus3),
                focusnode: _focus2,
                cntr: widget.grvRefCtrl,
                context: context,
                txt: "GRV REF"),
            const SizedBox(
              height: 16,
            ),
            // ValueListenableBuilder(
            //     valueListenable: showDelete,
            //     builder: (context, val, _) {
            //       return Row(
            //         children: [
            //           Expanded(
            //             // child: field(
            //             //     number: true,
            //             //     onFieldSubmitted: (p0) =>
            //             //         changeFocus(context, _focus3, _focus5),
            //             //     focusnode: _focus3,
            //             //     cntr: widget.poNoCtrl,
            //             //     context: context,
            //             //     txt: "PO NUMBER"),
            //           ),
            //           val
            //               ? const SizedBox.shrink()
            //               : const SizedBox(
            //                   width: 12,
            //                 ),
            //           val
            //               ? const SizedBox.shrink()
            //               : ElevatedButton(
            //                   style: ElevatedButton.styleFrom(
            //                       foregroundColor: Colors.white,
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(10)),
            //                       backgroundColor: Colors.black),
            //                   onPressed: () async {
            //                     if (gridData.value.isNotEmpty) {
            //                       showPonumberClearDialog(context, true, size);
            //                     } else {
            //                       ponumberBottomsheet(
            //                           context,
            //                           widget.poheaders,
            //                           widget.podetails,
            //                           widget.vendors,
            //                           widget.poNoCtrl,
            //                           widget.vendorIDCtrl,
            //                           widget.ctrl,
            //                           _focus4,
            //                           gridData,
            //                           size,
            //                           widget.database);
            //                     }
            //                   },
            //                   child: const Icon(Icons.menu)),
            //           val
            //               ? const SizedBox.shrink()
            //               : const SizedBox(
            //                   width: 12,
            //                 ),
            //           val
            //               ? const SizedBox.shrink()
            //               : ElevatedButton(
            //                   style: ElevatedButton.styleFrom(
            //                       foregroundColor: Colors.white,
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(10)),
            //                       backgroundColor: Colors.black),
            //                   onPressed: () async {
            //                     if (gridData.value.isNotEmpty) {
            //                       showPonumberClearDialog(context, false, size);
            //                     } else {
            //                       bool res = await searchPonumber();
            //                       if (res) {
            //                         changeFocus(context, _focus3, _focus4);
            //                       }
            //                     }
            //                   },
            //                   child: const Icon(Icons.search)),
            //         ],
            //       );
            //     }),
            const SizedBox(
              height: 16,
            ),
            field(
              focusnode: _focus4,
              cntr: widget.grvDateCtrl,
              context: context,
              txt: "GRV DATE",
              isRead: true,
              onFieldSubmitted: (p0) => changeFocus(context, _focus4, _focus5),
              onTap: () async {
                DateTime? _selectedDate = await showDatePicker(
                    context: context,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 3650)),
                    lastDate: DateTime.now());
                if (_selectedDate != null) {
                  selectedGrvDate = _selectedDate;
                  widget.grvDateCtrl.text =
                      DateFormat('dd-MM-yyyy').format(_selectedDate);
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                field(
                    onFieldSubmitted: (p0) =>
                        changeFocus(context, _focus5, _focus6),
                    focusnode: _focus5,
                    onchanged: (v) {
                      if (v.isNotEmpty) {
                        widget.ctrl.clear();
                        List<Map> s = widget.vendors
                            .where((e) =>
                                e["vendorid"].toString().toLowerCase() == v)
                            .toList();
                        if (s.isNotEmpty) {
                          selectedVendor = s[0];
                          widget.ctrl.value = s[0];
                        }
                      }
                    },
                    number: true,
                    cntr: widget.vendorIDCtrl,
                    context: context,
                    txt: "VENDOR ID"),
                const SizedBox(
                  height: 16,
                ),
                // field(cntr: vendorNameCtrl, context: context, txt: "VENDOR NAME"),
                VendorDropdown(
                  ctrl: widget.ctrl,
                  counters: widget.vendors,
                  onValueChanged: (p0) {
                    log(p0.toString());
                    if (p0 != null) {
                      widget.vendorIDCtrl.text = p0["vendorid"].toString();
                      selectedVendor = p0;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            field(
                focusnode: _focus6,
                onFieldSubmitted: (p0) => _focus6.unfocus(),
                cntr: widget.returnedByCtrl,
                context: context,
                txt: "RECIEVED BY",
                isRead: true),
                 const SizedBox(
              height: 16,
            ),
                field(
              onFieldSubmitted: (p0) => FocusScope.of(context).unfocus(),
              cntr: widget.remarkCtrl,
              context: context,
              txt: "Remark",
              isMultiline: true,
            ),
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                fixedSize: Size(size.width, 50)),
            onPressed: () {
              addItemsDialog(context, size, widget.isServerRemote, false, null,
                  null, widget.items);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text("Add Items"),
              ],
            )),
        const SizedBox(
          height: 8,
        ),
        Divider(
          color: Colors.grey.shade400,
        ),
        const SizedBox(
          height: 12,
        ),
        table(context, size, widget.isServerRemote),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.green.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    // await widget.database.getAllpoheader();
                    // await widget.database.getAllPoDetails();
                    //  SharedPreferences sp=await SharedPreferences.getInstance();
                    //  int grnno=sp.getInt(key);

                    int grv = widget.grvNoCtrl.text.trim().isNotEmpty
                        ? int.parse(widget.grvNoCtrl.text.trim())
                        : 0;
                    if (widget.grvRefCtrl.text.isNotEmpty ||
                      
                        gridData.value.isNotEmpty ||
                        widget.lastGrvno != grv) {
                      showAlertDialog(context);
                    }
                  },
                  child: const Text("New")),
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    validate(context, widget.isServerRemote);
                  },
                  child: const Text("Save")),
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
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Exit")),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        ValueListenableBuilder(
            valueListenable: showDelete,
            builder: (context, val, child) {
              return !val
                  ? const SizedBox.shrink()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.red.shade800,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        showAlertDialogToDeleteGrv(context);
                      },
                      child: const Text("Delete"));
            }),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

//************************************************** table */
  Widget table(
    BuildContext context,
    Size size,
    bool isServerRemote,
  ) {
    return ValueListenableBuilder(
      valueListenable: gridData,
      builder: (context, value, child) {
        List<DataRow> rows = [];
        for (int i = 0; i < value.length; i++) {
          Map current = value[i];
          DataRow data = DataRow(cells: [
            DataCell(Text((i + 1).toString())),
            DataCell(Text(current["barcode"])),
            DataCell(Text(current["itemname"])),
            DataCell(Text(current["qtytype"])),
            DataCell(Text(current["pcs"].toString())),
            DataCell(Text(current["qty"].toString())),
            DataCell(Text(current["reason"].toString())),
            DataCell(Text(current["cost"].toString())),
            DataCell(InkWell(
              child: const Icon(Icons.edit),
              onTap: () {
                addItemsDialog(context, size, isServerRemote, true, current, i,
                    widget.items);
              },
            )),
            DataCell(InkWell(
              onTap: () {
                List<Map> curDatAa = List.from(gridData.value);
                // curDatAa.removeWhere((e) =>
                //     e["barcode"].toLowerCase() ==
                //     current["barcode"].toLowerCase());
                curDatAa.removeAt(i);
                // curDatAa.removeWhere((e) =>
                // e["barcode"].toLowerCase() ==
                //     current["barcode"].toLowerCase() &&
                //     e["cost"].toString() ==
                //         current["cost"].toString()&&
                //     e["foc"].toString() ==
                //         current["foc"].toString()&&
                //     e["foc"].toString() ==
                //         current["foc"].toString()&&
                //     e["qty"].toString() ==
                //         current["qty"].toString());
                gridData.value = curDatAa;
              },
              child: Icon(
                Icons.close,
                color: Colors.red.shade800,
              ),
            )),
          ]);
          rows.add(data);
        }
        return value.isEmpty
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                child: DataTable(columns: const [
                  DataColumn(label: Text('Sl No')),
                  DataColumn(label: Text('Barcode')),
                  DataColumn(label: Text('Item name')),
                  DataColumn(label: Text('Qty type')),
                  DataColumn(label: Text('Pcs')),
                  DataColumn(label: Text('Qty')),
                  DataColumn(label: Text('reason')),
                  DataColumn(label: Text('Cost')),
                  DataColumn(label: Text("Action")),
                  DataColumn(label: Text("Action")),
                ], rows: rows),
              );
      },
    );
  }

  //***********************************************  */
  addItemsDialog(BuildContext context, Size size, bool isServerRemote,
      bool isEdit, Map? current, int? currentIndex, List<Map> items) {
    final TextEditingController barcodeCtrl = TextEditingController();
    final TextEditingController itemnameCtrl = TextEditingController();
    final TextEditingController qtytypeCtrl = TextEditingController();
    final TextEditingController qtyCtrl = TextEditingController();
    final TextEditingController pcsCtrl = TextEditingController();
    final TextEditingController reasonCtrl = TextEditingController();
    final TextEditingController costCtrl = TextEditingController();
    final SingleSelectController<Map?> itemDropCtrl =
        SingleSelectController(null);
    Map? selectedItem;

    if (isEdit) {
      for (var element in items) {
        if (element["barcodespname"].toString().toLowerCase() ==
            current!["itemname"].toString().toLowerCase()) {
          itemDropCtrl.value = element;

          selectedItem = element;
        }
      }
      costCtrl.text =
          current!["cost"] != null ? current!["cost"].toString() : "";
      barcodeCtrl.text = current!['barcode'] ?? "";
      itemnameCtrl.text = current["itemname"] ?? "";
      qtytypeCtrl.text = current["qtytype"] ?? "";
      selectedItem = current;
      pcsCtrl.text = current["pcs"] != null ? current["pcs"].toString() : "";
      qtyCtrl.text = current["qty"] != null ? current["qty"].toString() : "";
      reasonCtrl.text = current["reason"] != null ? current["reason"].toString() : "";
      // itemDropCtrl.value = current;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timestamp) {
        context.read<ProductController>().init();
        context.read<StockController>().init();
        context.read<ItemMasterController>().init();
        selectedItem = null;
        barcodeCtrl.text = "";
        itemDropCtrl.clear();
        qtyCtrl.text = "";
        pcsCtrl.text = "";
        qtytypeCtrl.text = "";
        reasonCtrl.text = "";
        costCtrl.text = "";
      });
    }
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              // border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //       spreadRadius: 3,
              //       blurRadius: 3,
              //       // blurStyle: BlurStyle.inner,
              //       color: Colors.grey.shade200
              //       // Color(0xff7090B0),
              //       ),
              // ]
            ),
            child: SingleChildScrollView(
              child: Consumer<ItemMasterController>(builder: (context, val, _) {
                allocateDataTotextfiledWhenscanned(
                  selectedItem: selectedItem,
                  itemDropCtrl: itemDropCtrl,
                  costCtrl: costCtrl,
                  barcodeCtrl: barcodeCtrl,
                  reasonCtrl: reasonCtrl,
                  isServerRemote: isServerRemote,
                  itemnameCtrl: itemnameCtrl,
                  pcsCtrl: pcsCtrl,
                  qtyCtrl: qtyCtrl,
                  // remote: remote,
                  val: val,
                  qtytypeCtrl: qtytypeCtrl,
                );
                return Column(
                  children: [
                    GrvPopUpFormBody(
                        focus1: barcodefocus,
                        focus2: qtyfocus,
                        focus3: reasonfocus,
                        selectedItem: selectedItem,
                        itemDropCtrl: itemDropCtrl,
                        items: items,
                        costCtrl: costCtrl,
                        barcodeCtrl: barcodeCtrl,
                        qtytypeCtrl: qtytypeCtrl,
                        itemnameCtrl: itemnameCtrl,
                        pcsCtrl: pcsCtrl,
                        qtyCtrl: qtyCtrl,
                         reasonCtrl: reasonCtrl,
                        isServerRemote: isServerRemote,
                        database: widget.database),
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
                                int qtyCountCtrl = int.tryParse(qtyCtrl.text.trim()) ?? 1;
                                if (qtyCountCtrl > 99999) {
                                  showSnackbar("Enter valid  quantity count", context);
                                  return;
                                }

                                if (barcodeCtrl.text.trim().isEmpty) {
                                  showSnackbar("Select product", context);
                                  return;
                                }
                                if (itemnameCtrl.text.trim().isEmpty) {
                                  showSnackbar("Item name is empty", context);
                                  return;
                                }
                                if (qtytypeCtrl.text.trim().isEmpty) {
                                  showSnackbar("Qty type is empty", context);
                                  return;
                                }
                                if (qtyCtrl.text.trim().isEmpty ) {
                                  showSnackbar(
                                      "Enter quantity  ", context);
                                  return;
                                }
                                if (reasonCtrl.text.trim().isEmpty) {
                                  showSnackbar("Select Reason", context);

                                  return;
                                }
                                if (costCtrl.text.trim().isEmpty) {
                                  showSnackbar("Enter cost", context);

                                  return;
                                }

                                transparantDialog(context);
                                try {
                                  List<Map> curData = List.from(gridData.value);

                                  Map current = {
                                    "barcode": barcodeCtrl.text.trim(),
                                    "itemname": itemnameCtrl.text.trim(),
                                    "qtytype": qtytypeCtrl.text.trim(),
                                    "pcs": pcsCtrl.text.trim(),
                                    "qty": qtyCtrl.text.trim().isNotEmpty
                                        ? int.parse(qtyCtrl.text.trim())
                                        : "0",
                                    "reason": reasonCtrl.text.trim(),
                                    
                                    "cost": costCtrl.text.trim().isNotEmpty
                                        ? double.parse(costCtrl.text.trim())
                                        : "0"
                                  };
                                  if (isEdit) {
                                    curData[currentIndex!] = current;
                                    gridData.value = curData;
                                    navigatorKey.currentState?.pop();
                                    navigatorKey.currentState?.pop();
                                  } else {
                                    bool isBarcodeInTable = false;
                                    for (var element in curData) {
                                      if (element['barcode']
                                                  .toString()
                                                  .toLowerCase() ==
                                              barcodeCtrl.text
                                                  .trim()
                                                  .toLowerCase() &&
                                          element["cost"]
                                                  .toString()
                                                  .toLowerCase() ==
                                              costCtrl.text
                                                  .trim()
                                                  .toLowerCase()) {
                                        isBarcodeInTable = true;
                                      }
                                    }
                                    // if (isBarcodeInTable) {
                                    //   navigatorKey.currentState?.pop();
                                    // showAlertDialogWhenSameProductIsInGrid(
                                    //     context,
                                    //     barcodeCtrl,
                                    //     itemnameCtrl,
                                    //     qtytypeCtrl,
                                    //     pcsCtrl,
                                    //     qtyCtrl,
                                    //     focCtrl,
                                    //     costCtrl,
                                    //     itemDropCtrl,
                                    //     current,
                                    //     curData);
                                    // } else {
                                    curData.add(current);
                                    gridData.value = curData;
                                    barcodeCtrl.clear();
                                    itemnameCtrl.clear();
                                    qtytypeCtrl.clear();
                                    pcsCtrl.clear();
                                    qtyCtrl.clear();
                                    reasonCtrl.clear();
                                    costCtrl.clear();
                                    itemDropCtrl.clear();
                                    navigatorKey.currentState?.pop();
                                    barcodefocus.requestFocus();
                                    // navigatorKey.currentState?.pop();
                                    // }
                                  }
                                } catch (e) {
                                  navigatorKey.currentState?.pop();
                                  showSnackbar(
                                      isEdit
                                          ? "Failed to update product"
                                          : "Failed to add product",
                                      context);
                                }
                              },
                              child: Text(isEdit ? "UPDATE" : "ADD")),
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
                              onPressed: () {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((timestamp) {
                                  context.read<ProductController>().init();
                                  context.read<StockController>().init();
                                });
                                // barcodeCtrl.clear();
                                // itemnameCtrl.clear();
                                // qtytypeCtrl.clear();
                                // pcsCtrl.clear();
                                // qtyCtrl.clear();
                                // focCtrl.clear();
                                // costCtrl.clear();
                                // itemDropCtrl.clear();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Close")),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }

  //************************************ validate */
  validate(BuildContext context, bool isServerRemote) async {
    if (widget.grvNoCtrl.text.trim().isEmpty) {
      showSnackbar("Enter GRV number", context);
      return;
    }
    if (widget.grvRefCtrl.text.trim().isEmpty) {
      showSnackbar("Enter GRV REF", context);
      return;
    }
    // if (widget.poNoCtrl.text.trim().isEmpty) {
    //   showSnackbar("Enter PO Number", context);
    //   return;
    // }
    if (selectedGrvDate == null) {
      showSnackbar("Select GRV date", context);
      return;
    }
    // if (widget.poNoCtrl.text.trim().isEmpty) {
    //   showSnackbar("Enter PO Number", context);
    //   return;
    // }
    if (selectedVendor == null) {
      showSnackbar("Select vendor", context);
      return;
    }
    if (widget.returnedByCtrl.text.trim().isEmpty) {
      showSnackbar("Enter returned by", context);
      return;
    }
    if (gridData.value.isEmpty) {
      showSnackbar("Items is empty", context);
      return;
    }
    transparantDialog(context);
    try {
      final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      String formattedGrvDate = formatter.format(selectedGrvDate!);
      if (isServerRemote) {
        //TODO ad grn to remote server
      } else {
        int grvNo = int.parse(widget.grvNoCtrl.text.trim().isEmpty
            ? "0"
            : widget.grvNoCtrl.text.trim());
        await widget.database.removeGrvDetails(grvNo);
        // insert into grndetails table

        for (int i = 0; i < gridData.value.length; i++) {

          
          try {
            var element = gridData.value[i];
            await widget.database.insertGrvDetails(
                element["barcode"].toString(),
                grvNo,
                element["qty"].toString().isNotEmpty
                    ? int.parse(element["qty"].toString())
                    : 0,
                element["reason"].toString(),
                element["cost"].toString().isEmpty
                    ? 0.0
                    : double.parse(element["cost"].toString()));
          } catch (e) {
            log(e.toString(), name: "errororor");
            // showSnackbar("Failed to add this item ${     element["barcode"].toString(),}", context);
          }
        }
        // for (var element in gridData.value) {
        //   try {
        //     await widget.database.insertGrnDetails(
        //         element["barcode"],
        //         grnNo,
        //         element["qty"],
        //         element["foc"].toDouble(),
        //         element["cost"].toDouble());
        //   } catch (e) {
        //     log(e.toString(), name: "errororor");
        //   }
        // }

        // insert into grn table

        await widget.database.insertGrv(
            formattedGrvDate,
            widget.grvRefCtrl.text.trim(),
            widget.returnedByCtrl.text.trim(),
            grvNo,
            widget.remarkCtrl.text.trim(),
            selectedVendor!["vendorid"]);
        navigatorKey.currentState?.pop();

//*******************************************************************//
        // List storedata = await widget.database.getAllstoredata();
        // log(storedata.toString(), name: "store data");
        // if (storedata.isNotEmpty && storedata.last["ip"] != null) {
        //   String ip = storedata.last["ip"] ?? "";
        //   var res = await http.get( Uri.parse("$ip/api/Product"),  );
        //   if (res.statusCode == 200) {
        //      final data = json.decode(res.body);
        //     if (data != null && data.isNotEmpty) {
        //       print(data);
        //       await downloadAllData(context, widget.database, showToast: false);
        //     } }}
          //*********************************************************//

        List details = await widget.database.getAllGrvDetails();
        log(details.toString());
        log(details.length.toString());
        // showSnackbar("Grn Added successfully", context);
        SharedPreferences sp = await SharedPreferences.getInstance();
        List storedata = await widget.database.getAllstoredata();
        String terminal = "";
        if (storedata.isNotEmpty && storedata.last["terminal"] != null) {
          terminal = storedata.last["terminal"] ?? "";
        }
        showGrvSuccess(context, grvNo.toString(), terminal);
        widget.grvNoCtrl.text = "";

        int savedGrvNo = sp.getInt(
              "newGrv",
            ) ??
            1;
        // int newgrn = savedGrnNo == grnNo ? grnNo + 1 : savedGrnNo;
        int newgrv = savedGrvNo == grvNo
            ? grvNo + 1
            : savedGrvNo < grvNo
                ? grvNo + 1
                : savedGrvNo;
        // set new grn in shared preferences
        sp.setInt("newGrv", newgrv);

        widget.grvNoCtrl.text = newgrv.toString();
        // clear all data

        widget.grvDateCtrl.text = "";
        widget.vendorIDCtrl.text = "";
        widget.vendorNameCtrl.text = "";
             widget.remarkCtrl.text = "";
             widget.grvRefCtrl.text = "";
        widget.ctrl.clear();

        gridData.value = [];
        selectedVendor = null;
        selectedGrvDate = DateTime.now();
        widget.grvDateCtrl.text =
            DateFormat('dd-MM-yyyy').format(selectedGrvDate!);

        log(widget.grvNoCtrl.text);
        setState(() {});
      }
    } catch (e) {
      log(e.toString());
      navigatorKey.currentState?.pop();
      showSnackbar("Failed to Add GRV", context);
    }
  }

  // ************************ allocate model to textfied
  allocateDataTotextfiledWhenscanned({
    required SingleSelectController itemDropCtrl,
    required TextEditingController costCtrl,
    required bool isServerRemote,
    // required StockController val,
    // required ProductController remote,
    required ItemMasterController val,
    required TextEditingController barcodeCtrl,
    required TextEditingController qtytypeCtrl,
    required TextEditingController itemnameCtrl,
    required TextEditingController pcsCtrl,
    required TextEditingController reasonCtrl,
    required TextEditingController qtyCtrl,
    required Map? selectedItem,
  }) {
    // if (isServerRemote) {
    //   // barcodeCtrl.text = remote.scannedbarcode != null
    //   //     ? remote.scannedbarcode.toString()
    //   //     : "";
    //   // barcodeCtrl.clear();
    //   // itemnameCtrl.clear();
    //   // qtytypeCtrl.clear();
    //   // pcsCtrl.clear();
    //   // qtyCtrl.clear();
    //   // focCtrl.clear();
    //   // costCtrl.clear();
    // } else {
    if (val.barcodeReadedData != null) {
      costCtrl.text = val.barcodeReadedData!["cost"].toString();
      barcodeCtrl.text = val.barcodeReadedData!["barcode"].toString();
      itemnameCtrl.text = val.barcodeReadedData!["barcodespname"].toString();
      qtytypeCtrl.text = val.barcodeReadedData!["qtytype"].toString();
      pcsCtrl.text = val.barcodeReadedData!["pcspertype"].toString();
      if (!val.isItemSearched) {
        itemDropCtrl.value = val.barcodeReadedData;
      }
      // SingleSelectController(val.barcodeReadedData);
      // selectedItem = val.barcodeReadedData;
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      // });
      // qtyCtrl.text=remote.barcodeProductDetails!.qty.toString();
    } else {
      if (val.scannedbarcode != null) {
        barcodeCtrl.text =
            val.scannedbarcode != null ? val.scannedbarcode.toString() : "";
        barcodeCtrl.clear();
        itemnameCtrl.clear();
        qtytypeCtrl.clear();
        pcsCtrl.clear();
        qtyCtrl.clear();
        reasonCtrl.clear();
        costCtrl.clear();
        itemDropCtrl.clear();
        selectedItem = null;
      }
    }
    // }
  }

//********************************* get grn details by grn from local db */
  Future<Map> getGrvBygrvno(int grvno, DB database) async {
    log(grvno.toString());
    List fg = await database.getAllGrvDetails();
    log(fg.toString(), name: "all grvs");
    log(fg.length.toString(), name: "all grvs length");
    log(fg.length.toString(), name: "all grvs length");
    List grvs = await database.getGrvByGrvNo(grvno);
    log(grvs.toString(), name: "selected grvs");

    if (grvs.isNotEmpty) {
      List grvdetails = await database.getGrvDetailsByGrvNo(grvno);
      log(grvdetails.length.toString(), name: "grv details length");
      log(grvdetails.toString(), name: "grv details ");
      return {"status": "success", "grv": grvs[0], "grvdetails": grvdetails};
    } else {
      return {"status": "failed"};
    }
  }

  //*****************************************  */
  Future<bool> searchGrv() async {
    try {
      if (widget.grvNoCtrl.text.trim().isNotEmpty) {
        transparantDialog(context);
        Map res = await getGrvBygrvno(
            int.parse(widget.grvNoCtrl.text.trim()), widget.database);
        log(res.toString());
        if (res["status"] == "success") {
          widget.grvNoCtrl.text = res["grv"]["grvno"].toString();
          widget.grvRefCtrl.text = res["grv"]["grvref"].toString();
         widget.remarkCtrl.text = res["grv"]["remarkCtrl"].toString();
          for (var element in widget.vendors) {
            if (element["vendorid"].toString().toString() ==
                res["grv"]["vendorid"].toString().toLowerCase()) {
              selectedVendor = element;
              widget.vendorIDCtrl.text = element["vendorid"].toString();
              widget.ctrl.value = element;
            }
          }
          List<Map> _gridData = [];
          for (var element in res["grvdetails"]) {
            List products = await widget.database
                .getProductFromitemmasterByBarcode(
                    element["barcode"].toString());
            // List products = await widget.database
            //     .getProductByBarcode(int.parse(element["barcode"].toString()));

            if (products.isNotEmpty) {
              _gridData.add({
                "barcode": element["barcode"].toString(),
                "itemname": products[0]["barcodespname"],
                "qtytype": products[0]["qtytype"],
                "pcs": products[0]["pcspertype"],
                "qty": int.parse(element["qty"].toString()),
                "reason":products[0]["reason"], 
                "cost": double.parse(element["cost"].toString())
              });
            }
          }
          gridData.value = _gridData;
          navigatorKey.currentState?.pop();

          showSnackbar("Grv loaded", context);
          log(res.toString());
          return true;
        } else {
          navigatorKey.currentState?.pop();

          log(res.toString());
          showSnackbar("No Grv found", context);
          return false;
        }
      } else {
        return false;
      }
      // return false;
    } catch (e) {
      showSnackbar("No Grv found", context);
      // navigatorKey.currentState?.pop();
      return false;
    }
  }

  //***************************************** search ponumber */
  // Future<bool> searchPonumber() async {
  //   try {
  //     if (widget.poNoCtrl.text.trim().isNotEmpty) {
  //       transparantDialog(context);
  //       int ponumber = int.parse(widget.poNoCtrl.text.trim());
  //       List poheader = await widget.database.getPoheaderBypono(ponumber);
  //       List podetails = await widget.database.getPoDetailsByGrnNo(ponumber);
  //       if (poheader.isNotEmpty && podetails.isNotEmpty) {
  //         widget.vendorIDCtrl.text = poheader.last["vendorid"].toString();
  //         //get vendor name
  //         for (var element in widget.vendors) {
  //           if (element["vendorid"].toString().toString() ==
  //               poheader.last["vendorid"].toString().toLowerCase()) {
  //             selectedVendor = element;
  //             widget.vendorIDCtrl.text = element["vendorid"].toString();
  //             widget.ctrl.value = element;
  //           }
  //         }
  //         List<Map> data = [];
  //         // data = gridData.value;
  //         //get product details
  //         for (int i = 0; i < podetails.length; i++) {
  //           Map current = podetails[i];
  //           //get product details by barcode for diplaying
  //           List products = await widget.database
  //               .getProductFromitemmasterByBarcode(
  //                   current["barcode"].toString());
  //           if (products.isNotEmpty) {
  //             Map element = products.last;
  //             data.add({
  //               "barcode": current["barcode"].toString(),
  //               "itemname": element["mastername"],
  //               "qtytype": element["qtytype"],
  //               "pcs": element["pcspertype"],
  //               "qty": int.parse(current["qty"].toString()),
  //               "foc": double.parse(current["foc"].toString()),
  //               "cost": double.parse(current["cost"].toString())
  //             });
  //           }
  //         }
  //         // add to grid
  //         gridData.value = data;
  //         navigatorKey.currentState?.pop();

  //         showSnackbar("Ponumber found", context);
  //         // log(res.toString());
  //         return true;
  //       } else {
  //         navigatorKey.currentState?.pop();

  //         showSnackbar("No Ponumber found", context);
  //         return false;
  //       }
  //     }
  //     return false;
  //   } catch (e) {
  //     showSnackbar("No Ponumber found", context);
  //     navigatorKey.currentState?.pop();
  //     return false;
  //   }
  // }

//*********************************************** */
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
                      // clear all data
                      widget.grvDateCtrl.text = "";
                      widget.vendorIDCtrl.text = "";
                      widget.vendorNameCtrl.text = "";
                      widget.remarkCtrl.text = "";
                  
                      widget.ctrl.clear();
                      selectedVendor = null;
                      selectedGrvDate = null;
                      widget.grvRefCtrl.text = "";
                      gridData.value = [];
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      int newGrvNo = sp.getInt("newGrv") ?? 1;
                      widget.grvNoCtrl.text = newGrvNo.toString();
                      selectedGrvDate = DateTime.now();
                      widget.grvDateCtrl.text =
                          DateFormat('dd-MM-yyyy').format(selectedGrvDate!);
                      Navigator.of(context).pop();
                      showDelete.value = false;
                      check();
                      // List storedata = await widget.database.getAllstoredata();
                      // log(storedata.toString(), name: "store data");
                      // if (storedata.isNotEmpty && storedata.last["ip"] != null) {
                      //   String ip = storedata.last["ip"] ?? "";
                      //   var res = await http.get( Uri.parse("$ip/api/Product"),  );
                      //   if (res.statusCode == 200) {
                      //     final data = json.decode(res.body);
                      //     if (data != null && data.isNotEmpty) {
                      //       print("ok");
                      //       print(data);
                      //       print("ok");
                      //       await downloadAllData(context, widget.database, showToast: false);
                      //     }
                      //   }
                      // }


                      _focus1.requestFocus();
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

////////////////////////////// no product found msg box

  // void showAlertDialogWhenSameProductIsInGrid(
  //     BuildContext context2,
  //     TextEditingController barcodeCtrl,
  //     TextEditingController itemnameCtrl,
  //     TextEditingController qtytypeCtrl,
  //     TextEditingController pcsCtrl,
  //     TextEditingController qtyCtrl,
  //     TextEditingController focCtrl,
  //     TextEditingController costCtrl,
  //     SingleSelectController<Map<dynamic, dynamic>?> itemDropCtrl,
  //     Map current,
  //     List<Map> curData) {
  //   showDialog(
  //     context: context2,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               Icons.warning,
  //               color: Colors.orange.shade600,
  //               size: 48,
  //             ),
  //             const SizedBox(height: 16),
  //             const Text(
  //               "Item already added in list.Do you want to add to existing item or keep as seperate?",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             const SizedBox(height: 24),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.blue.shade900,
  //                       foregroundColor: Colors.white),
  //                   child: const Text('Yes'),
  //                   onPressed: () {
  //                     for (int i = 0; i < curData.length; i++) {
  //                       Map current = curData[i];
  //                       if (current['barcode'].toString().toLowerCase() ==
  //                               barcodeCtrl.text.trim().toLowerCase() &&
  //                           current["cost"].toString().toLowerCase() ==
  //                               costCtrl.text.trim().toLowerCase()) {
  //                         curData[i] = current;
  //                       }
  //                     }
  //                     gridData.value = curData;
  //                     barcodeCtrl.clear();
  //                     itemnameCtrl.clear();
  //                     qtytypeCtrl.clear();
  //                     pcsCtrl.clear();
  //                     qtyCtrl.clear();
  //                     focCtrl.clear();
  //                     costCtrl.clear();
  //                     itemDropCtrl.clear();
  //                     navigatorKey.currentState?.pop();
  //                     barcodefocus.requestFocus();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //                 const SizedBox(
  //                   width: 8,
  //                 ),
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.blue.shade900,
  //                       foregroundColor: Colors.white),
  //                   child: const Text('No'),
  //                   onPressed: () {
  //                     curData.add(current);
  //                     gridData.value = curData;
  //                     barcodeCtrl.clear();
  //                     itemnameCtrl.clear();
  //                     qtytypeCtrl.clear();
  //                     pcsCtrl.clear();
  //                     qtyCtrl.clear();
  //                     focCtrl.clear();
  //                     costCtrl.clear();
  //                     itemDropCtrl.clear();
  //                     navigatorKey.currentState?.pop();
  //                     barcodefocus.requestFocus();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

////////////////////////////// grv delete msg box

  void showAlertDialogToDeleteGrv(
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
                "Are you sure to delete grv?",
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
                      try {
                        await widget.database.removeGrv(
                            widget.grvNoCtrl.text.isNotEmpty
                                ? int.parse(widget.grvNoCtrl.text)
                                : 0);
                        await widget.database.removeGrvDetails(
                            widget.grvNoCtrl.text.isNotEmpty
                                ? int.parse(widget.grvNoCtrl.text)
                                : 0);
                        widget.grvDateCtrl.text = "";
                        widget.vendorIDCtrl.text = "";
                        widget.vendorNameCtrl.text = "";
                           widget.remarkCtrl.text = "";
                         widget.ctrl.clear();
                        selectedVendor = null;
                        selectedGrvDate = null;
                        widget.grvRefCtrl.text = "";
                        gridData.value = [];
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        int newGrvNo = sp.getInt("newGrv") ?? 1;
                        widget.grvNoCtrl.text = newGrvNo.toString();
                        selectedGrvDate = DateTime.now();
                        widget.grvDateCtrl.text =
                            DateFormat('dd-MM-yyyy').format(selectedGrvDate!);
                        _focus1.requestFocus();
                        showDelete.value = false;
                        Navigator.of(context).pop();
                      } catch (e) {
                        Navigator.of(context).pop();
                        showSnackbar("Failed to delete grv", context);
                      }
                    },
                  ),
                  const SizedBox(
                    width: 8,
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

////////////////////////////// grn delete msg box

  void showGrvSuccess(
      BuildContext context2, String savedGrvno, String terminal) {
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
                Icons.check,
                color: Colors.green.shade900,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                "GRV SAVED SUCCESSFULLY\nGRV NO : $savedGrvno\nTerminal : $terminal",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          foregroundColor: Colors.white),
                      child: const Text('OK'),
                      onPressed: () async {
                        navigatorKey.currentState?.pop();
                        _focus1.requestFocus();
                      }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

////////////////////////////// ponumber clear dialog

  // void showPonumberClearDialog(
  //     BuildContext context, bool isBottomSheet, Size size) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext ctx) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               Icons.warning,
  //               color: Colors.orange.shade900,
  //               size: 48,
  //             ),
  //             const SizedBox(height: 16),
  //             const Text(
  //               "Do you want to clear current items?",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             const SizedBox(height: 24),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                         backgroundColor: Colors.blue.shade900,
  //                         foregroundColor: Colors.white),
  //                     child: const Text('Yes'),
  //                     onPressed: () async {
  //                       gridData.value = [];

  //                       navigatorKey.currentState?.pop();
  //                       if (isBottomSheet) {
  //                         widget.poNoCtrl.text = "";

  //                         ponumberBottomsheet(
  //                             context,
  //                             widget.poheaders,
  //                             widget.podetails,
  //                             widget.vendors,
  //                             widget.poNoCtrl,
  //                             widget.vendorIDCtrl,
  //                             widget.ctrl,
  //                             _focus5,
  //                             gridData,
  //                             size,
  //                             widget.database);
  //                       } else {
  //                         bool res = await searchPonumber();
  //                       }
  //                     }),
  //                 const SizedBox(
  //                   width: 8,
  //                 ),
  //                 ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                         backgroundColor: Colors.blue.shade900,
  //                         foregroundColor: Colors.white),
  //                     child: const Text('No'),
  //                     onPressed: () async {
  //                       // if (res) {
  //                       //   // changeFocus(context, _focus3, _focus4);
  //                       // }
  //                       widget.poNoCtrl.text = "";
  //                       navigatorKey.currentState?.pop();
  //                       // bool res = await searchPonumber();
  //                     }),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void check()async {
    List storedata = await widget.database.getAllstoredata();
    log(storedata.toString(), name: "store data");
    if (storedata.isNotEmpty && storedata.last["ip"] != null) {
      String ip = storedata.last["ip"] ?? "";
      var res = await http.get( Uri.parse("$ip/api/Product"),  );
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        if (data != null && data.isNotEmpty) {
          print("ok");
          print(data);
          print("ok");
          await downloadAllData(context, widget.database, showToast: false);
        }
      }
    }
  }
}
