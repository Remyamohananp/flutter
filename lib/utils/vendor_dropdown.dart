import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class VendorDropdown extends StatelessWidget {
  List<Map> counters;
  final SingleSelectController<Map?> ctrl;
  // VendorModel? counter;

  final Function(Map?) onValueChanged;
  VendorDropdown(
      {super.key,
      required this.counters,
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
      hintText: 'Select Vendor',
      items: counters,
      // initialItem: counter,
      futureRequest: (p0) async {
        List<Map> searchedMembers = [];
        for (var i = 0; i < counters.length; i++) {
          Map current = counters[i];
          if (current["vendorname"].toLowerCase().contains(p0)) {
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
        selectedItem["vendorname"],
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
      ),
      listItemBuilder: (context, item, isSelected, onItemSelect) => Text(
        item["vendorname"],
        style: const TextStyle(fontSize: 15),
      ),
      onChanged: (v) {
        onValueChanged(v);
      },
    );

    // DropdownButton<AdminAllBranchModel?>(
    //   value: filteredBranches.first,
    //   // value: widget.branch,

    //   isExpanded: true,
    //   borderRadius: BorderRadius.circular(10),

    //   items: filteredBranches.map((AdminAllBranchModel val) {
    //     return DropdownMenuItem(
    //       enabled: true,
    //       value: val,
    //       child: Text(val.shopName,
    //           style: const TextStyle(color: Colors.black, fontSize: 12)),
    //     );
    //   }).toList(),
    //   onChanged: (v) {
    //     widget.onValueChanged(v);
    //   },

    // add extra sugar..
    //   icon: const Icon(Icons.arrow_drop_down),
    //   iconSize: 20,
    // ),
    // );
  }
}
