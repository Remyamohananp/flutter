import 'package:flutter/material.dart';
import 'package:qr_scanner/custom%20widgets/textfield.dart';
import 'package:qr_scanner/main.dart';

class ReasonDropdwonWidget extends StatelessWidget {
  // final Function(String?) onValueChanged;
  // String initialVal;
  TextEditingController reasonCtrl;
  ReasonDropdwonWidget(
      {super.key,
      //  required this.onValueChanged,
      required this.reasonCtrl});
  final reason = [
    "Sizing or Fit Issues",
    "Damaged or Defective Item",
    'Wrong Item Was Sent',
    "Incorrect Order",
    'Item Arrived Late',
    'Item is different Than Described',
    'Item is Poor Value',
    'Customer Changed Their Mind',
    'Item expired',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      child: field(
          context: context,
          cntr: reasonCtrl,
          txt: "Reason",
          isRead: true,
          onTap: () {
            showModelSheet(context, size, reason);
          }),
    );

    //    Expanded(
    //     child: ValueListenableBuilder(
    //         valueListenable: selectedFlag,
    //         builder: (context, val, child) {
    //           return Container(
    //             padding: EdgeInsets.symmetric(horizontal: 6),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 border: Border.all(color: Colors.grey)),
    //             child: DropdownButton<String>(
    //               borderRadius: BorderRadius.circular(10),
    //               value: val,
    //               icon: Icon(Icons.arrow_drop_down),
    //               iconSize: 24,
    //               elevation: 16,
    //               style: const TextStyle(
    //                   fontWeight: FontWeight.w500, color: Colors.black),
    //               underline: Container(
    //                 height: 2,
    //                 // color: Colors.transparent,
    //               ),
    //               onChanged: (String? newValue) {
    //                 selectedFlag.value = newValue;
    //                 onValueChanged(newValue);
    //               },
    //               items: flags.map<DropdownMenuItem<String>>((String value) {
    //                 return DropdownMenuItem<String>(
    //                   value: value,
    //                   child: Text(value),
    //                 );
    //               }).toList(),
    //             ),
    //           );
    //         }),
    //   );
    // }
  }

  //***************************************** show */
  showModelSheet(BuildContext context, Size size, List reason) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: size.width,
            child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                itemCount: reason.length,
                itemBuilder: (context, index) {
                  String current = reason[index];
                  return ListTile(
                    onTap: () {
                      reasonCtrl.text = current;
                      navigatorKey.currentState?.pop();
                    },
                    title: Text(
                      current,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  );
                }),
          );
        });
  }
}
