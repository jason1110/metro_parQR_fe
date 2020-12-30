import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'mainScreen.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String qrCode;

  Future<void> scanQRCode() async {
  try {
    final barcodeScanSettings = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", 
      "Go Back", 
      true, 
      ScanMode.QR);
      setState(() {
      if(!mounted) return;
        this.qrCode = qrCode;
      });
  } on PlatformException {
    qrCode = 'Failed to get platform version.';
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Icon(
          Icons.camera_alt,
          size: 50.0,
        ),
        onPressed: () => scanQRCode(),
        ),
    );
  }
}