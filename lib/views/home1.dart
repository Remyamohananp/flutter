import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qr_scanner/model/item_master_model.dart';
import 'package:qr_scanner/model/po_details_model.dart';
import 'package:qr_scanner/model/po_header_details.dart';
import 'package:qr_scanner/utils/download_all_data.dart';
import 'package:qr_scanner/views/GRV/grv_form.dart';
import 'package:qr_scanner/views/print/print_home.dart';
import 'package:qr_scanner/views/purchase%20enquiry/purchase_enquiry_online.dart';
import 'package:qr_scanner/views/purchase%20order/purchase_order_form.dart';
import 'package:qr_scanner/views/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../db services/db_services.dart';
import '../main.dart';
import '../model/barcode_master_model.dart';
import '../model/grn_details_model.dart';
import '../model/grn_model.dart';
import '../model/online_product_model.dart';
import '../repository/api_repository.dart';
import '../utils/check_server.dart';
import '../utils/loader_dialog.dart';
import '../utils/snackbar.dart';
import 'DOWNLOADS/Sales_settings.dart';
import 'DOWNLOADS/admin_settingss.dart';
import 'DOWNLOADS/download_settings.dart';
import 'DOWNLOADS/inventory_settings.dart';
import 'GRN/grn_form.dart';
import 'barcode master/bracode_master_home.dart';
import 'dashboard_for_settings.dart';
import 'home_screen.dart';
import 'login.dart';

class Home1 extends StatelessWidget {
  final passcontroller = TextEditingController();
  final bool passwordInvisible;
  Home1({super.key, this.passwordInvisible = true});
  DB database = DB();

// void submit(){
//   Navigator.of(context).pop();
// }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "SMART INVENTORY",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        body: GridView(
          shrinkWrap: true,
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.10, vertical: 22),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: size.width * 0.04,
              crossAxisSpacing: size.width * 0.04),
          children: [
            InkWell(
              onTap: () async {
               // downloadAllData(context, database);
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => DownloadForSettings(
                      database: database,)));
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 4,
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.shade300
                          // Color(0xff7090B0),
                          ),
                    ],
                  ),
                  //
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/images/maindasshboard/download.jpeg",
                            height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "DOWNLOAD",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () async {
                // bool isRemote = await checkServer();
                List storeddata = await database.getAllstoredata();
                bool isremote = false;
                if (storeddata.isNotEmpty) {
                  int server = storeddata.last["server"] ?? 1;
                  isremote = server == 0 ? true : false;
                }
                if (isremote) {
                  transparantDialog(context);
                  try {
                    Map res = await ApiRepository().uploadAllData(
                        context: context,
                        database: database,
                        isBarcodePrint: false,
                        barcodePrint: null,
                        flag: 0);
                    if (res["status"] == "success") {
                      navigatorKey.currentState?.pop();
                      showSnackbar("Products updated successfully", context);
                    } else {
                      navigatorKey.currentState?.pop();
                      showSnackbar("Failed to upload products", context);
                    }
                  } catch (e) {
                    navigatorKey.currentState?.pop();
                    showSnackbar(e.toString(), context);
                    //TODO uncomment this in production
                    // showSnackbar("Failed to fetch products", context);
                  }
                } else {
                  showSnackbar("Change server to remote", context);
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 4,
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.shade300
                          // Color(0xff7090B0),
                          ),
                    ],
                  ),


                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/images/maindasshboard/upload.png",
                            height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "UPLOAD",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => InventorySettings(
                      database: database,)));
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 4,
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.shade300
                          // Color(0xff7090B0),
                          ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/images/maindasshboard/inventory.jpeg",
                            height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "INVENTORY",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => SalesSettings(
                      database: database,)));
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 4,
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.shade300
                        // Color(0xff7090B0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/images/maindasshboard/sales.jpeg",
                            height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "SALES",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),


            InkWell(
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(
                         builder: (context) => DashboardForSettingss(
                database: database,))); },


              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 4,
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.shade300
                          // Color(0xff7090B0),
                          ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/images/maindasshboard/admin.jpeg",
                            height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "ADMIN",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                await sp.remove('userName');
                await sp.remove('password');


                navigatorKey.currentState
                    ?.push(MaterialPageRoute(builder: (_) => LoginScreen()));

              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 4,
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.shade300
                          // Color(0xff7090B0),
                          ),
                    ],
                  ),

                  // child: const Center(
                  //     child: Text(
                  //       "Signout",
                  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  //     )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/LOGOUT_11zon.png",
                            height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "SIGNOUT",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => DashboardForSettingss(
                      database: database,))); },


              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 4,
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.shade300
                        // Color(0xff7090B0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/reports.jpeg",

                            height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "REPORTS",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => DashboardForSettingss(
                      database: database,))); },


              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 4,
                          // blurStyle: BlurStyle.inner,
                          color: Colors.grey.shade300
                        // Color(0xff7090B0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/appinfo.png",
                                  height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "APPINFO",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
          ],
        ),

    );
  }
}
