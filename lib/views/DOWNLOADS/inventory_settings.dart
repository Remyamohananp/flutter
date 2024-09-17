import 'package:flutter/material.dart';
import 'package:qr_scanner/views/sales_settings_form.dart';
import 'package:qr_scanner/views/settings.dart';
import '../../db services/db_services.dart';
import '../../main.dart';
import '../../utils/snackbar.dart';
import '../GRN/grn_form.dart';
import '../GRV/grv_form.dart';
import '../physical stock (online)/physical_stock_online.dart';
import '../print/print_home.dart';
import '../purchase enquiry/purchase_enquiry_online.dart';
import '../purchase order/purchase_order_form.dart';


class InventorySettings extends StatelessWidget {

  InventorySettings({super.key,  required DB database});
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
            " Inventory",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        body: GridView(
          shrinkWrap: true,
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 22),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: size.width * 0.06,
              crossAxisSpacing: size.width * 0.06),
          children: [


            InkWell(
              onTap: () {
                navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => PurchaseOrderForm(
                      database: database,
                    )));
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
                            "assets/images/inventory/PURCHASE ORDER.jpeg",
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
                        "Purchase Order",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => GrnForm(
                      database: database,
                    )));
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
                            "assets/images/inventory/GRN.png",
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
                        "GRN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => GrvForm(database: database)));
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
                              "assets/images/inventory/GRV (PURCHASE RETURN).jpeg",
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
                            "GRV(Purchase Return)",
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
                navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => PhysicalStockOnline(
                      database: database
                    )));
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
                            "assets/images/inventory/PHYSICAL STOCK UPDATE (0NLINE).jpg",
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
                        "Physical Stock Update(Online)",
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
                            "assets/images/inventory/PHYSICAL STOCK UPDATE (OFFLINE).jpeg",
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
                        "Physical Stock Update(Offline)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => PurchaseEnquiryOnline(
                      database: database,
                    )));
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
                            "assets/images/inventory/PRODUCT ENQUIRY AND PRICE CHANGE (ONLINE).jpeg",
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
                        "Product Enquiry|Price Change(Online)",
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
                            "assets/images/inventory/PRODUCT ENQUIRY (OFFLINE).jpeg",
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
                        "Product Enquiry (Offline)",
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
                            "assets/images/inventory/ITEM MASTER UPDATE (ONLINE).jfif",
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
                        "Item Master Update(Online)",
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
                            "assets/images/inventory/item master update (offline).jpeg",
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
                        "Item Master Update (Offline)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                navigatorKey.currentState?.push(MaterialPageRoute(
                    builder: (_) => PrintHome(
                      database: database,
                    )));
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
                            "assets/images/inventory/barcodeprint.jpg",
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
                        "Barcode Print",
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
