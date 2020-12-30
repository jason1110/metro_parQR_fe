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




// class MeterScreen extends StatelessWidget {
    
// // final Meter meter;

// // MeterScreen({Key key, @required this.meter}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MeterInfo();
//   }
// }

class MeterInfo extends StatefulWidget {

  MeterInfo({this.qrCodeInfo});

  final qrCodeInfo;

  @override
  _MeterInfoState createState() => _MeterInfoState();
}

class _MeterInfoState extends State<MeterInfo> {


updateUI (dynamic qrCodeInfo ) {
  qrCodeInfo;
 print(widget.qrCodeInfo);
}

//   Future<Meter> fetchMeter() async {
//   final response =
//       await http.get('$qrCodeInfo');
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Meter.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Meter');
//   }
// }


Future<Meter> futureMeter;

@override
  void initState() {
    super.initState();
    futureMeter = widget.qrCodeInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: 
      Center
      (child: Column(
        children: [
          Text('Scan result'),
            FutureBuilder<Meter>(
            future: futureMeter,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text("Free Hours: ${snapshot.data.freeTime}"),
                          Text("Maximum length of stay: ${snapshot.data.maxStay} hours"),
                          Text("Meter ID: ${snapshot.data.id}"),
                        ],
                      ),
                    ),
                  )
                  );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              );
            },
          ),
        ],
      ),
    ),
    );
  }
}