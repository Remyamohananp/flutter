import 'package:flutter/material.dart';
import '../Components/colors.dart';

import '../utils/responsive.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});
  final gradient=const LinearGradient(colors: [
    Colors.cyanAccent,
    Colors.redAccent,
    Colors.lightGreenAccent,
  ]);
  final textstyle=const TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.bold,
      shadows:[ BoxShadow(
        color: Colors.white,
        spreadRadius: 5,
        offset: Offset(1,1),
      ),]
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

                Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!Responsive.isDesktop(context))
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.menu,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                ),
              ),
            if (!Responsive.isMobile(context))
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardBackgroundColor,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    hintText: 'Search',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 21,
                    ),
                  ),
                ),
              ),
            if (Responsive.isMobile(context))
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                  InkWell(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        "assets/images/avatar.png",
                        width: 32,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        // const SizedBox(height: 18),
        //
        // const Icon(
        //   Icons.dashboard,
        //   color: Colors.blueGrey,
        //   size: 100.0,
        //
        // ),
      ],
    );
  }
}
