// import 'package:flutter/material.dart';
// import 'package:qr_scanner/custom%20widgets/textfield.dart';
// import 'package:qr_scanner/utils/check_server.dart';
// import 'package:qr_scanner/utils/snackbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Settings extends StatefulWidget {
//   Settings({super.key});

//   @override
//   State<Settings> createState() => _SettingsState();
// }

// class _SettingsState extends State<Settings> {
//   ValueNotifier<bool> selectedServer = ValueNotifier(false);

//   TextEditingController ipCtrl = TextEditingController();

//   getIp() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     String? ip = sp.getString(
//       "ip",
//     );
//     ipCtrl.text = ip ?? "";
//   }

//   @override
//   void initState() {
//     getIp();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.sizeOf(context);
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: const Text("Settings"),
//         ),
//         body: FutureBuilder(
//             future: checkServer(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 WidgetsBinding.instance.addPostFrameCallback((v) {
//                   selectedServer.value = snapshot.data;
//                 });
//                 return ValueListenableBuilder(
//                     valueListenable: selectedServer,
//                     builder: (context, val, child) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: size.width * 0.05, vertical: 16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             field(
//                                 context: context,
//                                 cntr: ipCtrl,
//                                 txt: "Ip Address"),
//                             const SizedBox(
//                               height: 22,
//                             ),
//                             const Text(
//                               "Selected Server",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600, fontSize: 19),
//                             ),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                     value: val ? true : false,
//                                     onChanged: (v) {
//                                       // SharedPreferences sp =
//                                       //     await SharedPreferences.getInstance();
//                                       // sp.setBool("server", true);
//                                       selectedServer.value =
//                                           !selectedServer.value;
//                                     }),
//                                 const Text("Remote"),
//                                 const SizedBox(
//                                   width: 22,
//                                 ),
//                                 Checkbox(
//                                     value: !val ? true : false,
//                                     onChanged: (v) {
//                                       // SharedPreferences sp =
//                                       //     await SharedPreferences.getInstance();
//                                       // sp.setBool("server", false);
//                                       selectedServer.value =
//                                           !selectedServer.value;
//                                     }),
//                                 const Text("Local")
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.black,
//                                         foregroundColor: Colors.white,
//                                         fixedSize: Size(size.width * 0.4, 45)),
//                                     onPressed: () async {
//                                       if (val && ipCtrl.text.isEmpty) {
//                                         showSnackbar(
//                                             "Enter ip address", context);
//                                       } else {
//                                         SharedPreferences sp =
//                                             await SharedPreferences
//                                                 .getInstance();
//                                         sp.setBool(
//                                           "server",
//                                           val ? true : false,
//                                         );
//                                         val
//                                             ? sp.setString("ip", ipCtrl.text)
//                                             : null;
//                                         showSnackbar("Server Updated", context);
//                                       }
//                                     },
//                                     child: Text("SAVE")),
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     });
//               } else if (snapshot.hasError) {
//                 return const Center(
//                   child: Text("Something went wrong!"),
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             }));
//   }
// }

import 'package:flutter/material.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom widgets/textfield.dart';
import '../utils/check_server.dart';
import '../utils/snackbar.dart';
import 'home.dart';
import 'home1.dart';

class Settings extends StatefulWidget {
  final DB database;
  Settings({super.key, required this.database});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ValueNotifier<bool> selectedServer = ValueNotifier(false);

  TextEditingController ipCtrl = TextEditingController();
  TextEditingController terminalCtrl = TextEditingController();

  getData() async {
    List data = await widget.database.getAllstoredata();
    if (data.isNotEmpty) {
      return {
        "ip": data.last["ip"] ?? "",
        "terminal": data.last["terminal"] ?? "",
        "server": data.last["server"] ?? 1
      };
    }
    return {"ip": "", "terminal": "", "server": 1};
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Settings"),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                WidgetsBinding.instance.addPostFrameCallback((v) {
                  selectedServer.value =
                      snapshot.data["server"] == 1 ? false : true;
                });
                ipCtrl.text = snapshot.data["ip"] ?? "";
                terminalCtrl.text = snapshot.data["terminal"] ?? "";
                return ValueListenableBuilder(
                    valueListenable: selectedServer,
                    builder: (context, val, child) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            field(
                                context: context,
                                cntr: terminalCtrl,
                                txt: "Terminal"),
                            const SizedBox(
                              height: 22,
                            ),
                            field(
                                context: context,
                                cntr: ipCtrl,
                                txt: "Ip Address"),
                            const SizedBox(
                              height: 22,
                            ),
                            const Text(
                              "Selected Server",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 19),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: val ? true : false,
                                    onChanged: (v) {
                                      // SharedPreferences sp =
                                      //     await SharedPreferences.getInstance();
                                      // sp.setBool("server", true);
                                      selectedServer.value =
                                          !selectedServer.value;
                                    }),
                                const Text("Remote"),
                                const SizedBox(
                                  width: 22,
                                ),
                                Checkbox(
                                    value: !val ? true : false,
                                    onChanged: (v) {
                                      // SharedPreferences sp =
                                      //     await SharedPreferences.getInstance();
                                      // sp.setBool("server", false);
                                      ipCtrl.text = "";
                                      selectedServer.value =
                                          !selectedServer.value;
                                    }),
                                const Text("Local")
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        fixedSize: Size(size.width * 0.4, 45)),
                                    onPressed: () async {
                                      if (ipCtrl.text.isEmpty &&
                                          selectedServer.value == true) {
                                        showSnackbar(
                                            "Enter ip address", context);
                                      } else {
                                        // SharedPreferences sp =
                                        //     await SharedPreferences
                                        //         .getInstance();
                                        // sp.setBool(
                                        //   "server",
                                        //   val ? true : false,
                                        // );
                                        // val
                                        //     ? sp.setString("ip", ipCtrl.text)
                                        //     : null;

                                        // sp.setString("terminal",
                                        //     terminalCtrl.text.trim());
                                        await widget.database
                                            .clearAllstoredata();
                                        await widget.database.insertstoredata(
                                            ipCtrl.text.trim(),
                                            terminalCtrl.text.trim(),
                                            selectedServer.value);
                                        showSnackbar("Server Updated", context);
                                      }
                                      if (ipCtrl.text.isNotEmpty) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home1()));
                                      }

                                      // Navigator.of(context).pop();
                                    },
                                    child: Text("SAVE")),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        fixedSize: Size(size.width * 0.4, 45)),
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home1(
                                              )));
                                      // navigatorKey.currentState?.pop();
                                    }),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong!"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
