import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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
      backgroundColor: Color.fromRGBO(241,253,246,1),
      appBar: AppBar(
        title: Text("On Your Mark"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(20,17,21,1),
      ),
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CityMap(),
            
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () => scanQRCode(),
                child: Text('Scan ParQR code',
                style: TextStyle(
                  fontSize: 25.0,
                  
                ),),
                color: Color.fromRGBO(62,176,0,1),
                highlightColor: Colors.lightGreen[50],  
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 75.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  // side: BorderSide(color: Colors.green[700]),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
