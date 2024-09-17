import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/widgets/summary_widget.dart';

import '../utils/responsive.dart';
import 'activity_details_card.dart';
import 'header_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
                   const HeaderWidget(),
            const SizedBox(height: 18),
             ActivityDetailsCard(),
            const SizedBox(height: 18),
            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const SummaryWidget(),
          ],
        ),
      ),
    );
  }
}
