// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_zxing/flutter_zxing.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_scanner/controller/product_controller.dart';
// import 'package:qr_scanner/main.dart';
// import 'package:qr_scanner/model/product_model.dart';
// import 'package:qr_scanner/repository/api_repository.dart';
// import 'package:qr_scanner/utils/loader_dialog.dart';
// import 'package:qr_scanner/views/home_screen.dart';

// class QrScanner extends StatelessWidget {
//   const QrScanner({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Scan Barcode"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       // body: MobileScanner(
//       //   onDetect: (capture) => checkBarcode(capture),
//       //   overlay: const QRScannerOverlay(overlayColour: colorWhite38),
//       //   controller: MobileScannerController(
//       //     detectionSpeed: DetectionSpeed.noDuplicates,
//       //     facing: CameraFacing.back,
//       //     torchEnabled: true,
//       //   ),
//       // ),
//       body: ReaderWidget(
//           isMultiScan: false,
//           showToggleCamera: false,
//           scanDelaySuccess: const Duration(minutes: 1),
//           onScan: (result) async {
//             String code = checkBarcode(result);

//             if (code.isNotEmpty) {
//               // Fluttertoast.showToast(msg: code);
//               context.read<ProductController>().getProductCode(code,context);
//               navigatorKey.currentState?.pushReplacement(
//                   MaterialPageRoute(builder: (_) => HomeScreen()));
//               context
//                   .read<ProductController>()
//                   .getProductDetails(code, context);
//             }
//           }),
//     );
//   }

//   // checkBarcode(BarcodeCapture capture) {
//   //   final List<Barcode> barcodes = capture.barcodes;
//   //   if (barcodes.isNotEmpty) {
//   //     String? barcode = barcodes[0].rawValue;
//   //     if (barcode == null) {
//   //       Fluttertoast.showToast(msg: "QR code not found");
//   //       return;
//   //     }

//   //     final customer = EncryptData.decrypt(barcode);
//   String checkBarcode(Code capture) {
//     if (!capture.isValid || capture.text == null || capture.text!.isEmpty) {
//       Fluttertoast.showToast(msg: "QR code not found");
//       return "nnnn";
//     } else {
//       Fluttertoast.showToast(msg: capture.text ?? "nooo");
//       return capture.text ?? "";
//     }
//   }
// }
