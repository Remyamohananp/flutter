import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/controller/product_controller.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/scan_barcode.dart';
import 'package:qr_scanner/utils/snackbar.dart';
import 'package:qr_scanner/utils/vendor_dropdown.dart';
import 'package:qr_scanner/views/GRN/grn_form_body.dart';
import 'package:qr_scanner/views/GRN/grn_popUp_form_body.dart';
import 'package:qr_scanner/views/GRV/grv_form_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/stock_controller.dart';
import '../../db services/db_services.dart';
import '../../utils/check_server.dart';

class GrvForm extends StatefulWidget {
  final DB database;
  GrvForm({super.key, required this.database});

  @override
  State<GrvForm> createState() => _GrvFormState();
}

class _GrvFormState extends State<GrvForm> {
  final TextEditingController grvNoCtrl = TextEditingController();

  final TextEditingController grvDateCtrl = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));

  final TextEditingController vendorIDCtrl = TextEditingController();

  final TextEditingController vendorNameCtrl = TextEditingController();

  final TextEditingController returnedByCtrl = TextEditingController();

    final TextEditingController remarkCtrl = TextEditingController();
  final TextEditingController grvRefCtrl = TextEditingController();

  Map? selectedVendor;

  final SingleSelectController<Map?> ctrl = SingleSelectController(null);

  DateTime selectedGrvDate = DateTime.now();

  Future<Map> getUserNameAndServerAndnewGrvNo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userName = sp.getString(
          "userName",
        ) ??
        "";
    // bool isremote = await checkServer();
    List vendors = await widget.database.getAllvendors();
    List items = await widget.database.getAllitemmaster();
   

    int newGrvNo = sp.getInt(
          "newGrv",
        ) ??
        1;
    List storeddata = await widget.database.getAllstoredata();
    bool isremote = false;
    if (storeddata.isNotEmpty) {
      int server = storeddata.last["server"] ?? 1;
      isremote = server == 0 ? true : false;
    }

    return {
      "server": isremote,
      "userName": userName,
      "vendors": vendors,
      "items": items,
      "newGrvNo": newGrvNo,
   
    };
  }

  List<Map> gridData = [];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("GRV"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: FutureBuilder(
              future: getUserNameAndServerAndnewGrvNo(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  log(snapshot.data.toString());
                  // bool isServerRemote = snapshot.data["server"] ?? false;
                  bool isServerRemote = false;
                  String userName = snapshot.data["userName"] ?? "";
                  List<Map> vendors = snapshot.data["vendors"] ?? [];
                  List<Map> items = snapshot.data["items"] ?? [];
                
                  int newGrvNo = snapshot.data["newGrvNo"] ?? 1;
                  grvNoCtrl.text = newGrvNo.toString();
                  // recievedByCtrl.text = userName;
                  returnedByCtrl.text = userName;
                  return body(size, isServerRemote, context, userName, vendors,
                      items, newGrvNo);
                } else if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return const Center(child: Text("Something went wrong!"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )));
  }

  //***************************** body */
  Widget body(
      Size size,
      bool isServerRemote,
      BuildContext context,
      String userName,
      List<Map> vendors,
      List<Map> items,
      int grvno,
      
      ) {
    String server = isServerRemote ? "Remote" : "Local";

    return SingleChildScrollView(
        controller: ScrollController(),
        child: GrvFormBody(
            remarkCtrl: remarkCtrl,
            lastGrvno: grvno,
            items: items,
            grvDatePreselected: selectedGrvDate,
            gridDateList: gridData,
            server: server,
            isServerRemote: isServerRemote,
            grvDateCtrl: grvDateCtrl,
            grvNoCtrl: grvNoCtrl,
            vendorIDCtrl: vendorIDCtrl,
            vendorNameCtrl: vendorNameCtrl,
              ctrl: ctrl,
            grvRefCtrl: grvRefCtrl,
            returnedByCtrl: returnedByCtrl,
            database: widget.database,
            vendors: vendors));
  }
}
