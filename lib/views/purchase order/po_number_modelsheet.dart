import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';

import '../../db services/db_services.dart';

ponumberBottomsheet(
    BuildContext context,
    List<Map> poheaders,
    List<Map> podetails,
    List<Map> vendors,
    TextEditingController ponoCtrl,
    TextEditingController vendorIdCtrl,
    SingleSelectController<Map?> ctrl,
    // TextEditingController v,
    FocusNode focusnode,
    ValueNotifier<List<Map>> griddata,
    Size size,
    DB database) {
  ValueNotifier<List> searchedPonumbers = ValueNotifier([]);
  String keyword = "";

  //**************************************************** on tap tile */
  onTapselectPonumber(Map current, Map? vendor) async {
    transparantDialog(context);
    //***** pass data to respective controllers */
    ponoCtrl.text = current["pono"].toString();
    ctrl.value = vendor ?? null;
    vendorIdCtrl.text = current["vendorid"].toString();
    //*********** get ponumber details only from all */
    List podetails = await database.getPoDetailsByGrnNo(current["pono"]);
    List<Map> data = [];
    //************************ get items */
    for (int i = 0; i < podetails.length; i++) {
      Map currentDetail = podetails[i];
      //get product details by barcode for diplaying
      List products = await database.getProductFromitemmasterByBarcode(
          currentDetail["barcode"].toString());
      if (products.isNotEmpty) {
        Map element = products.last;
        data.add({
          "barcode": currentDetail["barcode"].toString(),
          "itemname": element["mastername"],
          "qtytype": element["qtytype"],
          "pcs": element["pcspertype"],
          "qty": int.parse(currentDetail["qty"].toString()),
          "foc": double.parse(currentDetail["foc"].toString()),
          "cost": double.parse(currentDetail["cost"].toString())
        });
      }
    }
    // add to grid
    griddata.value = data;

    navigatorKey.currentState?.pop();
    navigatorKey.currentState?.pop();
  }

  //************************************************************** */
  showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
            height: size.height * 0.9,
            width: size.width,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03, vertical: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.red.shade900),
                          onPressed: () => navigatorKey.currentState?.pop(),
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    onChanged: (value) {
                      keyword = value;
                      debugPrint(value);
                      searchedPonumbers.value = poheaders
                          .where((element) => element["pono"]
                              .toString()
                              .toLowerCase()
                              .contains(value))
                          .toList();

                      log(searchedPonumbers.value.toString());
                    },
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle:
                          TextStyle(fontSize: 12, color: Colors.grey.shade400),
                      isDense: true,
                      labelStyle:
                          const TextStyle(fontSize: 11, color: Colors.black),
                      // isCollapsed: true,
                      errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(.3)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(.3)),
                          borderRadius: BorderRadius.circular(10)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black.withOpacity(.3)),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black.withOpacity(.3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black38,
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder(
                      valueListenable: searchedPonumbers,
                      builder: (context, value, child) {
                        return keyword != "" && value.isEmpty
                            ? const Center(
                                child: Text("No po number found"),
                              )
                            : ListView.separated(
                                controller: ScrollController(),
                                separatorBuilder: (context, index) =>
                                    const Divider(color: Colors.black38),
                                shrinkWrap: true,
                                itemCount: value.isNotEmpty
                                    ? value.length
                                    : poheaders.length,
                                itemBuilder: (context, index) {
                                  Map current = value.isNotEmpty
                                      ? value[index]
                                      : poheaders[index];
                                  // change date format
                                  DateTime now =
                                      DateTime.parse(current["podate"]);
                                  String formattedDate =
                                      DateFormat('dd-MM-yyyy').format(now);
                                  // get vendorname
                                  Map? vendor = getVendorDetailsByid(
                                      vendors, current["vendorid"]);
                                  String vendorname = "";
                                  if (vendor != null) {
                                    vendorname = vendor["vendorname"] ?? "";
                                  }
                                  return ListTile(
                                    visualDensity: const VisualDensity(
                                        horizontal: 0, vertical: -4),
                                    onTap: () async {
                                      onTapselectPonumber(current, vendor);
                                    },
                                    // tileColor: index % 2 == 0
                                    //     ? Colors.black12
                                    //     : Colors.grey.shade100,
                                    title: Text(
                                      "PONO : ${current["pono"]}\nDate : $formattedDate\nVendor : $vendorname",
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 13),
                                    ),
                                  );
                                });
                      }),
                ],
              ),
            ),
          ));

  //********************************** */
}

//****************************************** get vendorname */
Map? getVendorDetailsByid(List vendors, int id) {
  for (int i = 0; i < vendors.length; i++) {
    Map current = vendors[i];
    if (current["vendorid"] == id) {
      return current;
    }
  }
}
