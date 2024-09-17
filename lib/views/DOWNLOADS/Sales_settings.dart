import 'package:flutter/material.dart';
import 'package:qr_scanner/views/sales_settings_form.dart';
import 'package:qr_scanner/views/settings.dart';
import '../../db services/db_services.dart';
import '../../main.dart';
import '../../utils/snackbar.dart';


class SalesSettings extends StatelessWidget {

  SalesSettings({super.key,  required DB database});
  final DB database = DB();

  @override
  Widget build(BuildContext context) {
   final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Colors.blue,
          //automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            " Sales DashBoard",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        body: GridView(
          shrinkWrap: true,
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 22),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: size.width * 0.06,
              crossAxisSpacing: size.width * 0.06),
          children: [


            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/customer master.png",
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
                        "Customer Master",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/QUOTATION.jpeg",
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
                        "Quotation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                  child: GridTile(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              "assets/images/sales/SALES ORDER.png",
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                              // color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Sales Order",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/DELIVERY NOTE.jpeg",
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
                        "Delivery Note",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/SALES.jpeg",
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
                        "Sales",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/SALES RETURN.png",
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
                        "Sales Return",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/SAES AND SALES RETURN VIEW.png",
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
                        "Sales|Sales Return View",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/PENDING INVOICES.png",
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
                        "Pending Invoices",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/CUSTOMER STATEMENT.png",
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
                        "Customer Statement",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/CUSTOMER  RECEIPTS.jpeg",
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
                        "Customer Receipts",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                // navigatorKey.currentState?.push(MaterialPageRoute(
                //     builder: (_) => GrnForm(
                //       database: database,
                //     )));
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
                            "assets/images/sales/COLLECTION REPORT.jpeg",
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
                        "Collection Report",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),

          ],
        ));
  }
  
  }
