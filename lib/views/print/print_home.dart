import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/item_master_controller.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/utils/check_server.dart';
import 'package:qr_scanner/utils/items_dropdown.dart';
import 'package:qr_scanner/utils/scan_barcode.dart';
import 'package:qr_scanner/views/print/print_screen_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrintHome extends StatefulWidget {
  final DB database;
  PrintHome({super.key, required this.database});

  @override
  State<PrintHome> createState() => _PrintHomeState();
}

class _PrintHomeState extends State<PrintHome> {
  final TextEditingController barcodeCtrl = TextEditingController();

  final TextEditingController itemNameCtrl = TextEditingController();

  final TextEditingController qtytypeCtrl = TextEditingController();

  final TextEditingController pcsCtrl = TextEditingController();

  final TextEditingController priceCtrl = TextEditingController();

  final TextEditingController printCountCtrl = TextEditingController();

  Future<Map> getUserNameAndServerAndnewGrnNo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userName = sp.getString(
          "userName",
        ) ??
        "";
    // bool isremote = await checkServer();

    // List vendors = await database.getAllvendors();
    List items = await widget.database.getAllitemmaster();

    List storeddata = await widget.database.getAllstoredata();
    bool isremote = false;
    if (storeddata.isNotEmpty) {
      int server = storeddata.last["server"] ?? 1;
      isremote = server == 0 ? true : false;
    }
    return {
      "server": isremote,
      "userName": userName,
      // "vendors": vendors,
      "items": items,
      // "newGrnNo": newGrnNo.toString()
    };
  }

  final SingleSelectController<Map?> itemDropCtrl =
      SingleSelectController(null);

  Map? selectedItem;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemMasterController>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Print"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: FutureBuilder(
              future: getUserNameAndServerAndnewGrnNo(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  log(snapshot.data.toString());
                  bool isServerRemote = false;
                  // String userName = snapshot.data["userName"] ?? "";
                  List<Map> items = snapshot.data["items"] ?? [];

                  return body(size, context, items, isServerRemote);
                } else if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return const Center(child: Text("Something went wrong!"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }

  ///******************************** body */
  Widget body(
      Size size, BuildContext context, List<Map> items, bool isServerRemote) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Consumer<ItemMasterController>(builder: (context, val, child) {
          if (val.barcodeReadedData != null) {
            itemNameCtrl.text =
                val.barcodeReadedData!["barcodespname"].toString();
            qtytypeCtrl.text = val.barcodeReadedData!["qtytype"].toString();
            pcsCtrl.text = val.barcodeReadedData!["pcspertype"].toString();
            barcodeCtrl.text = val.barcodeReadedData!["barcode"].toString();
            if (!val.isItemSearched) {
              itemDropCtrl.value = val.barcodeReadedData;
            }
            priceCtrl.text = val.barcodeReadedData!["cashprice"].toString();
            // selectedItem = val.barcodeReadedData;
          }
          return Column(
            children: [
              PrintScreenBody(
                  itemnameCtrl: itemNameCtrl,
                  selectedItem: selectedItem,
                  isServerRemote: isServerRemote,
                  barcodeCtrl: barcodeCtrl,
                  database: widget.database,
                  qtytypeCtrl: qtytypeCtrl,
                  pcsCtrl: pcsCtrl,
                  priceCtrl: priceCtrl,
                  printCountCtrl: printCountCtrl,
                  itemDropCtrl: itemDropCtrl,
                  items: items)
            ],
          );
        }),
      ),
    );
  }
}
