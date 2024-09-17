import 'package:flutter/material.dart';

void changeFocus(BuildContext context, FocusNode focus1, FocusNode focus2) {
  focus1.unfocus();
  FocusScope.of(context).requestFocus(focus2);
}
