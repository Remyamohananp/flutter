import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/barcode_master_controller.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/utils/categories_dropdown.dart';
import 'package:qr_scanner/utils/check_server.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/scan_barcode.dart';
import 'package:qr_scanner/utils/snackbar.dart';
import 'package:qr_scanner/views/barcode%20master/barcode_master_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db services/db_services.dart';

class BracodeMasterHome extends StatefulWidget {
  final DB database;
  BracodeMasterHome({super.key, required this.database});

  @override
  State<BracodeMasterHome> createState() => _BracodeMasterHomeState();
}

class _BracodeMasterHomeState extends State<BracodeMasterHome> {
  Future<Map> getUserNameAndServer() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userName = sp.getString(
          "userName",
        ) ??
        "";
    // bool isremote = await checkServer();
    List storeddata = await widget.database.getAllstoredata();
    List categories = await widget.database.getAllcategories();
    bool isremote = false;
    if (storeddata.isNotEmpty) {
      int server = storeddata.last["server"] ?? 1;
      isremote = server == 0 ? true : false;
    }
    return {"server": isremote, "userName": userName, "categories": categories};
  }

  final SingleSelectController<Map?> ctrl = SingleSelectController(null);

  final TextEditingController barcodeCtrl = TextEditingController();

  final TextEditingController barcodeSpecificNameCtrl = TextEditingController();

  final TextEditingController cashPriceAfterTaxCtrl = TextEditingController();

  final TextEditingController itemCodeCtrl = TextEditingController();

  final TextEditingController masteritemnameCtrl = TextEditingController();

  final TextEditingController categorynameCtrl = TextEditingController();

  final TextEditingController retailPriceAfterTaxCtrl = TextEditingController();

  final TextEditingController creditPriceAfterTaxCtrl = TextEditingController();

  final TextEditingController categoryIdCtrl = TextEditingController();

  Map? selectedCategory;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BarcodeMasterController>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Barcode Master"),
        ),
        body: FutureBuilder(
          future: getUserNameAndServer(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              log(snapshot.data.toString());
              // bool isServerRemote = snapshot.data["server"] ?? false;
              bool isServerRemote = false;
              String userName = snapshot.data["userName"] ?? "";
              List<Map> categories = snapshot.data["categories"] ?? [];
              // recievedByCtrl.text = userName;

              return body(size, isServerRemote, context, categories);
            } else if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  //********************************** body */
  Widget body(Size size, bool isServerRemote, BuildContext context,
      List<Map> categories) {
    String server = isServerRemote ? "Remote" : "Local";
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child:
            Consumer<BarcodeMasterController>(builder: (context, val, child) {
          if (val.barcodeMasterDetails != null) {
            barcodeCtrl.text = val.barcodeMasterDetails!.barcode;
            barcodeSpecificNameCtrl.text =
                val.barcodeMasterDetails!.barcodespecificname;
            cashPriceAfterTaxCtrl.text =
                val.barcodeMasterDetails!.cashpriceaftertax.toString();
            masteritemnameCtrl.text =
                val.barcodeMasterDetails!.itemmastername.toString();
            categorynameCtrl.text =
                val.barcodeMasterDetails!.categoryid.toString();
            retailPriceAfterTaxCtrl.text =
                val.barcodeMasterDetails!.retailerpriceaftertax.toString();
            creditPriceAfterTaxCtrl.text =
                val.barcodeMasterDetails!.creditpriceaftertax.toString();
            itemCodeCtrl.text = val.barcodeMasterDetails!.itemcode;
            for (var element in categories) {
              if (val.barcodeMasterDetails!.categoryid.toString() ==
                  element["categoryid"].toString()) {
                selectedCategory = element;
                ctrl.value = element;
              }
            }
            categoryIdCtrl.text =
                val.barcodeMasterDetails!.categoryid.toString();
          } else {
            barcodeSpecificNameCtrl.text = "";
            cashPriceAfterTaxCtrl.text = "";
            masteritemnameCtrl.text = "";
            categorynameCtrl.text = "";
            retailPriceAfterTaxCtrl.text = "";
            creditPriceAfterTaxCtrl.text = "";
            itemCodeCtrl.text = "";
            categorynameCtrl.text = "";
            categoryIdCtrl.text = "";
            ctrl.clear();
            selectedCategory = null;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Server : $server",
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              BarcodeMAsterBody(
                isServerRemote: isServerRemote,
                database: widget.database,
                selectedCategory: selectedCategory,
                categories: categories,
                barcodeCtrl: barcodeCtrl,
                barcodeSpecificNameCtrl: barcodeSpecificNameCtrl,
                cashPriceAfterTaxCtrl: cashPriceAfterTaxCtrl,
                categoryIdCtrl: categoryIdCtrl,
                categorynameCtrl: categorynameCtrl,
                creditPriceAfterTaxCtrl: creditPriceAfterTaxCtrl,
                ctrl: ctrl,
                itemCodeCtrl: itemCodeCtrl,
                masteritemnameCtrl: masteritemnameCtrl,
                retailPriceAfterTaxCtrl: retailPriceAfterTaxCtrl,
                server: server,
                onvalueChanged: (cat) {
                  selectedCategory = cat;
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
