
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MeterTimer extends StatefulWidget {

  const MeterTimer({Key key}) : super(key: key);

  @override
  _MeterTimerState createState() => _MeterTimerState();

}

class _MeterTimerState extends State<MeterTimer> {
  
  bool started = true;
  bool stopped = true;
  bool checkTimer = true;
  int hour = 00;
  int min = 00;
  int sec = 00;
  int timeForTimer = 0;
  String displayTime = "";

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
          displayTime = "";
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Page()));
        } 
        else if(timeForTimer < 60) {
          displayTime = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
          } else if(timeForTimer < 3600) {
            int m = timeForTimer ~/ 60;
            int s = timeForTimer - (60 * m);
            displayTime = m.toString() + ":" + s.toString();
            timeForTimer = timeForTimer - 1;
          } else {
            int h = timeForTimer ~/3600;
            int t = timeForTimer - (3600 * h);
            int m = t ~/ 60;
            int s = t - (60 * m);
            displayTime = h.toString() + ":" + m.toString() + ":" + s.toString();
            timeForTimer = timeForTimer - 1;
          }
        });
    });
  }

  saveTime(){
    // timeForTimer = '${hour} : ${min} : ${sec}';
    return displayTime = '${hour} : ${min} : ${sec}';
  }


  // void addTime(){

  // }

  // void clearTimer() {
  //   checkTimer = false;
  // }

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
                    maxValue: 3,
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
                    NumberPicker.integer(initialValue: min,
                    minValue: 0,
                    maxValue: 59,
                    step: 15,
                    listViewWidth: 60.0,
                    onChanged: (val){
                        setState((){
                          min = val;
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
                    NumberPicker.integer(initialValue: sec,
                    minValue: 0,
                    maxValue: 59,
                    listViewWidth: 60.0,
                    onChanged: (val){
                        setState((){
                          sec = val;
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
                    saveTime();
                    Navigator.pop(context); 
                    setState((){
                      displayTime = saveTime();
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
  Widget build(BuildContext context) {
    return Container (
      height: 400,
      child: Center(
        child: timer(),
      )
    );
  }
}