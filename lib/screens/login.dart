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
            RichText(
              text: TextSpan(
                text: 'Metro',
                style: TextStyle(
                  fontSize: 50,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'ParQR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                  )
                ],
                ),
              ),
            OutlineButton(
              borderSide: BorderSide(
                color: Colors.lightGreen,
                width: 3,
                ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
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


