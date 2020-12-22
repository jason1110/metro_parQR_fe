import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'mainScreen.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  // void getLocation() async {
  // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  // print(position);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Location"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.pushNamed(
                  context, '/mainScreen'
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


