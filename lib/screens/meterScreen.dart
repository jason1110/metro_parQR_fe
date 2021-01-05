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
import '../services/timer.dart';
import 'timeScreen.dart';
import 'package:numberpicker/numberpicker.dart';

class MeterInfo extends StatefulWidget {

  MeterInfo({this.qrCodeInfo});

  
  final qrCodeInfo;

  @override
  _MeterInfoState createState() => _MeterInfoState();
}

class _MeterInfoState extends State<MeterInfo> {



// Future<Meter> futureMeter;
int seconds;

int id;
String type;
String maxStay;
int cost;
bool inUse;
String latlng;
String freeTime;

  bool started = true;
  bool stopped = true;
  bool checkTimer = true;
  int hour = 0;
  int minute = 0;
  int second = 0;
  int timeForTimer = 0;
  String displayTime = "";


  // saveTime(){
  //   return displayTime = '0${hour} : ${min} : ${sec}';
  // }

 String constructTime(int seconds) {
  return formattime(hour) + ":" + formattime(minute) + ":" + formattime(second);
 }

 String formattime(int timenum) {
  return timenum<10?"0" + timenum.toString():timenum.toString();
 }

    Widget timer(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(
                      bottom: 10.0,
                      ),
                      child: Text('HH'),
                    ),
                    NumberPicker.integer(initialValue: hour,
                    minValue: 0,
                    maxValue: 2,
                    listViewWidth: 60.0,
                    onChanged: (val){
                        setState((){
                          hour = val;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(
                      bottom: 10.0,
                      ),
                      child: Text('MM'),
                    ),
                    NumberPicker.integer(initialValue: minute,
                    minValue: 0,
                    maxValue: 59,
                    step: 1,
                    listViewWidth: 60.0,
                    onChanged: (val){
                        setState((){
                          minute = val;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(
                      bottom: 10.0,
                      ),
                      child: Text('SS'),
                    ),
                    NumberPicker.integer(initialValue: second,
                    minValue: 00,
                    maxValue: 59,
                    listViewWidth: 60.0,
                    onChanged: (val){
                        setState((){
                          second = val;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(displayTime),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    constructTime(seconds);
                    Navigator.pop(context); 
                    setState((){
                      displayTime = constructTime(seconds);
                    });
                    },
                  padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0
                  ),
                  child: Text(
                    'Set Timer',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                    )
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

@override
  void initState() {
    super.initState();
    updateUI(widget.qrCodeInfo);
  }

void updateUI(dynamic meterData) {
  id = meterData['id'];
  cost = meterData['cost'];
  freeTime = meterData['freeTime'];
  maxStay = meterData['maxStay'];
}


void _setTimerModal (context) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(context).size.height + .60,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                children: <Widget>[
                  Text('Set Timer'),
                  Spacer(),
                  IconButton(
                  icon: Icon(Icons.cancel, color: Colors.green, size: 25,),
                  onPressed: () {
                    Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Container (
                  height: 400,
                  child: Center(
                    child: timer(),
                  )
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  // void incrementTimer() {
  //     int counter + 30;
  // }

  // void decrementTimer() {
  //   int counter - 30;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title: Text('MetroParQR'),
        centerTitle: true,
        ),
        body: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            Text(
              'How long are you Staying?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                )
            ),
            Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text('Meter ID: $id'),
                          Text("Maximum length of stay: ${maxStay} hours"),
                          Text('${freeTime}'),
                          Text('Cost: \$$cost/hr'),
                        ],
                      ),
                    ),
                  )
                  ),
              // // By default, show a loading spinner.
              // return CircularProgressIndicator(
              //   backgroundColor: Colors.transparent,
              // );
            // },
          // ),
          FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              child: Text("Set your timer"),
              color: Colors.green,
              onPressed: () {
                _setTimerModal(context);
              },
          ),
          Text(
            '$displayTime',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
            child: Text('Park'),
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => TimeScreen(savedHour: hour, savedMin: minute, savedSec: second, meterStats: widget.qrCodeInfo )
                  )
                );
              },
            ),
        ],
      ),
    ),
    );
  }
}