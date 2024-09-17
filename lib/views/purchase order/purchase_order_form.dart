import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:qr_scanner/views/purchase%20order/purchaseorder_form_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db services/db_services.dart';

class PurchaseOrderForm extends StatefulWidget {
  final DB database;
  PurchaseOrderForm({super.key, required this.database});

  @override
  State<PurchaseOrderForm> createState() => _PurchaseOrderFormState();
}

class _PurchaseOrderFormState extends State<PurchaseOrderForm> {
  final TextEditingController poDateCtrl = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));

  final TextEditingController vendorIDCtrl = TextEditingController();

  final TextEditingController vendorNameCtrl = TextEditingController();

  final TextEditingController enteredByCtrl = TextEditingController();

  final TextEditingController poNoCtrl = TextEditingController();
  final TextEditingController remarkCtrl = TextEditingController();

  Map? selectedVendor;

  final SingleSelectController<Map?> ctrl = SingleSelectController(null);

  DateTime selectedPoDate = DateTime.now();

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

    int newPoNo = sp.getInt(
          "newPoNo",
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
      "newPoNo": newPoNo,
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text("PURCHASE ORDER"),
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
                  int newPoNo = snapshot.data["newPoNo"] ?? 1;
                  poNoCtrl.text = newPoNo.toString();
                  // recievedByCtrl.text = userName;
                  enteredByCtrl.text = userName;
                  return body(size, isServerRemote, context, userName, vendors,
                      items, newPoNo, poheaders, podetails);
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
      int poNo,
      List<Map> poheaders,
      List<Map> podetails) {
    String server = isServerRemote ? "Remote" : "Local";

    return SingleChildScrollView(
        controller: ScrollController(),
        child: purchaseorderFormBody(
            remarkCtrl: remarkCtrl,
            podetails: podetails,
            poheaders: poheaders,
            lastPono: poNo,
            items: items,
            poDatePreselected: selectedPoDate,
            gridDateList: gridData,
            server: server,
            isServerRemote: isServerRemote,
            poDateCtrl: poDateCtrl,
            vendorIDCtrl: vendorIDCtrl,
            vendorNameCtrl: vendorNameCtrl,
            poNoCtrl: poNoCtrl,
            ctrl: ctrl,
            enteredByCtrl: enteredByCtrl,
            database: widget.database,
            vendors: vendors));
  }
}
