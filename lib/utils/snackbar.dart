import 'package:flutter/material.dart';

showSnackbar(String title, BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}
