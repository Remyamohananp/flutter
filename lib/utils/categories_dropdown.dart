import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class CategoriesDropdown extends StatelessWidget {
  List<Map> categories;
  final SingleSelectController<Map?> ctrl;
  // VendorModel? counter;

  final Function(Map?) onValueChanged;
  CategoriesDropdown(
      {super.key,
      required this.categories,
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
      hintText: 'Select Category',
      items: categories,
      // initialItem: counter,
      futureRequest: (p0) async {
        List<Map> searchedMembers = [];
        for (var i = 0; i < categories.length; i++) {
          Map current = categories[i];
          if (current["categoryname"].toLowerCase().contains(p0)) {
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
        selectedItem["categoryname"],
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
      ),
      listItemBuilder: (context, item, isSelected, onItemSelect) => Text(
        item["categoryname"],
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
