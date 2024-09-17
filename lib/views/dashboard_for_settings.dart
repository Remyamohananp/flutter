import 'package:flutter/material.dart';
import 'package:qr_scanner/views/sales_settings_form.dart';
import 'package:qr_scanner/views/settings.dart';
import '../db services/db_services.dart';
import '../utils/snackbar.dart';

class DashboardForSettings extends StatelessWidget {

  final passcontroller = TextEditingController();
  final bool passwordInvisible;
  DashboardForSettings({super.key, this.passwordInvisible = true, required DB database});
  final DB database = DB();

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
            " Settings",
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
               
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Type password "),
                    content: TextField(
                      autofocus: true,
                      decoration: InputDecoration(),
                      controller: passcontroller,
                      obscureText: passwordInvisible,
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            String Password = "@@@999**";
                            if (passcontroller.text == Password) {
                              print(passcontroller.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settings(
                                            database: database,
                                          )));
                            } else {
                              showSnackbar("Type Password Correctly", context);
                            }
                          },
                          child: Text('submit')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'))
                    ],
                  ),
                );
               
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
                        "IP Settings",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
              InkWell(
              onTap: () {
                                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Type password "),
                    content: TextField(
                      autofocus: true,
                      decoration: InputDecoration(),
                      controller: passcontroller,
                      obscureText: passwordInvisible,
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            String Password = "@@@999**";
                            if (passcontroller.text == Password) {
                              print(passcontroller.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SalesSettings(
                                            database: database,
                                          )));
                            } else {
                              showSnackbar("Type Password Correctly", context);
                            }
                          },
                          child: Text('submit')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'))
                    ],
                  ),
                );
               
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
                        "Sales Settings",
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
