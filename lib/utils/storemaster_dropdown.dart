import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class storemasterdropdown extends StatelessWidget {
  List<Map> storemaster;
  final SingleSelectController<Map?> ctrl;
  // VendorModel? counter;

  final Function(Map?) onValueChanged;
  storemasterdropdown(
      {super.key,
      required this.storemaster,
      // required this.counter,
      required this.onValueChanged,
      required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Map>.searchRequest(
      controller: ctrl,
      closedHeaderPadding: EdgeInsets.all(13),
      decoration: CustomDropdownDecoration(
        closedBorderRadius: BorderRadius.circular(10),
        closedBorder: Border.all(color: Colors.black.withOpacity(.5)),
        expandedBorder: Border.all(color: Colors.black.withOpacity(.5)),
      ),
      hintText: 'Select StoreCode',
      items: storemaster ,
      // initialItem: counter,
      futureRequest: (p0) async {
        List<Map> searchedMembers = [];
        for (var i = 0; i < storemaster .length; i++) {
          Map current = storemaster [i];
          if (current["storename"].toLowerCase().contains(p0)) {
            searchedMembers.add(current);
          }
        }
        return searchedMembers;
      },
      hintBuilder: (context, hint, b) => Text(
        hint,
        style: const TextStyle(fontSize: 15),
      ),
      headerBuilder: (context, selectedItem, b) => Text(
        selectedItem["storename"],
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
      ),
      listItemBuilder: (context, item, isSelected, onItemSelect) => Text(
        item["storename"],
        style: const TextStyle(fontSize: 15),
      ),
      onChanged: (v) {
        onValueChanged(v);
      },
    );


  }
}
