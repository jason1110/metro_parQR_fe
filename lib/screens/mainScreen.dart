import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'scannerScreen.dart';
import '../models/meter.dart';
import '../services/geolocator.dart';
import 'meterScreen.dart';



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  
  Future<Meter> futureMeter;

  String qrCodeResult;

Future<Meter> fetchMeter() async {
  final response =
      await http.get('$qrCodeResult');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Meter.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Meter');
  }
}



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
    setState(() {
      qrCodeResult = barcodeScanSettings;
      futureMeter = fetchMeter();
      Navigator.push(context, MaterialPageRoute(builder: (context) => MeterInfo(qrCodeInfo: futureMeter)));
    print('qrCodeResult: $qrCodeResult');
    });
}

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker carMarker;
  Circle circle;
  GoogleMapController _controller;
  
  static final CameraPosition initialLocation = CameraPosition(
  target: LatLng(39.75319, -105.00009),
  zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      carMarker = Marker(
        markerId: MarkerId('home'),
        position: latlng,
        rotation: newLocalData.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData)
      );
      circle = Circle(
        circleId: CircleId('car'),
        radius: newLocalData.accuracy,
        zIndex: 1,
        strokeColor: Colors.lightGreen,
        center: latlng,
        fillColor: Colors.lightGreen.withAlpha(70)
      );
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData){
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(newLocalData.latitude, newLocalData.longitude),
            tilt: 0,
            zoom: 15.00,
            ),
          ));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        debugPrint('Permission Denied');
      }
    }
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
            SizedBox(
              height: 300,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                markers: Set.of((carMarker != null) ? [carMarker] : []),
                circles: Set.of((circle != null) ? [circle] : []),
                onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                },
              ),
            ),
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
            // Text('Scan result $qrCodeResult'),
            // FutureBuilder<Meter>(
            //   future: futureMeter,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Card(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Center(
            //             child: Column(
            //               children: [
            //                 Text("Free Hours: ${snapshot.data.freeTime}"),
            //                 Text("Maximum length of stay: ${snapshot.data.maxStay} hours"),
            //                 Text("Meter ID: ${snapshot.data.id}"),
            //               ],
            //             ),
            //           ),
            //         )
            //         );
            //     } else if (snapshot.hasError) {
            //       return Text("${snapshot.error}");
            //     }

            //     // By default, show a loading spinner.
            //     return CircularProgressIndicator(
            //       backgroundColor: Colors.transparent,
            //     );
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[400],
        child: Icon(Icons.location_searching),
        elevation: 8.0,
        onPressed: () {
          getCurrentLocation();
        },
      ),
    );
  }
}
