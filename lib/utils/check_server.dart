import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

// server -> true = "remote"
// server -> false = "local"
// Future<bool> checkServer() async {
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   bool isRemote = sp.getBool("server") ?? false;
//   return isRemote;
// }
