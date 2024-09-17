import 'package:flutter/material.dart';
import 'package:qr_scanner/views/sales_settings_form.dart';
import 'package:qr_scanner/views/settings.dart';
import '../../db services/db_services.dart';
import '../../main.dart';
import '../../utils/snackbar.dart';
import '../dashboard_for_settings.dart';


class DashboardForSettingss extends StatelessWidget {

  DashboardForSettingss({super.key, this.passwordInvisible = true, required DB database});
  final bool passwordInvisible;
  final DB database = DB();
  final passcontroller = TextEditingController();
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
            " Admin DashBoard",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        body: GridView(
          shrinkWrap: true,
          padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.10, vertical: 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: size.width * 0.03,
              crossAxisSpacing: size.width * 0.03),
          children: [


            InkWell(
              onTap: () {

                // Navigator.push(context,MaterialPageRoute(
                //     builder: (context) => DashboardForSettings(
                //       database: database,)));
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
                            "assets/images/admin/serversettings.jpeg",
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
                        "Server Settings",
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
                            "assets/images/admin/downloadusersandpermissions.png",
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
                        "Download Users and Permissions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
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
                    )
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
                  child: GridTile(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              "assets/images/admin/terminalsettings.jpeg",
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
                            "Terminal Settings",
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
                            "assets/images/admin/change password.jpeg",
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
                        "Change Password",
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
