import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../custom widgets/textfield.dart';
import '../db services/db_services.dart';

import 'home.dart';
import 'home1.dart';

class SalesSettings extends StatefulWidget {
  final DB database;
  SalesSettings({super.key, required this.database});

  @override
  State<SalesSettings> createState() => _SettingsState();
}

class _SettingsState extends State<SalesSettings> {
  ValueNotifier<bool> selectedServer = ValueNotifier(false);

  // TextEditingController ipCtrl = TextEditingController();
  // TextEditingController terminalCtrl = TextEditingController();

 TextEditingController mobileCtrl = TextEditingController();
  TextEditingController salesmanCtrl = TextEditingController();
  TextEditingController printerCtrl   =TextEditingController();
  TextEditingController storeCtrl=TextEditingController();
  TextEditingController  pricingflagCtrl = TextEditingController();
  TextEditingController invoiceCtrl = TextEditingController();
  TextEditingController  startingnumberCtrl = TextEditingController();
    final TextEditingController trdateCtrl = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  ValueNotifier<bool> showlistButton = ValueNotifier(false);
 // final DateTime trDatePreselected;

  DateTime selectedtrDate = DateTime.now();
  getData() async {
    List data = await widget.database.getAllstoredata();
    if (data.isNotEmpty) {
      return {
        "ip": data.last["ip"] ?? "",
        //"terminal": data.last["terminal"] ?? "",
        "server": data.last["server"] ?? 1
      };
    }
    return {"ip": "", "terminal": "", "server": 1};
  }
  String? _selectedValue;
 final _dropdownItems  = [
    "TAT",
    "TBT"
  
   ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text("Sales Settings"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 12),
            child: FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    WidgetsBinding.instance.addPostFrameCallback((v) {
                      selectedServer.value =
                          snapshot.data["server"] == 1 ? false : true;
                    });
                   
                 //   terminalCtrl.text = snapshot.data["terminal"] ?? "";
                    return ValueListenableBuilder(
                        valueListenable: selectedServer,
                        builder: (context, val, child) {
                          return Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               field(
                                  context: context,
                                  cntr: salesmanCtrl,

                                   txt: "Salesman"),
                              const SizedBox(
                                height: 15,
                              ),
                              field(
                                  context: context,
                                  cntr: mobileCtrl,
                                  txt: "Mobile No",
                                  number: true),
                              const SizedBox(
                                height: 15,
                              ),
                             
                               field(
                                  context: context,
                                  cntr: printerCtrl,
                                  txt: "Printer Name"),
                           const SizedBox(
                                height: 15,
                              ),
                                 field(
                                  context: context,
                                  cntr: storeCtrl,
                                  txt: "Store Name"),
                                    const SizedBox(
                                    height: 15,
                                   ),
                                 Row(
                                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     Expanded(
                                       child: field(
                                        context: context,
                                        cntr: invoiceCtrl,
                                        txt: "Invoice Series"),
                                     ),
                                      SizedBox(width: 10.0), 
                                        Expanded(
                                          child: field(
                                                    context: context,
                                                    cntr: startingnumberCtrl,
                                                    txt: "Starting NO",
                                                     number:true),
                                        ), 
                                   ],
                                 ),
                                 const SizedBox(
                                    height: 15,
                                   ),
                               
                                
                                 Row(
                                   children: [
                                     Expanded(
                                       child: field(
                                        context: context,
                                        cntr: trdateCtrl,
                                        txt: "Set TR Date"),
                                     ),
                          
                                const SizedBox(
                                    width: 10,
                                   ),
                                 
                                                Expanded(
                          child: DropdownButton<String>(
                            isExpanded:true,
                          value: _selectedValue,
                          hint: Text(' Price Flag'),
                          items: _dropdownItems.map((String item) {
                           return DropdownMenuItem<String>(
                            value: item,
                           child: Text(item),
                           );
                          }).toList(),
                                 onChanged: (String? newValue) {
                                           setState(() {
                                            _selectedValue = newValue;
                                                        });  }), ),
                                   ],
                                 ), 
                                 
                                                      // FlagDropdwonWidget(
                              // pricingflagCtrl: pricingflagCtrl,
                              //          ),
                              // field(
                              //     context: context,
                              //     cntr: pricingflagCtrl,
                              //     txt: "Pricing Flag"),
                              const SizedBox(
                                height: 15,
                              ),
                                Row(
                                     mainAxisSize: MainAxisSize.min,
                                  children: [
                                    
                                  ValueListenableBuilder<bool>(
                                   valueListenable: showlistButton,
                              builder: (context, value, child) {
                               return Checkbox(
                               value: value,
                             onChanged: (bool? newValue) {

                               showlistButton.value = newValue ?? false;
                                            
                                  },
                                activeColor: Colors.green,
                                );
                              },
                                                 ),
                                              const Text( "Ask Price Always",style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 19),),
                                            ValueListenableBuilder(
                                                valueListenable: showlistButton,
                                                builder: (context, val, _) {
                          return val
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Icon(Icons.menu),
                                  onPressed: () {
                                  // print("hi");
                                  })
                              : const SizedBox.shrink();
                                                }),
                          
                                  ],
                                ),
                          
                             const SizedBox(
                                height: 10,
                              ),
                             
                             Row(
                                   mainAxisSize: MainAxisSize.min,
                                  children: [
                                      Checkbox(
                                  value: false, 
                                   onChanged: (bool? value) {
                                        
                                             },
                                        ),
                                    SizedBox(width: 2.0),
                                    const Text(
                                    "Enable Stock",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 19), ),
                                         SizedBox(width: 5.0),
                                            Checkbox(
                                            value: false, 
                                         onChanged: (bool? value) {
                                        
                                             },
                                        ),
                                    SizedBox(width: 2.0),
                                    const Text(
                                    "Block Cost Sale",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 19), ),                                                         
                               
                                  ]),
                            const SizedBox(  height: 5, ),
                             Row(
                                   mainAxisSize: MainAxisSize.min,
                                  children: [
                                      Checkbox(
                                  value: false, 
                                   onChanged: (bool? value) {
                                        
                                             },
                                        ),
                                    SizedBox(width: 2.0),
                                    const Text(
                                    "Enable Customer Statements",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 19), ),],),
                                         const SizedBox(  height: 5, ),
                                         
                             Row(
                                   mainAxisSize: MainAxisSize.min,
                                  children: [
                                      Checkbox(
                                  value: false, 
                                   onChanged: (bool? value) {
                                        
                                             },
                                        ),
                                    SizedBox(width: 2.0),
                                    const Text(
                                    "Enable Last Selling Price For Sale",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 19), ),],),
                             const SizedBox(  height: 20, ),
                              Row(                              
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                                                   shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10)),
                                                                 backgroundColor: Colors.green.shade800,
                                                               foregroundColor: Colors.white,
                                      ),
                                        onPressed: () async {
                                          // if (
                                          //     settingsCtrl.text.trim().isEmpty) {
                                          //   showSnackbar(
                                          //       "Select  Settings", context);
                                          //         return;
                                          // } 
                                        
                                          //  if (
                                          //     salesmanCtrl.text.trim().isEmpty) {
                                          //   showSnackbar(
                                          //       "Select  Salesman", context);
                                          //         return;
                                          // } 
                                          //  if (
                                          //     pricingflagCtrl.text.trim().isEmpty) {
                                          //   showSnackbar(
                                          //       "Select  Pricing Flag", context);
                                          //         return;
                                          // } 
                                          
                                          
                                          // else {
                                          //      await widget.database
                                          //       .clearAllstoredata();
                                          //   await widget.database.insertstoredata(
                                          //       settingsCtrl.text.trim(),
                                          //      // terminalCtrl.text.trim(),
                                          //       selectedServer.value);
                                          //   showSnackbar(" Saved Successsfully", context);
                                          //      Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //           builder: (context) => Home()));
                                          // }
                                           Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home1(
                                            )));
                          
                                        //  Navigator.of(context).pop();
                                        },
                                        child: Text("Save")),
                                  ),
                          
                                      SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.red.shade800,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Clear"),
                          onPressed: () {
                            // qtytypeCtrl.text = "";
                            // barcodeCtrl.text = "";
                            // itemcodeCtrl.text = "";
                            // itemnameCtrl.text = "";
                            // pcspertypeCtrl.text = "";
                            // costCtrl.text = "";
                            // categoryCtrl.text = "";
                            // sellingPriceCtrl.text = "";
                            // newsellingPriceCtrl.text = "";
                            // // isPrintBarcode.value = false;
                            // printCountCtrl.text = "";
                            // showSaveButton.value = false;
                            //  focusBarcode.requestFocus();
                          }),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.blue.shade800,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Close"),
                          onPressed: () {
                             Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home1(
                                            )));
                           // navigatorKey.currentState?.pop();
                          }),
                                            ),
                                ],
                              )
                            ],
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
                }),
          ),
        ));
  }
}
