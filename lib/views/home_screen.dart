import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/item_master_controller.dart';
import 'package:qr_scanner/controller/product_controller.dart';
import 'package:qr_scanner/controller/stock_controller.dart';
import 'package:qr_scanner/db%20services/db_services.dart';

import 'package:qr_scanner/utils/check_server.dart';
import 'package:qr_scanner/utils/snackbar.dart';

import 'package:qr_scanner/views/homescreen_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockEntry extends StatefulWidget {
  final DB database;

  const StockEntry({super.key, required this.database});

  @override
  State<StockEntry> createState() => _StockEntryState();
}

class _StockEntryState extends State<StockEntry> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      context.read<ProductController>().init();
      context.read<StockController>().init();
      context.read<ItemMasterController>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Add Stock'),
        ),
        body: HomeScreen(
          database: widget.database,
        ));
  }
}

class HomeScreen extends StatelessWidget {
  final DB database;
  HomeScreen({super.key, required this.database});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  final flags = [
    "none",
    "Damage",
    'Scrap',
    "Adjustment",
    'Stock Inward adjustment',
    'Opening Stock Provision',
    'Internal Usage',
    'Physical Stock Adjustment',
  ];
  final TextEditingController itemnameCtrl = TextEditingController();
  final TextEditingController pcspertype = TextEditingController();
  final TextEditingController itemCodeCtrl = TextEditingController();
  final TextEditingController qtyTypeCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();
  final TextEditingController categoryIdCtrl = TextEditingController();
  final TextEditingController spriceCtrl = TextEditingController();
  final TextEditingController currentStockCtrl = TextEditingController();
  final TextEditingController replaceStockCtrl = TextEditingController();
  final TextEditingController addToCurrentStock = TextEditingController();
  final TextEditingController barcodeCtrl = TextEditingController();
  final TextEditingController flagCtrl = TextEditingController();
  final TextEditingController remarkCtrl = TextEditingController();
  final TextEditingController sajnoCtrl = TextEditingController();
  final SingleSelectController<Map?> itemDropCtrl =
      SingleSelectController(null);
  // ValueNotifier<String?> selectedFlag = ValueNotifier("none");
  // final TextEditingController codeCtrl = TextEditingController();

  // final TextEditingController qtyCtrl = TextEditingController();
  getItemsAndCategories() async {
    List categories = await database.getAllcategories();
    List items = await database.getAllitemmaster();
    SharedPreferences sp = await SharedPreferences.getInstance();
    int newSajno = sp.getInt(
          "newSaj",
        ) ??
        1;
    return {"items": items, "categories": categories, "newSajno": newSajno};
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: FutureBuilder(
          future: getItemsAndCategories(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              log(snapshot.data.toString());
              List<Map> categories = snapshot.data["categories"];
              List<Map> items = snapshot.data["items"];
              int newSajno = snapshot.data["newSajno"];
              // bool isServerRemote = snapshot.data ?? false;
              return body(size, false, categories, items, newSajno);
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  //**********************************  body */
  Widget body(Size size, bool isServerRemote, List categories, List<Map> items,
      int newSajno) {
    sajnoCtrl.text = newSajno.toString();
    String server = isServerRemote ? "Remote" : "Local";
    return SingleChildScrollView(
      child: Consumer<ItemMasterController>(builder: (context, val, child) {
        if (val.barcodeReadedData != null) {
          for (var element in categories) {
            if (element["categoryid"] == val.barcodeReadedData!["categoryid"]) {
              categoryCtrl.text = element["categoryname"];
              categoryIdCtrl.text = element["categoryid"].toString();
            }
          }
          itemDropCtrl.value = val.barcodeReadedData;
          barcodeCtrl.text = val.barcodeReadedData!["barcode"].toString();
          itemCodeCtrl.text = val.barcodeReadedData!["itemcode"].toString();
          itemnameCtrl.text = val.barcodeReadedData!['mastername'].toString();
          qtyTypeCtrl.text = val.barcodeReadedData!['qtytype'].toString();
          // categoryCtrl.text = val.barcodeReadedData!["categoryid"].toString();
          spriceCtrl.text = val.barcodeReadedData!["cashprice"].toString();
          currentStockCtrl.text = "0";
          flagCtrl.text = val.barcodeReadedData!["flag"].toString();
          pcspertype.text = val.barcodeReadedData!['pcspertype'].toString();
        } else {
          barcodeCtrl.text =
              val.scannedbarcode != null ? val.scannedbarcode.toString() : "";
          itemCodeCtrl.clear();
          itemnameCtrl.clear();
          categoryCtrl.clear();
          spriceCtrl.clear();
          currentStockCtrl.clear();
          replaceStockCtrl.clear();
          addToCurrentStock.clear();
          qtyTypeCtrl.clear();
          flagCtrl.clear();
          pcspertype.clear();
          categoryIdCtrl.clear();
        }
        // }

        return Column(
          children: [
            Row(
              children: [
                Text(
                  "Server : " + server,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            HomescreenBody(
                remarkCtrl: remarkCtrl,
                sajnoCtrl: sajnoCtrl,
                items: items,
                itemDropCtrl: itemDropCtrl,
                categoryIdCtrl: categoryIdCtrl,
                pcspertype: pcspertype,
                database: database,
                isServerRemote: isServerRemote,
                barcodeReadedData: val.barcodeReadedData,
                addToCurrentStock: addToCurrentStock,
                barcodeCtrl: barcodeCtrl,
                categoryCtrl: categoryCtrl,
                currentStockCtrl: currentStockCtrl,
                replaceStockCtrl: replaceStockCtrl,
                itemCodeCtrl: itemCodeCtrl,
                itemnameCtrl: itemnameCtrl,
                qtyTypeCtrl: qtyTypeCtrl,
                flagCtrl: flagCtrl,
                spriceCtrl: spriceCtrl)
          ],
        );
      }),
    );
  }
}
