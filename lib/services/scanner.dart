// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// Future<void> scanQRCode() async {
//   try {
//     final barcodeScanSettings = await FlutterBarcodeScanner.scanBarcode(
//       "#ff6666", 
//       "Go Back", 
//       true, 
//       ScanMode.QR);
//       setState(() {
//       if(!mounted) return;
//         this.qrCode = qrCode;
//       });
//   } on PlatformException {
//     qrCode = 'Failed to get platform version.';
//   }
// }