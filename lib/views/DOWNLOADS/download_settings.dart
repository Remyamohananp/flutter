import 'package:flutter/material.dart';
import 'package:qr_scanner/views/sales_settings_form.dart';
import 'package:qr_scanner/views/settings.dart';
import '../../db services/db_services.dart';
import '../../main.dart';
import '../../utils/download_all_data.dart';
import '../../utils/snackbar.dart';


class DownloadForSettings extends StatefulWidget {

  final bool passwordInvisible;
  DownloadForSettings({super.key, this.passwordInvisible = true, required DB database});

  @override
  State<DownloadForSettings> createState() => _DownloadForSettingsState();
}

class _DownloadForSettingsState extends State<DownloadForSettings> {
  bool _isChecked = false;
  final passcontroller = TextEditingController();

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
            "Download Data",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  Flexible(child: Text('Download only PDT/TAB related informations')),
                ],
              ),
            ),
            Expanded(
              child: GridView(
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

                      // showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     title: Text("Type password "),
                      //     content: TextField(
                      //       autofocus: true,
                      //       decoration: InputDecoration(),
                      //       controller: passcontroller,
                      //       obscureText: widget.passwordInvisible,
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
                      //                       builder: (context) => Settings(
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
                                  "assets/images/downloads/downloadbasicsettings.jpeg",
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
                              "Download Basic Settings",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),
                    InkWell(
                    onTap: () {
                      //                 showDialog(
                      //   context: context,
                      //   builder: (context) => AlertDialog(
                      //     title: Text("Type password "),
                      //     content: TextField(
                      //       autofocus: true,
                      //       decoration: InputDecoration(),
                      //       controller: passcontroller,
                      //       obscureText: widget.passwordInvisible,
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
                      //                       builder: (context) => SalesSettings(
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
                                  "assets/images/downloads/downloadcustomers.jpeg",
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
                                "Download Customers",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
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
                                  "assets/images/downloads/download suppliers.png",
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
                              "Download Suppliers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      downloadAllData(context, database);
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
                                  "assets/images/downloads/download item master.png",
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
                              "Download Item Master",
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
                                  "assets/images/downloads/download stores.png",
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
                              "Download Stores",
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
                                  "assets/images/downloads/downloadinvoiceseries.png",
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
                              "Download Invoice Series",
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
                                  "assets/images/downloads/download latest prices.jpeg",
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
                              "Download Latest Prices",
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
                                  "assets/images/downloads/download pending invoices.png",
                                  height:65,
                                  width: 75,
                                  // color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Download Pending Invoices",
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
                                  "assets/images/downloads/downloadcustomerstatement.jpeg",
                                  height: 65,
                                  width: 75,
                                  // color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Download Customer Statement",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),

                ],
              ),
            ),
          ],
        ));
  }
}
