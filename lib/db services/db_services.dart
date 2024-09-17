import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  Future<Database> dbInit() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'save.db'),
      onCreate: (db, version) async {
        // await db.execute(
        //   'CREATE TABLE product(id INTEGER, barcode INTEGER PRIMARY KEY,itemcode TEXT, itemname TEXT, qtytype TEXT,category TEXT,sprice REAL,stock INTEGER,flag TEXT,sajno INTEGER,pcspertype REAL)',
        // );
        await db.execute(
          'CREATE TABLE vendor(id INTEGER, vendorid INTEGER PRIMARY KEY,vendorname TEXT)',
        );
        await db.execute(
          'CREATE TABLE barcodemaster(id INTEGER,barcode TEXT,barcodespecificname TEXT,cashpriceaftertax REAL,creditpriceaftertax REAL,retailerpriceaftertax REAL,categoryid INTEGER,itemmastername TEXT,itemcode TEXT)',
        );
        await db.execute(
          'CREATE TABLE grn(id INTEGER,grnno INTEGER PRIMARY KEY,grndate TEXT,vendorid INTEGER,grnref TEXT,recievedby TEXT,ponumber TEXT)',
        );
        await db.execute(
          'CREATE TABLE grndetails(id INTEGER,grnno INTEGER,barcode TEXT,qty INTEGER,foc REAL,cost REAL)',
        );
        await db.execute(
          'CREATE TABLE categories(id INTEGER,categoryid INTEGER,categoryname TEXT)',
        );
        await db.execute(
          'CREATE TABLE itemmaster(itemcode INTEGER,mastername TEXT,categoryid INTEGER,barcode TEXT,barcodespname TEXT,qtytype TEXT,pcspertype REAL,cost REAL,roqty REAL,cashprice REAL,creditprice REAL,whprice REAL,flag TEXT,taxpercentage REAL,taxcode INTEGER)',
        );
        await db.execute(
          'CREATE TABLE sajheader(sajno INTEGER,sajdate TEXT,enteredby TEXT,remarks TEXT,companycode INTEGER)',
        );
        await db.execute(
          'CREATE TABLE grv(id INTEGER,grvno INTEGER PRIMARY KEY,grvdate TEXT,vendorid INTEGER,grvref TEXT,returnedby TEXT,remarkCtrl TEXT)',
        );
        await db.execute(
          'CREATE TABLE grvdetails(id INTEGER,grvno INTEGER,barcode TEXT,qty INTEGER,reason TEXT,cost REAL)',
        );
        await db.execute(
          'CREATE TABLE sajdetails(sajno INTEGER,barcode TEXT,itemname TEXT,qtytype TEXT,storecode INTEGER,qty INTEGER,adjtype TEXT,cost REAL,companycode INTEGER)',
        );
        await db.execute(
          'CREATE TABLE barcodeprint(barcode TEXT,itemname TEXT,rate TEXT,printcount INTEGER,printdatetime TEXT)',
        );
        await db.execute(
          'CREATE TABLE storedata(ip TEXT,terminal TEXT,server INTEGER)',
        );

        await db.execute(
          'CREATE TABLE poheader(id INTEGER,pono INTEGER,podate TEXT,vendorid INTEGER,enteredby TEXT,remark TEXT)',
        );
        await db.execute(
          'CREATE TABLE podetails(id INTEGER,pono INTEGER,barcode TEXT,qty INTEGER,foc REAL,cost REAL)',
        );
        await db.execute(
          'CREATE TABLE invoiceheader(id INTEGER,invoiceno INTEGER,invoicedate TEXT,customerid INTEGER,invoicetype TEXT, lpono INTEGER,storecode INTEGER,invoiceamount REAL,taxamount REAL,discount REAL,paidamount REAL,duedate TEXT,ivtime TEXT,cashtendered REAL,status TEXT,reason TEXT,crlogin TEXT,crdate TEXT,totaldiscount REAL,specificname TEXT,trn TEXT,salesource TEXT,companycode INTEGER,salesman TEXT,ivseries TEXT)',
        );
        await db.execute(
          'CREATE TABLE invoicedetails(id INTEGER,invoiceno INTEGER,barcode TEXT,itemname TEXT,qtytype TEXT,qty INTEGER,foc REAL,rate  REAL,cost REAL, discper REAL,discount REAL,tbt REAL,taxper REAL,tax REAL,tat REAL,batch TEXT,expiry TEXT,serial TEXT,status TEXT,returnflag TEXT,crlogin TEXT,crdate TEXT,salesource TEXT,companycode INTEGER,ivid TEXT,ivseries INTEGER)',
        );
        await db.execute(
          'CREATE TABLE mobilervpdt(id INTEGER,rvno INTEGER,rvdate TEXT,customerid INTEGER,amount REAL,paytype TEXT,sourcetype TEXT,description TEXT,bankname TEXT,chequedate TEXT,chequeno INTEGER,source TEXT,salesman TEXT,adjusted INTEGER, refno TEXT, companycode INTEGER,status TEXT,mobrvid INTEGER)',
        );
        await db.execute(
          'CREATE TABLE storemaster(storecode INTEGER,storename TEXT,storelocation TEXT)',
        );

        await db.execute(
          'CREATE TABLE sajdetailslive(sajno INTEGER,barcode TEXT,itemname TEXT,qtytype TEXT,storecode INTEGER,qty INTEGER,adjtype TEXT,cost REAL,currentstock REAL,replaceqty REAL, addonqty REAL ,companycode INTEGER)',
        );
        await db.execute(
          'CREATE TABLE sajheaderlive (sajno INTEGER,sajdate TEXT,enteredby TEXT,remarks TEXT,companycode INTEGER)',
        );
      },
      version: 6,
    );
  }

  // Future insertdata(
  //     int barcode,
  //     String itemCode,
  //     String itemName,
  //     String qtyType,
  //     String category,
  //     double sprice,
  //     int stock,
  //     double pcspertype,
  //     int sajno,
  //     String flag) async {
  //   var db = await dbInit();
  //   var copy =
  //       await db.rawQuery("SELECT * FROM product WHERE barcode= '$barcode'");

  //   if (copy.isEmpty) {
  //     var value = {
  //       'barcode': barcode,
  //       'itemcode': itemCode,
  //       'itemname': itemName,
  //       'qtytype': qtyType,
  //       'category': category,
  //       'sprice': sprice,
  //       'stock': stock,
  //       'flag': flag,
  //       "sajno": sajno,
  //       "pcspertype": pcspertype
  //     };
  //     // var result =
  //     await db.insert(
  //       'product',
  //       value,
  //     );
  //     // var data =
  //     await db.rawQuery("SELECT * FROM product");
  //   } else {
  //     await db.rawQuery(
  //       "UPDATE product SET itemcode = ?,itemname = ?,qtytype = ?,category = ?, sprice = ?, stock = ?,flag = ?,sajno = ?,pcspertype = ? WHERE barcode = '$barcode'",
  //       [
  //         itemCode,
  //         itemName,
  //         qtyType,
  //         category,
  //         sprice,
  //         stock,
  //         flag,
  //         sajno,
  //         pcspertype
  //       ],
  //     );
  //     // await db.rawQuery(
  //     //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
  //     // var data =
  //     var datas = await db.rawQuery("SELECT * FROM product");
  //     log(datas.toString());
  //   }
  // }

  // Future<List> getProductByBarcode(int barcode) async {
  //   var db = await dbInit();
  //   var copy =
  //       await db.rawQuery("SELECT * FROM product WHERE barcode= '$barcode'");
  //   log(barcode.toString(), name: "barcode");
  //   log(copy.toString(), name: "result");
  //   return copy;
  // }

  // Future<List> getAllDataFromDB() async {
  //   var db = await dbInit();
  //   var copy = await db.rawQuery("SELECT * FROM product");
  //   log(copy.toString(), name: "result");
  //   return copy;
  // }

  // Future clearProducts() async {
  //   var db = await dbInit();
  //   await db.rawQuery("DELETE FROM product");
  // }
  //*******************grv***********************//
  Future insertGrv(
    String grvdate,
    String grvref,
    String returnedby,
    int grvno,
    String remarkCtrl,
    int vendorid,
  ) async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM grv WHERE grvno= '$grvno'");

    if (copy.isEmpty) {
      var value = {
        'grvno': grvno,
        'grvdate': grvdate,
        'vendorid': vendorid,
        'grvref': grvref,
        'returnedby': returnedby,
        "remarkCtrl": remarkCtrl,
      };
      // var result =
      await db.insert(
        'grv',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM grv");
    } else {
      await db.rawQuery(
        "UPDATE grv SET grvno = ?,grvdate = ?,vendorid = ?,grvref = ?,returnedby = ? , remarkCtrl=?  WHERE grvno = '$grvno'",
        [grvno, grvdate, vendorid, grvref, returnedby, remarkCtrl],
      );
      // await db.rawQuery(
      //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
      // var data =
      var datas = await db.rawQuery("SELECT * FROM grv");
      log(datas.toString());
    }
  }

  Future<List> getAllGrv() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM grv");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearGrv() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM grv");
  }

  Future getGrvByGrvNo(int grvno) async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM grv WHERE grvno= '$grvno'");
    return copy;
  }

  removeGrv(int grvno) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'grv',
      where: 'grvno = ?',
      whereArgs: [grvno],
    );
  }

  //***********************grv**************************//
  //******************************grvdetails*************************//

  Future insertGrvDetails(
      String barcode, int grvno, int qty, String reason, double cost) async {
    var db = await dbInit();
    // var copy = await db.rawQuery(
    //     "SELECT * FROM grndetails WHERE grnno = ? AND barcode = ?",
    //     [grnno, barcode]);
    // await db.rawQuery("SELECT * FROM grndetails WHERE grnno= '$grnno'");

    // if (copy.isEmpty) {
    var value = {
      'barcode': barcode,
      'grvno': grvno,
      'qty': qty,
      'reason': reason,
      "cost": cost
    };
    // var result =
    await db.insert(
      'grvdetails',
      value,
    );
    // var data =
    await db.rawQuery("SELECT * FROM grvdetails");
    // } else {
    //   await db.rawQuery(
    //     "UPDATE grndetails SET grnno = ?,barcode = ?,qty = ?,foc = ?,cost = ? WHERE grnno = '$grnno'",
    //     [grnno, barcode, qty, foc, cost],
    //   );
    //   // await db.rawQuery(
    //   //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
    //   // var data =
    //   var datas = await db.rawQuery("SELECT * FROM grndetails");
    // log(datas.toString());
    // }
  }

  Future<List> getAllGrvDetails() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM grvdetails");
    log(copy.toString(), name: "result");
    return copy;
  }

  removeGrvDetails(int grvno) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'grvdetails',
      where: 'grvno = ?',
      whereArgs: [grvno],
    );
  }

  Future clearGrvDetails() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM grvdetails");
  }

  Future getGrvDetailsByGrvNo(int grvno) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM grvdetails WHERE grvno= '$grvno'");
    return copy;
  }

  //*****************************grv************************//
  //**************************************** vendor table queries */
  Future insertVendor(
    int vendorID,
    String vendorName,
  ) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM vendor WHERE vendorid= '$vendorID'");

    if (copy.isEmpty) {
      var value = {
        'vendorid': vendorID,
        'vendorname': vendorName,
      };
      // var result =
      await db.insert(
        'vendor',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM vendor");
    } else {
      await db.rawQuery(
        "UPDATE vendor SET vendorid = ?,vendorname = ?,WHERE vendorid = '$vendorID'",
        [
          vendorID,
          vendorName,
        ],
      );
      // await db.rawQuery(
      //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
      // var data =
      var datas = await db.rawQuery("SELECT * FROM vendor");
      log(datas.toString());
    }
  }

  Future<List> getAllvendors() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM vendor");
    log(copy.toString(), name: "vendors");
    log(copy.length.toString(), name: "vendors");
    return copy;
  }

  Future clearVendor() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM vendor");
  }
//****************************************** barcode master table queries */

  Future insertBarcodeMaster(
      String barcode,
      String barcodespecificname,
      double cashpriceaftertax,
      double creditpriceaftertax,
      double retailerpriceaftertax,
      int categoryid,
      String itemmastername,
      String itemcode) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM barcodemaster WHERE barcode= '$barcode'");

    if (copy.isEmpty) {
      var value = {
        'barcode': barcode,
        'barcodespecificname': barcodespecificname,
        'cashpriceaftertax': cashpriceaftertax,
        'creditpriceaftertax': creditpriceaftertax,
        'retailerpriceaftertax': retailerpriceaftertax,
        'categoryid': categoryid,
        'itemmastername': itemmastername,
        "itemcode": itemcode
      };
      // var result =
      await db.insert(
        'barcodemaster',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM barcodemaster");
    } else {
      await db.rawQuery(
        "UPDATE barcodemaster SET barcode = ?,barcodespecificname = ?,cashpriceaftertax = ?,creditpriceaftertax = ?,retailerpriceaftertax = ?,categoryid = ?,itemmastername = ? WHERE barcode = '$barcode'",
        [
          barcode,
          barcodespecificname,
          cashpriceaftertax,
          creditpriceaftertax,
          retailerpriceaftertax,
          categoryid,
          itemmastername,
        ],
      );
      // await db.rawQuery(
      //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
      // var data =
      var datas = await db.rawQuery("SELECT * FROM barcodemaster");
      log(datas.toString());
    }
  }

  Future<List> getAllbarcodemaster() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM barcodemaster");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future<List> getBarcodeMasterByBarcode(String barcode) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM barcodemaster WHERE barcode= '$barcode'");
    log(barcode.toString(), name: "barcode");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearbarcodemaster() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM barcodemaster");
  }
// ****************************************** grn table queries ********************

  Future insertGrn(
    String grndate,
    String grnref,
    String recievedby,
    int grnno,
    String ponumber,
    int vendorid,
  ) async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM grn WHERE grnno= '$grnno'");

    if (copy.isEmpty) {
      var value = {
        'grnno': grnno,
        'grndate': grndate,
        'vendorid': vendorid,
        'grnref': grnref,
        'recievedby': recievedby,
        "ponumber": ponumber
      };
      // var result =
      await db.insert(
        'grn',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM grn");
    } else {
      await db.rawQuery(
        "UPDATE grn SET grnno = ?,grndate = ?,vendorid = ?,grnref = ?,recievedby = ?,ponumber = ? WHERE grnno = '$grnno'",
        [grnno, grndate, vendorid, grnref, recievedby, ponumber],
      );
      // await db.rawQuery(
      //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
      // var data =
      var datas = await db.rawQuery("SELECT * FROM grn");
      log(datas.toString());
    }
  }

  Future<List> getAllGrn() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM grn");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearGrn() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM grn");
  }

  Future getGrnByGrnNo(int grnno) async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM grn WHERE grnno= '$grnno'");
    return copy;
  }

  removeGrn(int grnno) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'grn',
      where: 'grnno = ?',
      whereArgs: [grnno],
    );
  }

  //****************************************************** grn details queries */

  Future insertGrnDetails(
      String barcode, int grnno, int qty, double foc, double cost) async {
    var db = await dbInit();
    // var copy = await db.rawQuery(
    //     "SELECT * FROM grndetails WHERE grnno = ? AND barcode = ?",
    //     [grnno, barcode]);
    // await db.rawQuery("SELECT * FROM grndetails WHERE grnno= '$grnno'");

    // if (copy.isEmpty) {
    var value = {
      'grnno': grnno,
      'barcode': barcode,
      'qty': qty,
      'foc': foc,
      "cost": cost
    };
    // var result =
    await db.insert(
      'grndetails',
      value,
    );
    // var data =
    await db.rawQuery("SELECT * FROM grndetails");
    // } else {
    //   await db.rawQuery(
    //     "UPDATE grndetails SET grnno = ?,barcode = ?,qty = ?,foc = ?,cost = ? WHERE grnno = '$grnno'",
    //     [grnno, barcode, qty, foc, cost],
    //   );
    //   // await db.rawQuery(
    //   //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
    //   // var data =
    //   var datas = await db.rawQuery("SELECT * FROM grndetails");
    // log(datas.toString());
    // }
  }

  Future<List> getAllGrnDetails() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM grndetails");
    log(copy.toString(), name: "result");
    return copy;
  }

  removeGrnDetails(int grnno) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'grndetails',
      where: 'grnno = ?',
      whereArgs: [grnno],
    );
  }

  Future clearGrnDetails() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM grndetails");
  }

  Future getGrnDetailsByGrnNo(int grnno) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM grndetails WHERE grnno= '$grnno'");
    return copy;
  }
  //****************************************************** category queries */

  Future insertcategories(
    String categoryname,
    int categoryid,
  ) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM categories WHERE categoryid= '$categoryid'");

    if (copy.isEmpty) {
      var value = {"categoryid": categoryid, "categoryname": categoryname};
      // var result =
      await db.insert(
        'categories',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM categories");
    } else {
      await db.rawQuery(
        "UPDATE categories SET categoryid = ?,categoryname = ?,WHERE categoryid = '$categoryid'",
        [
          categoryid,
          categoryname,
        ],
      );
      // await db.rawQuery(
      //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
      // var data =
      var datas = await db.rawQuery("SELECT * FROM categories");
      log(datas.toString());
    }
  }

  Future<List> getAllcategories() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM categories");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearcategories() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM categories");
  }
  //****************************************************** itemmaster queries */

  Future insertitemmaster(
    String mastername,
    String barcode,
    String barcodespname,
    String qtytype,
    double pcspertype,
    double cost,
    double roqty,
    double cashprice,
    double creditprice,
    double whprice,
    String flag,
    int itemcode,
    int categoryId,
  ) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM itemmaster WHERE itemcode= '$itemcode'");

    if (copy.isEmpty) {
      var value = {
        "itemcode": itemcode,
        "mastername": mastername,
        "barcode": barcode,
        "barcodespname": barcodespname,
        "qtytype": qtytype,
        "pcspertype": pcspertype,
        "cost": cost,
        "roqty": roqty,
        "creditprice": creditprice,
        "whprice": whprice,
        "flag": flag
      };
      // var result =
      await db.insert(
        'itemmaster',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM itemmaster");
    } else {
      // await db.rawQuery(
      //   "UPDATE itemmaster SET categoryid = ?,categoryname = ?,WHERE categoryid = '$categoryid'",
      //   [
      //     categoryid,
      //     categoryname,
      //   ],
      // );
      // await db.rawQuery(
      //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
      // var data =
      var datas = await db.rawQuery("SELECT * FROM itemmaster");
      log(datas.toString());
    }
  }

  Future<List> getAllitemmaster() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM itemmaster");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearItemmaster() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM itemmaster");
  }

  Future<List> getProductFromitemmasterByBarcode(String barcode) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM itemmaster WHERE barcode= '$barcode'");
    log(barcode.toString(), name: "barcode");
    log(copy.toString(), name: "result");
    return copy;
  }

  updateItemCashPrice(String barcode, double newCashPrice) async {
    var db = await dbInit();
    // String barcode = '1234567890'; // Example barcode
    // double newCashPrice = 99.99; // New cash price

    // int count = await updateCashPrice(db, barcode, newCashPrice);
    await db.update(
      'itemmaster', // Table name
      {'cashprice': newCashPrice}, // Values to update
      where: 'barcode = ?', // WHERE clause
      whereArgs: [barcode], // Arguments for the WHERE clause
    );
    // print('Updated $count record(s)');
  }

//*************************************** saj header queries */
  Future insertsajheader(
    int sajno,
    String sajdate,
    String remarks,
    String enteredby,
    int companycode,
  ) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM sajheader WHERE sajno= '$sajno'");

    if (copy.isEmpty) {
      var value = {
        "sajno": sajno,
        "sajdate": sajdate,
        "enteredby": enteredby,
        "remarks": remarks,
        "companycode": companycode,
      };
      // var result =
      await db.insert(
        'sajheader',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM sajheader");
    } else {
      // await db.rawQuery(
      //   "UPDATE sajheader SET categoryid = ?,categoryname = ?,WHERE categoryid = '$categoryid'",
      //   [
      //     categoryid,
      //     categoryname,
      //   ],
      // );
      // await db.rawQuery(
      //     "UPDATE product SET sajno= $itemCode, WHERE barcode= '$barcode'");
      // // var data =
      // var datas = await db.rawQuery("SELECT * FROM sajheader");
      // log(datas.toString());
    }
  }

  Future<List> getAllsajheader() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM sajheader");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearsajheader() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM sajheader");
  }

  Future<List> getsajheaderbysajno(int sajno) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM sajheader WHERE sajno= '$sajno'");
    // log(barcode.toString(), name: "barcode");
    log(copy.toString(), name: "result");
    return copy;
  }

//*************************************** saj details queries */
  Future insertsajDetails(
    int sajno,
    String barcode,
    String itemname,
    String qtytype,
    String adjtype,
    int companycode,
    int storecode,
    int qty,
    double cost,
  ) async {
    var db = await dbInit();
    // var copy = await db
    //     .rawQuery("SELECT * FROM sajdetails WHERE sajno= '$sajno'");

    // if (copy.isEmpty) {
    var value = {
      "sajno": sajno,
      "barcode": barcode,
      "itemname": itemname,
      "qtytype": qtytype,
      "storecode": storecode,
      "qty": qty,
      "adjtype": adjtype,
      "cost": cost,
      "companycode": companycode,
    };
    // var result =
    await db.insert(
      'sajdetails',
      value,
    );
    // var data =
    await db.rawQuery("SELECT * FROM sajdetails");
    // } else {
    // await db.rawQuery(
    //   "UPDATE sajheader SET categoryid = ?,categoryname = ?,WHERE categoryid = '$categoryid'",
    //   [
    //     categoryid,
    //     categoryname,
    //   ],
    // );
    // await db.rawQuery(
    //     "UPDATE product SET sajno= $itemCode, WHERE barcode= '$barcode'");
    // // var data =
    // var datas = await db.rawQuery("SELECT * FROM sajheader");
    // log(datas.toString());
    // }
  }

  Future<List> getAllsajDetails() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM sajdetails");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearsajDetails() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM sajdetails");
  }

  Future<List> getsajDetailsbysajno(int sajno) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM sajdetails WHERE sajno= '$sajno'");
    // log(barcode.toString(), name: "barcode");
    log(copy.toString(), name: "result");
    return copy;
  }

//*************************************** barcode print queries */
  Future insertprintbarcode(String barcode, String itemname, String rate,
      int printcount, String datetime) async {
    var db = await dbInit();

    var value = {
      "barcode": barcode,
      "itemname": itemname,
      "rate": rate,
      "printcount": printcount,
      "printdatetime": datetime
    };

    await db.insert(
      'barcodeprint',
      value,
    );

    List data = await db.rawQuery("SELECT * FROM barcodeprint");
    log(data.toString());
  }

  Future<List> getAllbarcodePrint() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM barcodeprint");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearAllBarcodePrint() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM barcodeprint");
  }

//*************************************** storedata queries */
  Future insertstoredata(
    String ip,
    String termin,
    bool serverRemote,
  ) async {
    var db = await dbInit();

    var value = {
      "ip": ip,
      "terminal": termin,
      "server": serverRemote ? 0 : 1,
    };

    await db.insert(
      'storedata',
      value,
    );

    List data = await db.rawQuery("SELECT * FROM storedata");
    log(data.toString());
  }

  Future<List> getAllstoredata() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM storedata");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearAllstoredata() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM storedata");
  }
  // ****************************************** po header table queries ********************

  Future insertPoHeader(int pono, String podate, int vendorid, String enteredby,
      String remark) async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM poheader WHERE pono= '$pono'");

    if (copy.isEmpty) {
      var value = {
        'pono': pono,
        'podate': podate,
        'vendorid': vendorid,
        "enteredby": enteredby,
        "remark": remark
      };
      // var result =
      await db.insert(
        'poheader',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM poheader");
    } else {
      await db.rawQuery(
        "UPDATE poheader SET pono = ?,podate = ?,vendorid = ?,enteredby = ?,remark = ? WHERE pono = '$pono'",
        [pono, podate, vendorid, enteredby, remark],
      );

      var datas = await db.rawQuery("SELECT * FROM poheader");
      log(datas.toString());
    }
  }

  Future<List> getAllpoheader() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM poheader");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearpo() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM poheader");
  }

  Future getPoheaderBypono(int pono) async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM poheader WHERE pono= '$pono'");
    return copy;
  }

  removepoheader(int pono) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'poheader',
      where: 'pono = ?',
      whereArgs: [pono],
    );
  }

  //****************************************************** po details queries */

  Future insertpoDetails(
      String barcode, int pono, int qty, double foc, double cost) async {
    var db = await dbInit();
    // var copy = await db.rawQuery(
    // "SELECT * FROM podetails WHERE pono = ? AND barcode = ?",
    // [pono, barcode]);
    // await db.rawQuery("SELECT * FROM grndetails WHERE grnno= '$grnno'");

    // if (copy.isEmpty) {
    var value = {
      'pono': pono,
      'barcode': barcode,
      'qty': qty,
      'foc': foc,
      "cost": cost
    };
    // var result =
    await db.insert(
      'podetails',
      value,
    );
    // var data =
    await db.rawQuery("SELECT * FROM podetails");
    // } else {
    // await db.rawQuery(
    // "UPDATE grndetails SET grnno = ?,barcode = ?,qty = ?,foc = ?,cost = ? WHERE grnno = '$grnno'",
    // [grnno, barcode, qty, foc, cost],
    // );
    // await db.rawQuery(
    //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
    // var data =
    //   var datas = await db.rawQuery("SELECT * FROM grndetails");
    //   log(datas.toString());
    // }
  }

  Future<List> getAllPoDetails() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM podetails");
    // log(copy.toString(), name: "result");
    log(copy.toString(), name: "result");

    return copy;
  }

  removePoDetails(int pono) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'podetails',
      where: 'pono = ?',
      whereArgs: [pono],
    );
  }

  Future clearPoDetails() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM podetails");
  }

  Future getPoDetailsByGrnNo(int pono) async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM podetails WHERE pono= '$pono'");
    return copy;
  }

// ****************************************** invoiceheader table queries ********************

  Future insertInvoiceHeader(
      int invoiceno,
      String invoicedate,
      int customerid,
      String invoicetype,
      int lpono,
      int storecode,
      double invoiceamount,
      double taxamount,
      double discount,
      double paidamount,
      String duedate,
      String ivtime,
      double cashtendered,
      String status,
      String reason,
      String crlogin,
      String crdate,
      double totaldiscount,
      String specificname,
      String trn,
      String salesource,
      int companycode,
      String salesman,
      String ivseries) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM invoiceheader WHERE invoiceno= '$invoiceno'");

    if (copy.isEmpty) {
      var value = {
        'invoiceno': invoiceno,
        'invoicedate': invoicedate,
        'customerid': customerid,
        "invoicetype": invoicetype,
        "lpono": lpono,
        'storecode': storecode,
        'invoiceamount': invoiceamount,
        'taxamount': taxamount,
        "discount": discount,
        "paidamount": paidamount,
        "duedate": duedate,
        'ivtime': ivtime,
        'cashtendered': cashtendered,
        'status': status,
        "reason": reason,
        "crlogin": crlogin,
        "crdate": crdate,
        'totaldiscount': totaldiscount,
        'specificname': specificname,
        'trn': trn,
        "salesource": salesource,
        "companycode": companycode,
        "salesman": salesman,
        "ivseries": ivseries
      };
      // var result =
      await db.insert(
        'invoiceheader',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM invoiceheader");
    } else {
      await db.rawQuery(
        "UPDATE invoiceheader SET invoiceno = ?,invoicedate = ?,customerid = ?,invoicetype = ?,lpono = ?,storecode = ?,invoiceamount = ?,taxamount = ?,discount = ?,paidamount = ?,"
        "duedate = ?,ivtime = ?,cashtendered = ?,status = ?,reason = ?,crlogin = ?,crdate = ?,totaldiscount = ?,specificname = ?,trn = ?,"
        " salesource = ?,companycode = ?,salesman = ?,ivseries = ?,lpono = ?,storecode = ?,WHERE invoiceno = '$invoiceno'",
        [
          invoiceno,
          invoicedate,
          customerid,
          invoicetype,
          lpono,
          storecode,
          invoiceamount,
          taxamount,
          discount,
          paidamount,
          duedate,
          ivtime,
          cashtendered,
          status,
          reason,
          crlogin,
          crdate,
          specificname,
          trn,
          salesource,
          companycode,
          salesman,
          ivseries,
          lpono,
          storecode
        ],
      );

      var datas = await db.rawQuery("SELECT * FROM invoiceheader");
      log(datas.toString());
    }
  }

  Future<List> getAllinvoiceheader() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM invoiceheader");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearinvoice() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM invoiceheader");
  }

  Future getInvoiceheaderByinvoiceno(int invoiceno) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM invoiceheader WHERE invoiceno= '$invoiceno'");
    return copy;
  }

  removeinvoiceheader(int invoiceno) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'invoiceheader',
      where: 'invoiceno = ?',
      whereArgs: [invoiceno],
    );
  }
//****************************************************** invoice details queries */

  Future insertinvoiceDetails(
      int invoiceno,
      String barcode,
      String itemname,
      String qtytype,
      int qty,
      double foc,
      double rate,
      double cost,
      double discper,
      double discount,
      double tbt,
      double taxper,
      double tax,
      String batch,
      String expiry,
      String serial,
      String status,
      String returnflag,
      String crlogin,
      String crdate,
      String salesource,
      int companycode,
      String ivid,
      String ivseries) async {
    var db = await dbInit();
    var value = {
      'invoiceno': invoiceno,
      'barcode': barcode,
      'itemname': itemname,
      'qtytype': qtytype,
      "qty": qty,
      'foc': foc,
      'rate': rate,
      'cost': cost,
      'discper': discper,
      'discount': discount,
      'tbt': tbt,
      'taxper': taxper,
      'tax': tax,
      'batch': batch,
      'expiry': expiry,
      'serial': serial,
      'status': status,
      'returnflag': returnflag,
      'crlogin': crlogin,
      'crdate': crdate,
      'salesource': salesource,
      'companycode': companycode,
      'ivid': ivid,
      'ivseries': ivseries,
    };
    // var result =
    await db.insert(
      'invoicedetails',
      value,
    );
    // var data =
    await db.rawQuery("SELECT * FROM invoicedetails");
  }

  Future<List> getAllInvoiceDetails() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM invoicedetails");
    // log(copy.toString(), name: "result");
    log(copy.toString(), name: "result");

    return copy;
  }

  removeInvoiceDetails(int invoiceno) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'invoicedetails',
      where: 'invoiceno = ?',
      whereArgs: [invoiceno],
    );
  }

  Future clearInvoiceDetails() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM invoicedetails");
  }

  Future getInvoiceDetailsByInvoiceNo(int invoiceno) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM invoicedetails WHERE invoiceno= '$invoiceno'");
    return copy;
  }
//********************************mobilervpdt ******************************//

  Future insertmobilervpdt(
      int rvno,
      String rvdate,
      int customerid,
      double amount,
      String paytype,
      String sourcetype,
      String description,
      String bankname,
      String chequedate,
      int chequeno,
      String source,
      String salesman,
      int adjusted,
      String refno,
      int companycode,
      String status,
      int mobrvid) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM insertmobilervpdt WHERE rvno= '$rvno'");

    if (copy.isEmpty) {
      var value = {
        'rvno': rvno,
        'rvdate': rvdate,
        'customerid': customerid,
        "amount": amount,
        "paytype": paytype,
        'sourcetype': sourcetype,
        'description': description,
        'bankname': bankname,
        "chequedate": chequedate,
        "chequeno": chequeno,
        'source': source,
        'salesman': salesman,
        'adjusted': adjusted,
        "refno": refno,
        'companycode': companycode,
        'status': status,
        "mobrvid": mobrvid,
      };
      // var result =
      await db.insert(
        'mobilervpdt',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM mobilervpdt");
    } else {
      await db.rawQuery(
        "UPDATE mobilervpdt SET rvno = ?,rvdate = ?,customerid = ?,amount = ?,paytype = ?,"
        "sourcetype = ?,description = ?,bankname = ?,chequedate = ?,chequeno = ?,source = ?,salesman = ?,adjusted = ?,refno = ?,companycode = ? ,status=?,mobrvid=? WHERE rvno = '$rvno'",
        [
          rvno,
          rvdate,
          customerid,
          amount,
          paytype,
          sourcetype,
          description,
          bankname,
          chequedate,
          chequeno,
          source,
          salesman,
          adjusted,
          refno,
          companycode,
          status,
          mobrvid
        ],
      );

      var datas = await db.rawQuery("SELECT * FROM mobilervpdt");
      log(datas.toString());
    }
  }

  Future<List> getAllmobilervheader() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM mobilervpdt");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearmobilerv() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM mobilervpdt");
  }

  Future getMobileheaderByrvno(int rvno) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM mobilervpdt WHERE rvno= '$rvno'");
    return copy;
  }

  removemobilervheader(int rvno) async {
    // Get a reference to the database
    final Database db =
        await dbInit(); // Assume you have a method to get the database instance

    // Delete the rows where grnno matches
    return await db.delete(
      'mobilervpdt',
      where: 'rvno = ?',
      whereArgs: [rvno],
    );
  }

  //**************************************** storstoremaster  table queries */
  Future insertstoremaster(
    int storecode,
    String storename,
    String storelocation,
  ) async {
    var db = await dbInit();
    var copy = await db
        .rawQuery("SELECT * FROM storemaster WHERE storecode= '$storecode'");

    if (copy.isEmpty) {
      var value = {
        'storecode': storecode,
        'storename': storename,
        'storelocation': storelocation,
      };
      // var result =
      await db.insert(
        'storemaster',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM storemaster");
    } else {
      await db.rawQuery(
        "UPDATE storemaster SET storecode = ?,storename = ?,storelocation =? WHERE vendorid = '$storecode'",
        [
          storecode,
          storename,
          storelocation,
        ],
      );
      // await db.rawQuery(
      //     "UPDATE product SET itemcode= $itemCode, WHERE barcode= '$barcode'");
      // var data =
      var datas = await db.rawQuery("SELECT * FROM storemaster");
      log(datas.toString());
    }
  }

  Future<List> getAllstoremaster() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM storemaster");
    log(copy.toString(), name: "storemaster");
    log(copy.length.toString(), name: "storemaster");
    return copy;
  }

  Future clearstoremaster() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM storemaster");
  }

//*********************sajlive********************///

  Future insertsajlive(
      int sajno,
      String barcode,
      String itemname,
      String qtytype,
      String adjtype,
      int companycode,
      int storecode,
      int qty,
      String replaceqty,
      double cost,
      double currentstock,
      double addonqty) async {
    var db = await dbInit();

    var value = {
      "sajno": sajno,
      "barcode": barcode,
      "itemname": itemname,
      "qtytype": qtytype,
      "adjtype": adjtype,
      "companycode": companycode,
      "storecode": storecode,
      "qty": qty,
      "replaceqty": replaceqty,
      "cost": cost,
      "currentstock": currentstock,
      "addonqty": addonqty,
    };

    await db.insert(
      'sajdetailslive',
      value,
    );

    List data = await db.rawQuery("SELECT * FROM sajdetailslive");
    log(data.toString());
  }

  Future<List> getAllsajdetailslive() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM sajdetailslive");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearAllsajdetailslive() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM sajdetailslive");
  }

  //*************************************** saj headerlive queries */
  Future insertsajheaderlive(
    int sajno,
    String sajdate,
    String remarks,
    String enteredby,
    int companycode,
  ) async {
    var db = await dbInit();
    var copy =
        await db.rawQuery("SELECT * FROM sajheaderlive WHERE sajno= '$sajno'");

    if (copy.isEmpty) {
      var value = {
        "sajno": sajno,
        "sajdate": sajdate,
        "enteredby": enteredby,
        "remarks": remarks,
        "companycode": companycode,
      };
      // var result =
      await db.insert(
        'sajheader',
        value,
      );
      // var data =
      await db.rawQuery("SELECT * FROM sajheaderlive");
    } else {
      // await db.rawQuery(
      //   "UPDATE sajheader SET categoryid = ?,categoryname = ?,WHERE categoryid = '$categoryid'",
      //   [
      //     categoryid,
      //     categoryname,
      //   ],
      // );
      // await db.rawQuery(
      //     "UPDATE product SET sajno= $itemCode, WHERE barcode= '$barcode'");
      // // var data =
      // var datas = await db.rawQuery("SELECT * FROM sajheader");
      // log(datas.toString());
    }
  }

  Future<List> getAllsajheaderlive() async {
    var db = await dbInit();
    var copy = await db.rawQuery("SELECT * FROM sajheaderlive");
    log(copy.toString(), name: "result");
    return copy;
  }

  Future clearsajheaderlive() async {
    var db = await dbInit();
    await db.rawQuery("DELETE FROM sajheaderlive");
  }
}
