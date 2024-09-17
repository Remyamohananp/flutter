// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:qr_scanner/main.dart';

// itemsListBottomSheet(
//   List items,
//   BuildContext context,
//   Size size,
//   TextEditingController barcodeCtrl,
//   TextEditingController itemnameCtrl,
//   TextEditingController qtytypeCtrl,
//   TextEditingController pcsCtrl,
//   TextEditingController priceCtrl,
// ) {
//   ValueNotifier<List> searchedItems = ValueNotifier([]);
//   String keyword = "";
//   //************************************************************** */
//   showModalBottomSheet(
//       isDismissible: true,
//       isScrollControlled: true,
//       context: context,
//       builder: (context) => ItemsListView(
//             items: items,
//             barcodeCtrl: barcodeCtrl,
//             itemnameCtrl: itemnameCtrl,
//             pcsCtrl: pcsCtrl,
//             priceCtrl: priceCtrl,
//             qtytypeCtrl: qtytypeCtrl,
//           ));

//   //********************************** */
// }

// class ItemsListView extends StatelessWidget {
//   final List items;
//   final TextEditingController barcodeCtrl;
//   final TextEditingController itemnameCtrl;
//   final TextEditingController qtytypeCtrl;
//   final TextEditingController pcsCtrl;
//   final TextEditingController priceCtrl;
//   ItemsListView(
//       {super.key,
//       required this.items,
//       required this.barcodeCtrl,
//       required this.itemnameCtrl,
//       required this.qtytypeCtrl,
//       required this.pcsCtrl,
//       required this.priceCtrl});
//   ValueNotifier<List> searchedItems = ValueNotifier([]);
//   String keyword = "";
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.sizeOf(context);
//     return Container(
//       height: size.height * 0.9,
//       width: size.width,
//       padding:
//           EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 10),
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(5), topRight: Radius.circular(5))),
//       child: SingleChildScrollView(
//         controller: ScrollController(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             const SizedBox(height: 5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         backgroundColor: Colors.red.shade900),
//                     onPressed: () => navigatorKey.currentState?.pop(),
//                     child: Text(
//                       "Close",
//                       style: TextStyle(color: Colors.white),
//                     )),
//               ],
//             ),
//             const SizedBox(height: 5),
//             TextField(
//               onChanged: (value) {
//                 keyword = value;
//                 debugPrint(value);
//                 searchedItems.value = items
//                     .where((element) => element["barcodespname"]
//                         .toString()
//                         .toLowerCase()
//                         .contains(value.toLowerCase()))
//                     .toList();

//                 // log(searchedPonumbers.value.toString());
//               },
//               style: const TextStyle(fontSize: 12),
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
//                 isDense: true,
//                 labelStyle: const TextStyle(fontSize: 11, color: Colors.black),
//                 // isCollapsed: true,
//                 errorBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.red),
//                     borderRadius: BorderRadius.circular(10)),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
//                     borderRadius: BorderRadius.circular(10)),
//                 focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
//                     borderRadius: BorderRadius.circular(10)),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const Divider(
//               color: Colors.black38,
//             ),
//             const SizedBox(height: 10),
//             ValueListenableBuilder(
//                 valueListenable: searchedItems,
//                 builder: (context, value, child) {
//                   return keyword != "" && value.isEmpty
//                       ? const Center(
//                           child: Text("No items found"),
//                         )
//                       : ListView.separated(
//                           controller: ScrollController(),
//                           separatorBuilder: (context, index) =>
//                               const Divider(color: Colors.black38),
//                           shrinkWrap: true,
//                           itemCount:
//                               value.isNotEmpty ? value.length : items.length,
//                           itemBuilder: (context, index) {
//                             Map current =
//                                 value.isNotEmpty ? value[index] : items[index];
//                             // change date format

//                             // get vendorname
//                             // Map? vendor = getVendorDetailsByid(
//                             //     vendors, current["vendorid"]);
//                             // String vendorname = "";
//                             // if (vendor != null) {
//                             //   vendorname = vendor["vendorname"] ?? "";
//                             // }
//                             return ListTile(
//                               visualDensity: const VisualDensity(
//                                   horizontal: 0, vertical: -4),
//                               onTap: () async {
//                                 // onTapselectPonumber(current, vendor);
//                                 barcodeCtrl.text = current["barcode"];
//                                 itemnameCtrl.text = current["barcodespname"];
//                                 qtytypeCtrl.text = current["qtytype"];
//                                 pcsCtrl.text = current["pcspertype"].toString();
//                                 priceCtrl.text =
//                                     current["cashprice"].toString();
//                                 navigatorKey.currentState?.pop();
//                               },
//                               tileColor: index % 2 == 0
//                                   ? Colors.black12
//                                   : Colors.grey.shade100,
//                               title: Text(
//                                 "${current["barcodespname"].toString()}",
//                                 style: const TextStyle(
//                                     color: Colors.black87, fontSize: 13),
//                               ),
//                               subtitle: Text(
//                                 "${current["barcode"].toString()}",
//                                 style: const TextStyle(
//                                     color: Colors.black87, fontSize: 13),
//                               ),
//                             );
//                           });
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/main.dart';

class ItemsListGrn extends SearchDelegate<String> {
  final List items;
  final TextEditingController barcodeCtrl;
  final TextEditingController itemnameCtrl;
  final TextEditingController qtytypeCtrl;
  final TextEditingController pcsCtrl;
  final TextEditingController focCtrl;
  final TextEditingController qtyCtrl;
  final TextEditingController costCtrl;
  ItemsListGrn(
    this.items,
    this.barcodeCtrl,
    this.itemnameCtrl,
    this.qtytypeCtrl,
    this.pcsCtrl,
    this.focCtrl,
      this.qtyCtrl,
      this.costCtrl
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.white,
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),
    );
  }

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        color: Colors.black,
        fontSize: 10.0,
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.close_sharp,color: Colors.red,),

      ),

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
       // query = '';
      },
      icon: const Icon(Icons.arrow_back,color: Colors.white,),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return buildSearchResults(size);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return buildSearchResults(size);
  }

  Widget buildSearchResults(Size size) {
    final queryLower = query.toLowerCase();

    // final searchField = items.where((product) {
    //   final searchField = product!.searchField.toLowerCase();
    //   return searchField.contains(queryLower);
    // }).toList();
    final searchedProducts = items
        .where((element) => element["barcodespname"]
            .toString()
            .toLowerCase()
            .contains(queryLower.toLowerCase()))
        .toList();
    return Container(
        color: Colors.white,
        child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade300,
                ),
            itemCount: searchedProducts.length,
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: size.width * 0.02),
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              var current = searchedProducts[index]!;
              return ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                onTap: () async {
                  // onTapselectPonumber(current, vendor);
                  barcodeCtrl.text = current["barcode"];
                  itemnameCtrl.text = current["barcodespname"];
                  qtytypeCtrl.text = current["qtytype"];
                  pcsCtrl.text = current["pcspertype"].toString();
                  focCtrl.text = (current["foc"]?.toString() ?? "");
                //  focCtrl.text = current["foc"].toString();
                  costCtrl.text = current["cost"].toString();
                  qtyCtrl.text = (current["qty"]?.toString() ?? "");
                 // qtyCtrl.text = current["qty"].toString();
                   navigatorKey.currentState?.pop();
                },
                tileColor:
                    index % 2 == 0 ? Colors.black12 : Colors.grey.shade100,
                title: Text(
                  "${current["barcodespname"].toString()}",
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
                subtitle: Text(
                  "${current["barcode"].toString()}",
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
              );
            }));
  }
}
