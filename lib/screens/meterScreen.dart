import 'package:flutter/material.dart';
import 'timeScreen.dart';
import 'package:numberpicker/numberpicker.dart';

class MeterInfo extends StatefulWidget {

  MeterInfo({this.qrCodeInfo});

  final qrCodeInfo;

  @override
  _MeterInfoState createState() => _MeterInfoState();
}

class _MeterInfoState extends State<MeterInfo> {

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

  final rowSpacer = TableRow(
    children: [
      SizedBox(
        height: 20,
      ),
      SizedBox(
        height: 20,
      )
    ]
  );

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
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green[700]),
                  ),
                  color: Color.fromRGBO(62,176,0,1),
                  padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0
                  ),
                  child: Text(
                    'Set Timer',
                    style: TextStyle(
                      fontSize: 18.0,
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
                  icon: Icon(Icons.cancel, color: Color.fromRGBO(62,176,0,1), size: 25,),
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

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241,253,246,1),
      appBar: AppBar(
        title: Text('Get Set'),
        backgroundColor: Color.fromRGBO(20,17,21,1),
        centerTitle: true,
        ),
        body: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Text(
              'Meter Info',
              style: TextStyle(
                color: Color.fromRGBO(20,17,21,1),
                fontSize: 50.0,
                )
            ),
            SizedBox(height: 30.0),
            Card(
              margin: EdgeInsets.all(30.0),
              elevation: 8,
              color: Color.fromRGBO(0, 36, 27, 1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Table(
                    children: <TableRow>[ 
                      rowSpacer,
                      TableRow(
                      children: <Widget>[
                        Text('Meter Id:',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Text('$id',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ]
                    ),
                    rowSpacer,
                      TableRow(
                      children: <Widget>[
                        Text('Max Stay:',                         
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Text('$maxStay hours',                          
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ]
                    ),
                    rowSpacer,
                      TableRow(
                      children: <Widget>[
                        Text('Free times:',                         
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Text('$freeTime')
                      ]
                    ),
                    rowSpacer,
                      TableRow(
                      children: <Widget>[
                        Text('Normal Rate:',                          
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Text('\$$cost /hr',                          
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ]
                      ),
                      rowSpacer,
                    ],
                  ),
                ),
              )
            ),
            SizedBox(height: 20.0),
            Text(
              'How long are you Staying?',
              style: TextStyle(
                color: Color.fromRGBO(20,17,21,1),
                fontSize: 25.0,
                )
            ),
            SizedBox(height: 20.0),
          RaisedButton(
            child: Text("Set your time",
                style: TextStyle(
                fontSize: 22
              ),
            ),            
            onPressed: () {
              _setTimerModal(context);
            },
            color: Color.fromRGBO(62,176,0,1),
            highlightColor: Colors.lightGreen[50],
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              '$displayTime',
              style: TextStyle(
                color: Color.fromRGBO(20,17,21,1),
                fontSize: 30.0,
              ),
            ),
          ),
          RaisedButton(
            child: Text('Park',
              style: TextStyle(
                fontSize: 22
              ),
            ),
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => TimeScreen(savedHour: hour, savedMin: minute, savedSec: second, meterStats: widget.qrCodeInfo )
                  )
                );
              },
            color: Color.fromRGBO(62,176,0,1),
            highlightColor: Colors.lightGreen[50],  
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )
          ),
        ],
      ),
    ),
    );
  }
}


dynamic unspecifiedVariable = 'any data type can be declared here';


