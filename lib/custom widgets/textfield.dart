import 'dart:developer';

import 'package:flutter/material.dart';

TextFormField field(
    {required BuildContext context,
    required cntr,
    required txt,
    // address = false,
    // required ic,
    // date = false,
    void Function(String)? onchanged,
    void Function()? onTap,
    void Function(String)? onFieldSubmitted,
    void Function()? onEditingCompleted,
    isRead = false,
    FocusNode? focusnode,
    isMultiline = false,
    // isOwner = false,
    // isKm = false,
    // amount = false,
    number = false}) {
  return TextFormField(
    onEditingComplete: () {
      if (onEditingCompleted != null) {
        log("on editing completed");
        onEditingCompleted();
      }
    },
    focusNode: focusnode,
    readOnly: isRead,
    onTap: onTap,
    minLines: isMultiline ? 4 : null,
    controller: cntr,
    validator: (value) {
      if (value!.isEmpty) {
        return "*required";
      } else {
        return null;
      }
    },
    onChanged: (value) {
      log("message");
      if (onchanged != null) {
        onchanged(value);
      }
    },
    onFieldSubmitted: (v) {
      if (onFieldSubmitted != null) {
        onFieldSubmitted(v);
      }
    },
    keyboardType: number
        ? TextInputType.number
        : isMultiline
            ? TextInputType.multiline
            : TextInputType.text,
    maxLines: isMultiline ? null : 1,
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    onTapOutside: (event) {
      FocusScope.of(context).unfocus();
    },
    decoration: InputDecoration(
      counterText: "",
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      labelText: txt,
      errorStyle: const TextStyle(
        color: Colors.grey,
      ),
      labelStyle: const TextStyle(fontSize: 13, color: Colors.black),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
          borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
          borderRadius: BorderRadius.circular(10)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
