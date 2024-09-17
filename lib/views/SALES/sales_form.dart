import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_scanner/views/SALES/sales_form_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db services/db_services.dart';

class SalesForm extends StatefulWidget {
   final DB database;
  const SalesForm({super.key,required this.database});

  @override
  State<SalesForm> createState() => _SalesFormState();
}

class _SalesFormState extends State<SalesForm> {
   final TextEditingController invoiceNoCtrl = TextEditingController();
     final TextEditingController invoiceDateCtrl = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
     final TextEditingController customerIDCtrl = TextEditingController();
  final TextEditingController customerNameCtrl = TextEditingController();
  final TextEditingController trnCtrl = TextEditingController();
  final TextEditingController remarksByCtrl = TextEditingController();

  Map? selectedCustomer;
 final SingleSelectController<Map?> ctrl = SingleSelectController(null);
  final TextEditingController grnRefCtrl = TextEditingController();
  DateTime selectedInvoiceDate = DateTime.now();
   Future<Map> getUserNameAndServerAndnewGrnNo() async{
    SharedPreferences sp = await SharedPreferences.getInstance();

  //  List customerss = await widget.database.getAllcustomers();
     int newInvoiceNo = sp.getInt(
          "newInvoice",
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
     // "customers": customers,
      "newInvoiceNo": newInvoiceNo,
           
    };
    }
    List<Map> gridData = [];
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("Sales"),
        ),
        body:Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child:FutureBuilder(future:  getUserNameAndServerAndnewGrnNo(),
        builder: (context, AsyncSnapshot snapshot) {
           if (snapshot.hasData) {
                  log(snapshot.data.toString());
                  // bool isServerRemote = snapshot.data["server"] ?? false;
                  bool isServerRemote = false;
                    List<Map> customers = snapshot.data["customers"] ?? [];
                   int newInvoiceNo = snapshot.data["newInvoiceNo"] ?? 1;
                  //grnNoCtrl.text = newGrnNo.toString();
                
                  return body(size, isServerRemote, context, customers,
                      );
                } else if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return const Center(child: Text("Something went wrong!"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
        })
        )
    );
  }

  Widget body(
      Size size,
      bool isServerRemote,
      BuildContext context,
           List<Map> customers,
          ) {
     String server = isServerRemote ? "Remote" : "Local";

    return SingleChildScrollView(
        controller: ScrollController(),
        child: SalesFormBody(
           invoiceDatePreselected: selectedInvoiceDate,
            gridDateList: gridData,
            trnCtrl:trnCtrl,
            server: server,
            isServerRemote: isServerRemote,
            invoiceDateCtrl: invoiceDateCtrl,
            invoiceNoCtrl: invoiceNoCtrl,
            customerIDCtrl: customerIDCtrl,
            customerNameCtrl: customerNameCtrl,
            ctrl: ctrl,
            remarksByCtrl: remarksByCtrl,
            database:widget.database,
            customers: customers,
            ));
  }
}


