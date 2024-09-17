import 'package:flutter/material.dart';
import '../Components/colors.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),

            Text(
              'Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            // SizedBox(height: 16),
            //
            // SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}
