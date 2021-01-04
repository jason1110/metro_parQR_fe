import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'scannerScreen.dart';
import '../models/meter.dart';
import '../services/geolocator.dart';
import '../services/httpRequests.dart';
import 'meterScreen.dart';



class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

String qrCodeResult;

@override
  void initState() {
    super.initState();
    
  }

    Future<void> scanQRCode() async {
      String barcodeScanSettings;
    try {
      barcodeScanSettings = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", 
        "Go Back", 
        true, 
        ScanMode.QR);
        print('barcodeScanSettings: $barcodeScanSettings');
    } on PlatformException {
      barcodeScanSettings = 'Failed to get platform version.';
    }
      if(!mounted) return;
        qrCodeResult = barcodeScanSettings;
        NetworkHelper networkHelper = NetworkHelper(qrCodeResult);
        var meterData = await networkHelper.fetchMeter();  
        Navigator.push(context, MaterialPageRoute(builder: (context) => MeterInfo(qrCodeInfo: meterData)));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title: Text("Park"),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CityMap(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                onPressed: () => scanQRCode(),
                child: Text('Scan ParQR code'),
                color: Colors.lightGreen,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green[800]),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
