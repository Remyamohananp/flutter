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
import 'GRN/grn_form.dart';
import 'barcode master/bracode_master_home.dart';
import 'dashboard_for_settings.dart';
import 'home_screen.dart';
import 'login.dart';

// class Home extends StatelessWidget {
//   final passcontroller = TextEditingController();
//   final bool passwordInvisible;
//   Home({super.key, this.passwordInvisible = true});
//   DB database = DB();

// // void submit(){
// //   Navigator.of(context).pop();
// // }
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.sizeOf(context);

//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           title: const Text(
//             "DashBoard",
//             style: TextStyle(
//                 color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
//           ),
//         ),
//         body: GridView(
//           shrinkWrap: true,
//           padding:
//               EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 22),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: size.width * 0.06,
//               crossAxisSpacing: size.width * 0.06),
//           children: [
//             InkWell(
//               onTap: () async {
//                 try {
//                   bool isRemote = true;
//                   // await checkServer();
//                   if (isRemote) {
//                     transparantDialog(context);

//                     Map res =
//                         await ApiRepository().getAllData(context, database);

//                     if (res["status"] == "success") {
//                       var db = await DB().dbInit();
//                       await db.transaction((txn) async {
//                         try {
//                           // Clear all data
//                           // await txn.delete('product');
//                           // await txn.delete('grn');
//                           // await txn.delete('grndetails');
//                           // await txn.delete('barcodemaster');
//                           await txn.delete('vendor');
//                           await txn.delete('categories');
//                           await txn.delete('itemmaster');

//                           // Insert products
//                           // List<OnlineProductModel> products = res["data"];
//                           Batch batch = txn.batch();
//                           // for (var element in products) {
//                           //   batch.insert('product', {
//                           //     'barcode': int.parse(element.barcode),
//                           //     'itemcode': element.itemcode.toString(),
//                           //     'itemname': element.mastername,
//                           //     'qtytype': element.qtyyype,
//                           //     'category': element.categoryname,
//                           //     'sprice': element.price,
//                           //     'stock': element.qty,
//                           //     'pcspertype': element.pcspertype,
//                           //     'sajno': element.sajno,
//                           //     'flag': element.adjtype,
//                           //   });
//                           // }
//                           // await batch.commit(noResult: true);

//                           // Insert grns
//                           // List<Grn> grns = res["grns"];
//                           // batch = txn.batch();
//                           // for (var element in grns) {
//                           //   batch.insert('grn', {
//                           //     'grnno': element.grnno,
//                           //     'grndate': element.grndate,
//                           //     'vendorid': element.vendorid,
//                           //     'grnref': element.grnref,
//                           //     'recievedby': element.recievedby,
//                           //     'ponumber': element.ponumber,
//                           //   });
//                           // }
//                           // await batch.commit(noResult: true);

//                           // Insert grnDetails
//                           // List<GrnDetail> grnDetails = res["grnDetails"];
//                           // batch = txn.batch();
//                           // for (var element in grnDetails) {
//                           //   batch.insert('grndetails', {
//                           //     'grnno': element.grnno,
//                           //     'barcode': element.barcode,
//                           //     'qty': element.qty,
//                           //     'foc': element.foc,
//                           //     'cost': element.cost,
//                           //   });
//                           // }
//                           // await batch.commit(noResult: true);

//                           // Insert vendors
//                           List vendors = res["vendors"];
//                           batch = txn.batch();
//                           for (var element in vendors) {
//                             batch.insert('vendor', {
//                               'vendorid': element["vendorid"],
//                               'vendorname': element["vendorname"],
//                             });
//                           }
//                           await batch.commit(noResult: true);

//                           // Insert categories
//                           List categories = res["categoryList"];
//                           batch = txn.batch();
//                           for (var element in categories) {
//                             batch.insert('categories', {
//                               'categoryid': element["categoryid"],
//                               'categoryname': element["categoryname"],
//                             });
//                           }
//                           await batch.commit(noResult: true);

//                           // Insert barcodeMasters
//                           // List<BarcodeMaster> barcodeMasters =
//                           //     res["barcodemasters"];
//                           // batch = txn.batch();
//                           // for (var element in barcodeMasters) {
//                           //   batch.insert('barcodemaster', {
//                           //     'barcode': element.barcode,
//                           //     'barcodespecificname':
//                           //         element.barcodespecificname,
//                           //     'cashpriceaftertax': element.cashpriceaftertax,
//                           //     'creditpriceaftertax':
//                           //         element.creditpriceaftertax,
//                           //     'retailerpriceaftertax':
//                           //         element.retailerpriceaftertax,
//                           //     'categoryid': element.categoryid,
//                           //     'itemmastername': element.itemmastername,
//                           //     'itemcode': element.itemcode,
//                           //   });
//                           // }

//                           //insert item master

//                           List<ItemmasterModel> itemmasters =
//                               res["itemmasters"];
//                           for (var element in itemmasters) {
//                             batch.insert('itemmaster', {
//                               "itemcode": element.itemcode,
//                               "mastername": element.itemmastername,
//                               "barcode": element.barcode,
//                               "barcodespname": element.barcodespecificname,
//                               "qtytype": element.qtytype,
//                               "pcspertype": element.pcspertype,
//                               "cashprice": element.cashpriceaftertax,
//                               "categoryid": element.categoryid,
//                               "cost": element.cost,
//                               "roqty": element.roqty,
//                               "creditprice": element.roqty,
//                               "whprice": element.whprice,
//                               "flag": element.flag
//                             });
//                           }
//                           await batch.commit(noResult: true);
//                         } catch (e) {
//                           log('Error during database operations: $e');
//                           throw e; // Re-throw to be caught by outer try-catch
//                         }
//                       });
//                       navigatorKey.currentState?.pop();
//                       showSnackbar("Data loaded successfully", context);
//                     } else {
//                       navigatorKey.currentState?.pop();
//                       showSnackbar("Failed to fetch products", context);
//                     }
//                   } else {
//                     showSnackbar("Change server to remote", context);
//                   }
//                 } catch (e) {
//                   log(e.toString());
//                   navigatorKey.currentState?.pop();
//                   //TODO uncomment this snackbar in production
//                   // showSnackbar("Failed to fetch products", context);
//                   showSnackbar(e.toString(), context);
//                 }
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                         spreadRadius: 4,
//                         blurRadius: 4,
//                         // blurStyle: BlurStyle.inner,
//                         color: Colors.grey.shade300
//                         // Color(0xff7090B0),
//                         ),
//                   ],
//                 ),
//                 //
//                 child: Center(
//                   child: const Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ImageIcon(
//                         AssetImage("assets/img.png"),
//                         color: Colors.blue,
//                         size: 55,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Download",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () async {
//                 // bool isRemote = await checkServer();
//                 List storeddata = await database.getAllstoredata();
//                 bool isremote = false;
//                 if (storeddata.isNotEmpty) {
//                   int server = storeddata.last["server"] ?? 1;
//                   isremote = server == 0 ? true : false;
//                 }
//                 if (isremote) {
//                   transparantDialog(context);
//                   try {
//                     Map res = await ApiRepository().uploadAllData(
//                         context: context,
//                         database: database,
//                         isBarcodePrint: false);
//                     if (res["status"] == "success") {
//                       navigatorKey.currentState?.pop();
//                       showSnackbar("Products updated successfully", context);
//                     } else {
//                       navigatorKey.currentState?.pop();
//                       showSnackbar("Failed to upload products", context);
//                     }
//                   } catch (e) {
//                     navigatorKey.currentState?.pop();
//                     showSnackbar(e.toString(), context);
//                     //TODO uncomment this in production
//                     // showSnackbar("Failed to fetch products", context);
//                   }
//                 } else {
//                   showSnackbar("Change server to remote", context);
//                 }
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                         spreadRadius: 4,
//                         blurRadius: 4,
//                         // blurStyle: BlurStyle.inner,
//                         color: Colors.grey.shade300
//                         // Color(0xff7090B0),
//                         ),
//                   ],
//                 ),
//                 child: Center(
//                   child: const Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ImageIcon(
//                         AssetImage("assets/img_1.png"),
//                         color: Colors.blue,
//                         size: 55,
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Upload",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // child: Center(
//                 //     child: const Text(
//                 //       "Upload ",
//                 //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 //     )),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 navigatorKey.currentState?.push(MaterialPageRoute(
//                     builder: (_) => StockEntry(database: database)));
//               },
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           spreadRadius: 4,
//                           blurRadius: 4,
//                           // blurStyle: BlurStyle.inner,
//                           color: Colors.grey.shade300
//                           // Color(0xff7090B0),
//                           ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Image.asset(
//                             "assets/img_2.png",
//                             height: 75,
//                             width: 75,
//                             // color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Physical Stock",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   )),
//             ),
//             InkWell(
//               onTap: () {
//                 navigatorKey.currentState?.push(MaterialPageRoute(
//                     builder: (_) => GrnForm(
//                           database: database,
//                         )));
//               },
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           spreadRadius: 4,
//                           blurRadius: 4,
//                           // blurStyle: BlurStyle.inner,
//                           color: Colors.grey.shade300
//                           // Color(0xff7090B0),
//                           ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Image.asset(
//                             "assets/mini-truck.png",
//                             height: 75,
//                             width: 75,
//                             // color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "GRN",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   )),
//             ),
//             InkWell(
//               onTap: () {
//                 navigatorKey.currentState?.push(MaterialPageRoute(
//                     builder: (_) => BracodeMasterHome(
//                           database: database,
//                         )));
//               },
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           spreadRadius: 4,
//                           blurRadius: 4,
//                           // blurStyle: BlurStyle.inner,
//                           color: Colors.grey.shade300
//                           // Color(0xff7090B0),
//                           ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Image.asset(
//                             "assets/item.png",
//                             height: 75,
//                             width: 75,
//                             // color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "ItemMasterUpdate",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   )),
//             ),
//             InkWell(
//               onTap: () async {
//                 SharedPreferences sp = await SharedPreferences.getInstance();
//                 sp.clear();
//                 navigatorKey.currentState?.push(MaterialPageRoute(
//                     builder: (_) => PrintHome(
//                           database: database,
//                         )));
//               },
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           spreadRadius: 4,
//                           blurRadius: 4,
//                           // blurStyle: BlurStyle.inner,
//                           color: Colors.grey.shade300
//                           // Color(0xff7090B0),
//                           ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Image.asset(
//                             "assets/bar.png",
//                             height: 75,
//                             width: 75,
//                             // color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Barcode",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   )),
//             ),
//             InkWell(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text("Type password here"),
//                     content: TextField(
//                       autofocus: true,
//                       decoration: InputDecoration(),
//                       controller: passcontroller,
//                       obscureText: passwordInvisible,
//                     ),
//                     actions: [
//                       ElevatedButton(
//                           onPressed: () {
//                             String Password = "a";
//                             if (passcontroller.text == Password) {
//                               print(passcontroller.text);
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Settings(
//                                             database: database,
//                                           )));
//                             } else {
//                               showSnackbar("Type Password Correctly", context);
//                             }
//                           },
//                           child: Text('submit')),
//                       ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Text('Cancel'))
//                     ],
//                   ),
//                 );
//                 // showDialog(context: context, builder:(context)=> AlertDialog(
//                 //  title: Text('Type Password'),
//                 //
//                 //    content: TextField(autofocus: true,
//                 //      decoration: InputDecoration(),
//                 //    controller: passcontroller,),
//                 //   actions: [
//                 //     TextButton(onPressed: () async {
//                 //       String Password = "123";
//                 //       if ( password.text == Password) {
//                 //
//                 //  Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));

//                 //
//                 //     }
//                 //     },child: Text('submit'))
//                 //     //cancelButton,
//                 //     //continueButton,
//                 //   ],
//                 // ),
//                 // );
//                 //  navigatorKey.currentState
//                 //      ?.push(MaterialPageRoute(builder: (_) => showAlertDialog(context)));
//               },
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           spreadRadius: 4,
//                           blurRadius: 4,
//                           // blurStyle: BlurStyle.inner,
//                           color: Colors.grey.shade300
//                           // Color(0xff7090B0),
//                           ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Image.asset(
//                             "assets/distance.png",
//                             height: 75,
//                             width: 75,
//                             // color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Settings",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   )),
//             ),
//             InkWell(
//               onTap: () async {
//                 SharedPreferences sp = await SharedPreferences.getInstance();
//                 sp.clear();
//                 navigatorKey.currentState
//                     ?.push(MaterialPageRoute(builder: (_) => LoginScreen()));
//               },
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           spreadRadius: 4,
//                           blurRadius: 4,
//                           // blurStyle: BlurStyle.inner,
//                           color: Colors.grey.shade300
//                           // Color(0xff7090B0),
//                           ),
//                     ],
//                   ),
//                   child: const Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         //  Icon(Icons.auto_stories),

//                         ImageIcon(
//                           AssetImage("assets/img_3.png"),
//                           color: Colors.red,
//                           size: 55,
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "SignOut",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                       ],
//                     ),
//                   )
//                   // child: const Center(
//                   //     child: Text(
//                   //       "Signout",
//                   //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                   //     )),
//                   ),
//             ),
//           ],
//         ));
//   }
// }

class Home extends StatelessWidget {
  final passcontroller = TextEditingController();
  final bool passwordInvisible;
  Home({super.key, this.passwordInvisible = true});
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
            "DashBoard",
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
              onTap: () async {
                downloadAllData(context, database);
                // try {
                //   bool isRemote = true;
                //   // await checkServer();
                //   if (isRemote) {
                //     transparantDialog(context);

                //     Map res =
                //         await ApiRepository().getAllData(context, database);

                //     if (res["status"] == "success") {
                //       log(res["vendors"].length.toString());
                //       log(res["poheader"].length.toString());
                //       log(res["podetails"].length.toString());
                //       var db = await DB().dbInit();
                //       await db.transaction((txn) async {
                //         try {
                //           // Clear all data
                //           // await txn.delete('product');
                //           // await txn.delete('grn');
                //           // await txn.delete('grndetails');
                //           // await txn.delete('barcodemaster');
                //           await txn.delete('vendor');
                //           await txn.delete('categories');
                //           await txn.delete('itemmaster');
                //           await txn.delete('poheader');
                //           await txn.delete('podetails');

                //           // Insert products
                //           // List<OnlineProductModel> products = res["data"];
                //           Batch batch = txn.batch();
                //           // for (var element in products) {
                //           //   batch.insert('product', {
                //           //     'barcode': int.parse(element.barcode),
                //           //     'itemcode': element.itemcode.toString(),
                //           //     'itemname': element.mastername,
                //           //     'qtytype': element.qtyyype,
                //           //     'category': element.categoryname,
                //           //     'sprice': element.price,
                //           //     'stock': element.qty,
                //           //     'pcspertype': element.pcspertype,
                //           //     'sajno': element.sajno,
                //           //     'flag': element.adjtype,
                //           //   });
                //           // }
                //           // await batch.commit(noResult: true);

                //           // Insert grns
                //           List<PoHeaderModel> poheaders = res["poheader"];
                //           batch = txn.batch();
                //           for (var element in poheaders) {
                //             batch.insert('poheader', {
                //               'pono': element.pono,
                //               'podate': element.podate,
                //               'vendorid': element.vendorid,
                //             });
                //           }
                //           await batch.commit(noResult: true);

                //           //Insert po details
                //           List<PoDetailsModel> grnDetails = res["podetails"];
                //           batch = txn.batch();
                //           for (var element in grnDetails) {
                //             batch.insert('podetails', {
                //               'pono': element.pono,
                //               'barcode': element.barcode,
                //               'qty': element.qty,
                //               'foc': element.foc,
                //               'cost': element.rate,
                //             });
                //           }
                //           await batch.commit(noResult: true);

                //           // Insert vendors
                //           List vendors = res["vendors"];
                //           batch = txn.batch();
                //           for (var element in vendors) {
                //             batch.insert('vendor', {
                //               'vendorid': element["vendorid"],
                //               'vendorname': element["vendorname"],
                //             });
                //           }
                //           await batch.commit(noResult: true);

                //           // Insert categories
                //           List categories = res["categoryList"];
                //           batch = txn.batch();
                //           for (var element in categories) {
                //             batch.insert('categories', {
                //               'categoryid': element["categoryid"],
                //               'categoryname': element["categoryname"],
                //             });
                //           }
                //           await batch.commit(noResult: true);

                //           // Insert barcodeMasters
                //           // List<BarcodeMaster> barcodeMasters =
                //           //     res["barcodemasters"];
                //           // batch = txn.batch();
                //           // for (var element in barcodeMasters) {
                //           //   batch.insert('barcodemaster', {
                //           //     'barcode': element.barcode,
                //           //     'barcodespecificname':
                //           //         element.barcodespecificname,
                //           //     'cashpriceaftertax': element.cashpriceaftertax,
                //           //     'creditpriceaftertax':
                //           //         element.creditpriceaftertax,
                //           //     'retailerpriceaftertax':
                //           //         element.retailerpriceaftertax,
                //           //     'categoryid': element.categoryid,
                //           //     'itemmastername': element.itemmastername,
                //           //     'itemcode': element.itemcode,
                //           //   });
                //           // }

                //           //insert item master

                //           List<ItemmasterModel> itemmasters =
                //               res["itemmasters"];
                //           for (var element in itemmasters) {
                //             batch.insert('itemmaster', {
                //               "itemcode": element.itemcode,
                //               "mastername": element.itemmastername,
                //               "barcode": element.barcode,
                //               "barcodespname": element.barcodespecificname,
                //               "qtytype": element.qtytype,
                //               "pcspertype": element.pcspertype,
                //               "cashprice": element.cashpriceaftertax,
                //               "categoryid": element.categoryid,
                //               "cost": element.cost,
                //               "roqty": element.roqty,
                //               "creditprice": element.roqty,
                //               "whprice": element.whprice,
                //               "flag": element.flag
                //             });
                //           }
                //           await batch.commit(noResult: true);
                //         } catch (e) {
                //           log(e.toString());
                //           log('Error during database operations: $e');
                //           throw e; // Re-throw to be caught by outer try-catch
                //         }
                //       });
                //       navigatorKey.currentState?.pop();
                //       showSnackbar("Data loaded successfully", context);
                //     } else {
                //       navigatorKey.currentState?.pop();
                //       showSnackbar("Failed to fetch products", context);
                //     }
                //   } else {
                //     showSnackbar("Change server to remote", context);
                //   }
                // } catch (e) {
                //   log(e.toString());
                //   navigatorKey.currentState?.pop();
                //   //TODO uncomment this snackbar in production
                //   // showSnackbar("Failed to fetch products", context);
                //   showSnackbar(e.toString(), context);
                // }
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
                            "assets/DOWNLOAD_11zon.png",
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
                        "Download",
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

                  // child: Center(
                  //     child: const Text(
                  //       "Upload ",
                  //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  //     )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/UPLOAD_11zon.png",
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
                        "Upload",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                navigatorKey.currentState?.push(MaterialPageRoute(
                   builder: (_) => GrvForm(database: database)));
                  
                   // builder: (_) => StockEntry(database: database)));
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
                            "assets/physical stock_11zon.png",
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
                      //  "Physical Stock",
                      "GRV",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            // InkWell(
            //   onTap: () {
            //     navigatorKey.currentState?.push(MaterialPageRoute(
            //        // builder: (_) => GrvForm(database: database)));
            //
            //      builder: (_) => StockEntry(database: database)));
            //   },
            //   child: Container(
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(12),
            //         color: Colors.white,
            //         boxShadow: [
            //           BoxShadow(
            //               spreadRadius: 4,
            //               blurRadius: 4,
            //               // blurStyle: BlurStyle.inner,
            //               color: Colors.grey.shade300
            //             // Color(0xff7090B0),
            //           ),
            //         ],
            //       ),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Center(
            //             child: Padding(
            //               padding: const EdgeInsets.all(4.0),
            //               child: Image.asset(
            //                 "assets/physical stock_11zon.png",
            //                 height: 75,
            //                 width: 75,
            //                 // color: Colors.white,
            //               ),
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 10,
            //           ),
            //           Text(
            //             //  "Physical Stock",
            //             "stockadj",
            //             style: TextStyle(
            //                 fontSize: 18, fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       )),
            // ),
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
                            "assets/GRN_11zon.png",
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
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
                            "assets/GRN_11zon.png",
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
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            // InkWell(
            //   onTap: () {
            //     navigatorKey.currentState?.push(MaterialPageRoute(
            //         builder: (_) => BracodeMasterHome(
            //               database: database,
            //             )));
            //   },
            //   child: Container(
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(12),
            //         color: Colors.white,
            //         boxShadow: [
            //           BoxShadow(
            //               spreadRadius: 4,
            //               blurRadius: 4,
            //               // blurStyle: BlurStyle.inner,
            //               color: Colors.grey.shade300
            //               // Color(0xff7090B0),
            //               ),
            //         ],
            //       ),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Center(
            //             child: Padding(
            //               padding: const EdgeInsets.all(4.0),
            //               child: Image.asset(
            //                 "assets/ITEM MASTER_11zon.png",
            //                 height: 75,
            //                 width: 75,
            //                 // color: Colors.white,
            //               ),
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 10,
            //           ),
            //           Text(
            //             "ItemUpdate",
            //             style: TextStyle(
            //                 fontSize: 18, fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       )),
            // ),
            InkWell(
              onTap: () async {
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
                            "assets/BARCODE PRINT_11zon.png",
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () async {
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
                            "assets/pr enquiry 2.png",
                            height: 75,
                            width: 75,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Product Enquiry",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(
                         builder: (context) => DashboardForSettings(
                database: database,))); },
                // showDialog(
                //   context: context,
                //   builder: (context) => AlertDialog(
                //     title: Text("Type password "),
                //     content: TextField(
                //       autofocus: true,
                //       decoration: InputDecoration(),
                //       controller: passcontroller,
                //       obscureText: passwordInvisible,
                //     ),
                //     actions: [
                //       ElevatedButton(
                //           onPressed: () {
                //             String Password = "@@@999**";
                //             if (passcontroller.text == Password) {
                //               print(passcontroller.text);
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) => DashboardForSettings(
                //                             database: database,
                //                           )));
                //             } else {
                //               showSnackbar("Type Password Correctly", context);
                //             }
                //           },
                //           child: Text('submit')),
                //       ElevatedButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: Text('Cancel'))
                //     ],
                //   ),
                // );


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
                            "assets/SETTINGS_11zon.png",
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
                        "Admin",
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
                        "SignOut",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
