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
import 'package:qr_scanner/views/purchase%20order/purchaseorder_popUp_form_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db services/db_services.dart';

class purchaseorderFormBody extends StatefulWidget {
  final int lastPono;
  final String server;
  final bool isServerRemote;
  final TextEditingController poDateCtrl;

  final TextEditingController vendorIDCtrl;
  final TextEditingController remarkCtrl;
  final TextEditingController vendorNameCtrl;
  final TextEditingController poNoCtrl;
  SingleSelectController<Map?> ctrl;
  final TextEditingController enteredByCtrl;

  final DateTime poDatePreselected;
  final DB database;
  final List<Map> vendors;
  final List<Map> items;
  final List<Map> gridDateList;
  final List<Map> podetails;
  final List<Map> poheaders;

  purchaseorderFormBody(
      {super.key,
      required this.items,
      required this.gridDateList,
      required this.remarkCtrl,
      required this.poheaders,
      required this.podetails,
      required this.server,
      required this.isServerRemote,
      required this.poDateCtrl,
      required this.vendorIDCtrl,
      required this.vendorNameCtrl,
      required this.poNoCtrl,
      required this.ctrl,
      required this.enteredByCtrl,
      required this.database,
      required this.vendors,
      required this.poDatePreselected,
      required this.lastPono});

  @override
  State<purchaseorderFormBody> createState() => _GrnFormBodyState();
}

class _GrnFormBodyState extends State<purchaseorderFormBody> {
  Map? selectedVendor;

  DateTime? selectedPoDate;
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
  final FocusNode focfocus = FocusNode();

  @override
  void initState() {
    selectedPoDate = widget.poDatePreselected;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // gridData.value = widget.gridDateList;
      // selectedPoDate = widget.poDatePreselected;
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
    if (widget.poNoCtrl.text.trim().isNotEmpty) {
      showDelete.value = await searchpo();
      if (showDelete.value == false) {
        widget.poDateCtrl.text = "";
        widget.vendorIDCtrl.text = "";
        widget.vendorNameCtrl.text = "";

        widget.ctrl.clear();
        selectedVendor = null;
        selectedPoDate = null;

        gridData.value = [];

        selectedPoDate = DateTime.now();
        widget.poDateCtrl.text =
            DateFormat('dd-MM-yyyy').format(selectedPoDate!);
        Navigator.of(context).pop();
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
        // Text(
        //   "Server : ${widget.server}",
        //   style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        // ),
        // const SizedBox(
        //   height: 12,
        // ),
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
            Row(
              children: [
                Expanded(
                  child: field(
                    number: true,
                    focusnode: _focus1,
                    onFieldSubmitted: (p0) async {
                      showDelete.value = await searchpo();
                      if (showDelete.value == false) {
                        widget.poDateCtrl.text = "";
                        widget.vendorIDCtrl.text = "";
                        widget.vendorNameCtrl.text = "";

                        widget.ctrl.clear();
                        selectedVendor = null;
                        selectedPoDate = null;

                        gridData.value = [];

                        selectedPoDate = DateTime.now();
                        widget.poDateCtrl.text =
                            DateFormat('dd-MM-yyyy').format(selectedPoDate!);
                        Navigator.of(context).pop();
                        showDelete.value = false;
                        _focus1.requestFocus();
                      }
                      changeFocus(context, _focus1, _focus2);
                    },
                    cntr: widget.poNoCtrl,
                    context: context,
                    txt: "PO NUMBER",
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
                      showDelete.value = await searchpo();
                      if (showDelete.value == false) {
                        widget.poDateCtrl.text = "";
                        widget.vendorIDCtrl.text = "";
                        widget.vendorNameCtrl.text = "";

                        widget.ctrl.clear();
                        selectedVendor = null;
                        selectedPoDate = null;

                        gridData.value = [];

                        selectedPoDate = DateTime.now();
                        widget.poDateCtrl.text =
                            DateFormat('dd-MM-yyyy').format(selectedPoDate!);
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
              focusnode: _focus4,
              cntr: widget.poDateCtrl,
              context: context,
              txt: "PO DATE",
              isRead: true,
              onFieldSubmitted: (p0) => changeFocus(context, _focus4, _focus5),
              onTap: () async {
                DateTime? _selectedDate = await showDatePicker(
                    context: context,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 3650)),
                    lastDate: DateTime.now());
                if (_selectedDate != null) {
                  selectedPoDate = _selectedDate;
                  widget.poDateCtrl.text =
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
                cntr: widget.enteredByCtrl,
                context: context,
                txt: "ENTERED BY",
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
                    await widget.database.getAllpoheader();
                    await widget.database.getAllPoDetails();
                    //  SharedPreferences sp=await SharedPreferences.getInstance();
                    //  int grnno=sp.getInt(key);

                    int pono = widget.poNoCtrl.text.trim().isNotEmpty
                        ? int.parse(widget.poNoCtrl.text.trim())
                        : 0;
                    if (widget.poNoCtrl.text.isNotEmpty ||
                        gridData.value.isNotEmpty ||
                        widget.lastPono != pono) {
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
                        showAlertDialogToDeleteGrn(context);
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
            DataCell(Text(current["foc"].toString())),
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

                curDatAa.removeAt(i);

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
                  DataColumn(label: Text('Foc')),
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
    final TextEditingController focCtrl = TextEditingController();
    final TextEditingController costCtrl = TextEditingController();
    final SingleSelectController<Map?> itemDropCtrl =
        SingleSelectController(null);
    Map? selectedItem;

    if (isEdit) {
      for (var element in items) {
        if (element["mastername"].toString().toLowerCase() ==
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
      focCtrl.text = current["foc"] != null ? current["foc"].toString() : "";
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
        focCtrl.text = "";
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
                  focCtrl: focCtrl,
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
                    PurchaseorderPopUpFormBody(
                        focus1: barcodefocus,
                        focus2: qtyfocus,
                        focus3: focfocus,
                        selectedItem: selectedItem,
                        itemDropCtrl: itemDropCtrl,
                        items: items,
                        costCtrl: costCtrl,
                        barcodeCtrl: barcodeCtrl,
                        qtytypeCtrl: qtytypeCtrl,
                        itemnameCtrl: itemnameCtrl,
                        pcsCtrl: pcsCtrl,
                        qtyCtrl: qtyCtrl,
                        focCtrl: focCtrl,
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
                                int focCountCtrl = int.tryParse(focCtrl.text.trim()) ?? 1;
                                if (focCountCtrl > 99999) {
                                  showSnackbar("Enter valid foc count", context);
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
                                if (qtyCtrl.text.trim().isEmpty &&
                                    focCtrl.text.trim().isEmpty) {
                                  showSnackbar(
                                      "Enter quantity or foc ", context);
                                  return;
                                }
                                // if (focCtrl.text.trim().isEmpty) {
                                //   showSnackbar("Enter foc", context);
                                //
                                //   return;
                                // }
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
                                    "foc": focCtrl.text.trim().isNotEmpty
                                        ? double.parse(focCtrl.text.trim())
                                        : "0",
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
                                    focCtrl.clear();
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
    if (widget.poNoCtrl.text.trim().isEmpty) {
      showSnackbar("Enter PO number", context);
      return;
    }

    if (selectedPoDate == null) {
      showSnackbar("Select PO date", context);
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
    if (widget.enteredByCtrl.text.trim().isEmpty) {
      showSnackbar("Enter entered by", context);
      return;
    }
    if (gridData.value.isEmpty) {
      showSnackbar("Items is empty", context);
      return;
    }
    transparantDialog(context);
    try {
      final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      String formattedGrnDate = formatter.format(selectedPoDate!);
      if (isServerRemote) {
        //TODO ad grn to remote server
      } else {
        int poNo = int.parse(widget.poNoCtrl.text.trim().isEmpty
            ? "0"
            : widget.poNoCtrl.text.trim());
        await widget.database.removePoDetails(poNo);
        // insert into grndetails table

        for (int i = 0; i < gridData.value.length; i++) {
          try {
            var element = gridData.value[i];
            await widget.database.insertpoDetails(
                element["barcode"].toString(),
                poNo,
                element["qty"].toString().isNotEmpty
                    ? int.parse(element["qty"].toString())
                    : 0,
                element["foc"].toString().isEmpty
                    ? 0.0
                    : double.parse(element["foc"].toString()),
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

        await widget.database.insertPoHeader(
            poNo,
            formattedGrnDate,
            selectedVendor!["vendorid"],
            widget.enteredByCtrl.text.trim(),
            widget.remarkCtrl.text.trim());
        navigatorKey.currentState?.pop();

//*******************************************************************//
        // List storedata = await widget.database.getAllstoredata();
        // log(storedata.toString(), name: "store data");
        // if (storedata.isNotEmpty && storedata.last["ip"] != null) {
        //   String ip = storedata.last["ip"] ?? "";
        //   var res = await http.get(
        //     Uri.parse("$ip/api/Product"),
        //   );
        //   if (res.statusCode == 200) {
        //     final data = json.decode(res.body);
        //     if (data != null && data.isNotEmpty) {
        //       print(data);
        //       await downloadAllData(context, widget.database, showToast: false);
        //     }
        //   }
        // }
        //*********************************************************//

        // List details = await widget.database.getAllGrnDetails();
        // log(details.toString());
        // log(details.length.toString());
        // // showSnackbar("Grn Added successfully", context);
        SharedPreferences sp = await SharedPreferences.getInstance();
        List storedata = await widget.database.getAllstoredata();
        String terminal = "";
        if (storedata.isNotEmpty && storedata.last["terminal"] != null) {
          terminal = storedata.last["terminal"] ?? "";
        }
        showGrnSuccess(context, poNo.toString(), terminal);
        widget.poNoCtrl.text = "";

        int savedPoNo = sp.getInt(
              "newPoNo",
            ) ??
            1;
        // int newgrn = savedGrnNo == grnNo ? grnNo + 1 : savedGrnNo;
        int newPoNo = savedPoNo == poNo
            ? poNo + 1
            : savedPoNo < poNo
                ? poNo + 1
                : savedPoNo;
        // set new grn in shared preferences
        sp.setInt("newPoNo", newPoNo);

        // clear all data

        widget.poDateCtrl.text = "";
        widget.vendorIDCtrl.text = "";
        widget.vendorNameCtrl.text = "";
        widget.remarkCtrl.text = "";

        widget.ctrl.clear();
        gridData.value = [];
        selectedVendor = null;
        selectedPoDate = DateTime.now();
        widget.poDateCtrl.text =
            DateFormat('dd-MM-yyyy').format(selectedPoDate!);

        log(widget.poNoCtrl.text);
        widget.poNoCtrl.text = newPoNo.toString();

        setState(() {});
      }
    } catch (e) {
      log(e.toString());
      navigatorKey.currentState?.pop();
      showSnackbar("Failed to Add GRN", context);
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
    required TextEditingController focCtrl,
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
        focCtrl.clear();
        costCtrl.clear();
        itemDropCtrl.clear();
        selectedItem = null;
      }
    }
    // }
  }

//*****************************************  */
  Future<bool> searchpo() async {
    try {
      if (widget.poNoCtrl.text.trim().isNotEmpty) {
        transparantDialog(context);
        Map res = await getPoByPoNo(
            int.parse(widget.poNoCtrl.text.trim()), widget.database);
        log(res.toString());
        if (res["status"] == "success") {
          widget.poNoCtrl.text = res["header"]["pono"].toString();
          widget.remarkCtrl.text = res["header"]["remark"].toString();

          widget.enteredByCtrl.text = res["header"]["enteredby"].toString();
          for (var element in widget.vendors) {
            if (element["vendorid"].toString().toString() ==
                res["header"]["vendorid"].toString().toLowerCase()) {
              selectedVendor = element;
              widget.vendorIDCtrl.text = element["vendorid"].toString();
              widget.ctrl.value = element;
            }
          }
          List<Map> _gridData = [];
          for (var element in res["details"]) {
            List products = await widget.database
                .getProductFromitemmasterByBarcode(
                    element["barcode"].toString());
            // List products = await widget.database
            //     .getProductByBarcode(int.parse(element["barcode"].toString()));

            if (products.isNotEmpty) {
              _gridData.add({
                "barcode": element["barcode"].toString(),
                "itemname": products[0]["mastername"],
                "qtytype": products[0]["qtytype"],
                "pcs": products[0]["pcspertype"],
                "qty": int.parse(element["qty"].toString()),
                "foc": double.parse(element["foc"].toString()),
                "cost": double.parse(element["cost"].toString())
              });
            }
          }
          gridData.value = _gridData;
          navigatorKey.currentState?.pop();

          showSnackbar("PO loaded", context);
          log(res.toString());
          return true;
        } else {
          // navigatorKey.currentState?.pop();

          log(res.toString());
          showSnackbar("No PO found", context);
          return false;
        }
      } else {
        return false;
      }
      // return false;
    } catch (e) {
      showSnackbar("No PO found", context);
      // navigatorKey.currentState?.pop();
      return false;
    }
  }

//********************************* get grn details by grn from local db */
  Future<Map> getPoByPoNo(int pono, DB database) async {
    log(pono.toString());
    List fg = await database.getAllpoheader();
    log(fg.toString(), name: "all grns");
    log(fg.length.toString(), name: "all grns length");
    log(fg.length.toString(), name: "all grns length");
    List poheader = await database.getPoheaderBypono(pono);
    log(poheader.toString(), name: "selected grns");

    if (poheader.isNotEmpty) {
      List podetails = await database.getPoDetailsByGrnNo(pono);
      log(podetails.length.toString(), name: "grn details length");
      log(podetails.toString(), name: "grn details ");
      return {"status": "success", "header": poheader[0], "details": podetails};
    } else {
      return {"status": "failed"};
    }
  }

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
                      widget.poDateCtrl.text = "";
                      widget.vendorIDCtrl.text = "";
                      widget.vendorNameCtrl.text = "";
                      widget.remarkCtrl.text = "";
                      widget.poNoCtrl.text = "";
                      widget.ctrl.clear();
                      selectedVendor = null;
                      selectedPoDate = null;
                      gridData.value = [];
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      int newPoNo = sp.getInt("newPoNo") ?? 1;
                      widget.poNoCtrl.text = newPoNo.toString();
                      selectedPoDate = DateTime.now();
                      widget.poDateCtrl.text =
                          DateFormat('dd-MM-yyyy').format(selectedPoDate!);
                      Navigator.of(context).pop();

                      showDelete.value = false;
                      List storedata = await widget.database.getAllstoredata();
                      log(storedata.toString(), name: "store data");
                      // if (storedata.isNotEmpty &&
                      //     storedata.last["ip"] != null) {
                      //   String ip = storedata.last["ip"] ?? "";
                      //   var res = await http.get(
                      //     Uri.parse("$ip/api/Product"),
                      //   );
                      //   if (res.statusCode == 200) {
                      //     final data = json.decode(res.body);
                      //     if (data != null && data.isNotEmpty) {
                      //       print("ok");
                      //       print(data);
                      //       print("ok");
                      //       await downloadAllData(context, widget.database,
                      //           showToast: false);
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

////////////////////////////// grn delete msg box

  void showAlertDialogToDeleteGrn(
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
                "Are you sure to delete PO?",
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
                        await widget.database.removepoheader(
                            widget.poNoCtrl.text.isNotEmpty
                                ? int.parse(widget.poNoCtrl.text)
                                : 0);
                        await widget.database.removePoDetails(
                            widget.poNoCtrl.text.isNotEmpty
                                ? int.parse(widget.poNoCtrl.text)
                                : 0);
                        widget.poDateCtrl.text = "";
                        widget.vendorIDCtrl.text = "";
                        widget.vendorNameCtrl.text = "";
                        widget.remarkCtrl.text = "";
                        widget.poNoCtrl.text = "";
                        widget.ctrl.clear();
                        selectedVendor = null;
                        selectedPoDate = null;
                        gridData.value = [];
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        int newpono = sp.getInt("newPoNo") ?? 1;
                        widget.poNoCtrl.text = newpono.toString();

                        selectedPoDate = DateTime.now();
                        widget.poDateCtrl.text =
                            DateFormat('dd-MM-yyyy').format(selectedPoDate!);
                        _focus1.requestFocus();
                        showDelete.value = false;
                        Navigator.of(context).pop();
                      } catch (e) {
                        Navigator.of(context).pop();
                        showSnackbar("Failed to delete PO", context);
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

  void showGrnSuccess(
      BuildContext context2, String savedpono, String terminal) {
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
                "PURCHASE SAVED SUCCESSFULLY\nPO NO : $savedpono\nTerminal : $terminal",
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
}
