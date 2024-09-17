import 'package:flutter/material.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import '../Components/colors.dart';

import '../views/auth.dart';
import '../views/settings.dart';
import '../views/signup.dart';
import '../data/side_menu_data.dart';
import 'dashboard_widget.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;
  DB database = DB();
  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: const Color(0xFF171821),
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => buildMenuEntry(data, index),
      ),
    );
  }

  Widget buildMenuEntry(SideMenuData data, int index) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
        color: isSelected ? selectionColor : Colors.transparent,
      ),
      child: InkWell(
        // onTap: () => setState(() {
        //   selectedIndex = index;
        // }),
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          tapped(selectedIndex, database);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                data.menu[index].icon,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Text(
              data.menu[index].title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  void tapped(int index, DB database) {
    Widget page;

    // You can also use if else here.
    switch (index) {
      case 0:
        page = Settings(
          database: database,
        );
        break;
      case 1:
        page = AuthScreen();
        break;
      case 2:
        page = AuthScreen();
        break;
      case 3:
        page = AuthScreen();
        break;
      default:
        page = AuthScreen(); // default item when no matching category found
    }

    Navigator.push(context as BuildContext,
        MaterialPageRoute(builder: (context) {
      return page;
    }));
  }
}
