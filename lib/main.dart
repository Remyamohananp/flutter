import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_scanner/controller/barcode_master_controller.dart';
import 'package:qr_scanner/controller/item_master_controller.dart';
import 'package:qr_scanner/controller/product_controller.dart';
import 'package:qr_scanner/controller/stock_controller.dart';
import 'package:qr_scanner/http_override.dart';
import 'package:qr_scanner/views/SALES/sales_form.dart';
import 'package:qr_scanner/views/home.dart';
import 'package:qr_scanner/views/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/views/login.dart';
import 'package:qr_scanner/views/physical%20stock%20(online)/physical_stock_online.dart';
import 'package:qr_scanner/views/print/print_home.dart';
import 'package:qr_scanner/views/purchase%20enquiry/purchase_enquiry_online.dart';
import 'package:qr_scanner/views/sales_settings_form.dart';

import 'db services/db_services.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DB database = DB();
  await database.dbInit();
  HttpOverrides.global = MyHttpoverrides();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductController()),
    ChangeNotifierProvider(create: (_) => StockController()),
    ChangeNotifierProvider(create: (_) => BarcodeMasterController()),
    ChangeNotifierProvider(create: (_) => ItemMasterController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DB database = DB();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: PhysicalStockOnline(
        //   database: database,
        // ));

       home: LoginScreen());
  }
}
