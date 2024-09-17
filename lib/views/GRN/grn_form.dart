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
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/stock_controller.dart';
import '../../db services/db_services.dart';
import '../../utils/check_server.dart';

class GrnForm extends StatefulWidget {
  final DB database;
  GrnForm({super.key, required this.database});

  @override
  State<GrnForm> createState() => _GrnFormState();
}

class _GrnFormState extends State<GrnForm> {
  final TextEditingController grnNoCtrl = TextEditingController();

  final TextEditingController grnDateCtrl = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));

  final TextEditingController vendorIDCtrl = TextEditingController();

  final TextEditingController vendorNameCtrl = TextEditingController();

  final TextEditingController recievedByCtrl = TextEditingController();

  final TextEditingController poNoCtrl = TextEditingController();

  final TextEditingController grnRefCtrl = TextEditingController();

  Map? selectedVendor;

  final SingleSelectController<Map?> ctrl = SingleSelectController(null);

  DateTime selectedGrnDate = DateTime.now();

  Future<Map> getUserNameAndServerAndnewGrnNo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userName = sp.getString(
          "userName",
        ) ??
        "";
    // bool isremote = await checkServer();
    List vendors = await widget.database.getAllvendors();
    List items = await widget.database.getAllitemmaster();
    List poheaders = await widget.database.getAllpoheader();
    List poDetails = await widget.database.getAllPoDetails();

    int newGrnNo = sp.getInt(
          "newGrn",
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
      "newGrnNo": newGrnNo,
      "podetails": poDetails,
      "poheaders": poheaders
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
          title: const Text("GRN"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: FutureBuilder(
              future: getUserNameAndServerAndnewGrnNo(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  log(snapshot.data.toString());
                  // bool isServerRemote = snapshot.data["server"] ?? false;
                  bool isServerRemote = false;
                  String userName = snapshot.data["userName"] ?? "";
                  List<Map> vendors = snapshot.data["vendors"] ?? [];
                  List<Map> items = snapshot.data["items"] ?? [];
                  List<Map> poheaders = snapshot.data["poheaders"] ?? [];
                  List<Map> podetails = snapshot.data["podetails"] ?? [];
                  int newGrnNo = snapshot.data["newGrnNo"] ?? 1;
                  grnNoCtrl.text = newGrnNo.toString();
                  // recievedByCtrl.text = userName;
                  recievedByCtrl.text = userName;
                  return body(size, isServerRemote, context, userName, vendors,
                      items, newGrnNo, poheaders, podetails);
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
      int grnno,
      List<Map> poheaders,
      List<Map> podetails) {
    String server = isServerRemote ? "Remote" : "Local";

    return SingleChildScrollView(
        controller: ScrollController(),
        child: GrnFormBody(
            podetails: podetails,
            poheaders: poheaders,
            lastGrnno: grnno,
            items: items,
            grnDatePreselected: selectedGrnDate,
            gridDateList: gridData,
            server: server,
            isServerRemote: isServerRemote,
            grnDateCtrl: grnDateCtrl,
            grnNoCtrl: grnNoCtrl,
            vendorIDCtrl: vendorIDCtrl,
            vendorNameCtrl: vendorNameCtrl,
            poNoCtrl: poNoCtrl,
            ctrl: ctrl,
            grnRefCtrl: grnRefCtrl,
            recievedByCtrl: recievedByCtrl,
            database: widget.database,
            vendors: vendors));
  }
}
