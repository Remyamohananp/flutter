import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import '../widgets/dashboard_widget.dart';
import '../widgets/side_menu_widget.dart';
import '../widgets/summary_widget.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    final isDesktop=Responsive.isDesktop(context);
  return  Scaffold(
    drawer: !isDesktop
        ? const SizedBox(
      width: 250,
      child: SideMenuWidget(),
    )
        : null,
    endDrawer: Responsive.isMobile(context)
        ? SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: const SummaryWidget(),
    )
        : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              const Expanded(
                flex: 2,
                child: SizedBox(
                  child: SideMenuWidget(),
                ),
              ),
            const Expanded(
              flex: 7,
              child: DashboardWidget(),
            ),
            if (isDesktop)
              const Expanded(
                flex: 2,
                child: SummaryWidget(),
              ),
          ],
        ),
      ),
  );
  }
}
