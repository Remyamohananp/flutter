import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/main.dart';
import 'package:qr_scanner/model/item_master_model.dart';
import 'package:qr_scanner/model/po_details_model.dart';
import 'package:qr_scanner/model/po_header_details.dart';
import 'package:qr_scanner/repository/api_repository.dart';
import 'package:qr_scanner/utils/loader_dialog.dart';
import 'package:qr_scanner/utils/snackbar.dart';
import 'package:sqflite/sqflite.dart';

downloadAllData(BuildContext context, DB database,
    {bool showToast = true}) async {
  try {
    bool isRemote = true;
    // await checkServer();
    if (isRemote) {
      transparantDialog(context);

      Map res = await ApiRepository().getAllData(context, database);

      if (res["status"] == "success") {
        log(res["vendors"].length.toString());
        log(res["storemaster"].length.toString());
        log(res["poheader"].length.toString());
        log(res["podetails"].length.toString());
        var db = await DB().dbInit();
        await db.transaction((txn) async {
          try {
            // Clear all data
            // await txn.delete('product');
            // await txn.delete('grn');
            // await txn.delete('grndetails');
            // await txn.delete('barcodemaster');
            await txn.delete('vendor');
            await txn.delete('storemaster');
            await txn.delete('categories');
            await txn.delete('itemmaster');
            await txn.delete('poheader');
            await txn.delete('podetails');

            // Insert products
            // List<OnlineProductModel> products = res["data"];
            Batch batch = txn.batch();
            // for (var element in products) {
            //   batch.insert('product', {
            //     'barcode': int.parse(element.barcode),
            //     'itemcode': element.itemcode.toString(),
            //     'itemname': element.mastername,
            //     'qtytype': element.qtyyype,
            //     'category': element.categoryname,
            //     'sprice': element.price,
            //     'stock': element.qty,
            //     'pcspertype': element.pcspertype,
            //     'sajno': element.sajno,
            //     'flag': element.adjtype,
            //   });
            // }
            // await batch.commit(noResult: true);

            // Insert grns
            List<PoHeaderModel> poheaders = res["poheader"];
            batch = txn.batch();
            for (var element in poheaders) {
              batch.insert('poheader', {
                'pono': element.pono,
                'podate': element.podate,
                'vendorid': element.vendorid,
              });
            }
            await batch.commit(noResult: true);

            //Insert po details
            List<PoDetailsModel> grnDetails = res["podetails"];
            batch = txn.batch();
            for (var element in grnDetails) {
              batch.insert('podetails', {
                'pono': element.pono,
                'barcode': element.barcode,
                'qty': element.qty,
                'foc': element.foc,
                'cost': element.rate,
              });
            }
            await batch.commit(noResult: true);

            // Insert vendors
            List vendors = res["vendors"];
            batch = txn.batch();
            for (var element in vendors) {
              batch.insert('vendor', {
                'vendorid': element["vendorid"],
                'vendorname': element["vendorname"],
              });
            }
            await batch.commit(noResult: true);
            List storemaster = res["storemaster"];
            batch = txn.batch();
            for (var element in storemaster) {
              batch.insert('storemaster', {
                'storecode': element["storecode"],
                'storename': element["storename"],
                'storelocation': element["storelocation"]
              });
            }
            await batch.commit(noResult: true);
            // Insert categories
            List categories = res["categoryList"];
            batch = txn.batch();
            for (var element in categories) {
              batch.insert('categories', {
                'categoryid': element["categoryid"],
                'categoryname': element["categoryname"],
              });
            }
            await batch.commit(noResult: true);

            // Insert barcodeMasters
            // List<BarcodeMaster> barcodeMasters =
            //     res["barcodemasters"];
            // batch = txn.batch();
            // for (var element in barcodeMasters) {
            //   batch.insert('barcodemaster', {
            //     'barcode': element.barcode,
            //     'barcodespecificname':
            //         element.barcodespecificname,
            //     'cashpriceaftertax': element.cashpriceaftertax,
            //     'creditpriceaftertax':
            //         element.creditpriceaftertax,
            //     'retailerpriceaftertax':
            //         element.retailerpriceaftertax,
            //     'categoryid': element.categoryid,
            //     'itemmastername': element.itemmastername,
            //     'itemcode': element.itemcode,
            //   });
            // }

            //insert item master

            List<ItemmasterModel> itemmasters = res["itemmasters"];
            for (var element in itemmasters) {
              batch.insert('itemmaster', {
                "itemcode": element.itemcode,
                "mastername": element.itemmastername,
                "barcode": element.barcode,
                "barcodespname": element.barcodespecificname,
                "qtytype": element.qtytype,
                "pcspertype": element.pcspertype,
                "cashprice": element.cashpriceaftertax,
                "categoryid": element.categoryid,
                "cost": element.cost,
                "roqty": element.roqty,
                "creditprice": element.roqty,
                "whprice": element.whprice,
                "flag": element.flag
              });
            }
            await batch.commit(noResult: true);
          } catch (e) {
            log(e.toString());
            log('Error during database operations: $e');
            throw e; // Re-throw to be caught by outer try-catch
          }
        });
        navigatorKey.currentState?.pop();
        if (showToast) {
          showSnackbar("Data loaded successfully", context);
        }
      } else {
        navigatorKey.currentState?.pop();
        if (showToast) {
          showSnackbar("Failed to fetch products", context);
        }
      }
    }
  } catch (e) {
    log(e.toString());
    navigatorKey.currentState?.pop();
    //TODO uncomment this snackbar in production
    // showSnackbar("Failed to fetch products", context);
    if (showToast) {
      showSnackbar(e.toString(), context);
    }
  }
}
