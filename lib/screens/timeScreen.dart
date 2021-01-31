import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/meterLocation.dart';
import 'package:metro_parqr_fe/screens/mainScreen.dart';

class TimeScreen extends StatefulWidget {

  TimeScreen({this.savedHour, this.savedMin, this.savedSec, this.meterStats});

  final savedHour;
  final savedMin;
  final savedSec;
  final meterStats;

  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {


  bool started = true;
  bool stopped = true;
  bool checkTimer = true;
  int hour = 00;
  int min = 00;
  int sec = 00;
  int timeForTimer;
  String displayTime = ""; 

void updateTime(int savedHour, int savedMin, int savedSec) {
  hour = savedHour;
  min = savedMin;
  sec = savedSec;
}




void startTimer(){
    setState((){
      started = false;
    });
    timeForTimer = ((hour * 60 * 60 ) + (min * 60) + sec);
    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t){
      setState(() {
        if(timeForTimer < 1 || checkTimer == false){
          t.cancel();
          checkTimer = true;
          displayTime = "Expired";
        } 
        else if(timeForTimer < 60) {
          displayTime = timeForTimer <10
          ?'0' + timeForTimer.toString()
          : timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
          } else if(timeForTimer < 3600) {
            int m = timeForTimer ~/ 60;
            int s = timeForTimer - (60 * m);
            displayTime = '${formatTime(m)}:${formatTime(s)}'; 
            timeForTimer = timeForTimer - 1;
          } else {
            int h = timeForTimer ~/3600;
            int t = timeForTimer - (3600 * h);
            int m = t ~/ 60;
            int s = t - (60 * m);
            displayTime = '0' + h.toString() + ':${formatTime(m)}:${formatTime(s)}'; 
            timeForTimer = timeForTimer - 1;
          }
        });
    });
  }

    String formatTime(int timenum) {
      return timenum<10?"0" + timenum.toString():timenum.toString();
    }


    void addTime(int time) {
      min + time;
      setState((){
        min;
      });
    }

    @override
    void initState() {
      super.initState();
      updateTime(widget.savedHour, widget.savedMin, widget.savedSec);
      startTimer();
    }


Future<void> _showMyDialog() async {
  timeForTimer = 10800;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Max Stay Reached'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You cannot stay longer than the maximum amount'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241,253,246,1),
      appBar: AppBar(
        title: Text("Go"),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MeterLocation(),
            Text(
              displayTime,
              style: TextStyle(
                color: Colors.black,
                fontSize: 90.0,
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                onPressed: () {
                  timeForTimer >= 9000
                  ? _showMyDialog()
                  : timeForTimer += (30 * 60);
                  print(timeForTimer);
                },
                child: Text('Add 30 Minutes',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                color: Color.fromRGBO(62,176,0,1),
                highlightColor: Colors.lightGreen[50],
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Text('Leave',
                    style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                color: Color.fromRGBO(62,176,0,1),
                highlightColor: Colors.lightGreen[50],
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}


