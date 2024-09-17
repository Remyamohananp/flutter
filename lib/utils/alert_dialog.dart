//******************************************* */
import 'package:flutter/material.dart';

void showAlertDialog(
  BuildContext context2,
) {
  showDialog(
    context: context2,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              color: Colors.orange.shade600,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              "Are you sure to clear?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white),
                  child: const Text('Yes'),
                  onPressed: () async {},
                ),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white),
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
