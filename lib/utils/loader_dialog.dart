import 'package:flutter/material.dart';

transparantDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Container(
          color: Colors.black.withOpacity(0.5),
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: Colors.white,
          )
          //   LinearProgressIndicator(
          //   backgroundColor: colorPrimary,
          //   minHeight: 2,
          // ),
          );
    },
  );
}
