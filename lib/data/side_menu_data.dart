

import 'package:flutter/material.dart';

import '../model/menu_model.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    // MenuModel(icon: Icons.home, title: 'Dashboard'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.add_shopping_cart_outlined, title: 'Stock Adjustment'),
    MenuModel(icon: Icons.sync, title: 'Synchronization'),
     MenuModel(icon: Icons.logout, title: 'SignOut'),
  ];
}
