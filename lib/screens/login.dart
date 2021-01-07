import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'mainScreen.dart';
import 'signUpScreen.dart';
import '../services/loginForm.dart';
import '../services/signUpForm.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool login = false;
  bool signUp = false;

  void _formModal (context) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(context).size.height + .60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Color.fromRGBO(62,176,0,1), size: 25,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              login 
              ? LoginForm()
              :SignUpForm()
            ],
          ),
        ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Location"),
      // ),
      backgroundColor: Color.fromRGBO(20,17,21,1),
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
                      color: Color.fromRGBO(62,176,0,1),
                    ),
                  )
                ],
                ),
              ),
            SizedBox(height: 50.0,),
            OutlineButton(
              highlightColor: Colors.lightGreen[50],
              highlightedBorderColor: Colors.lightGreenAccent,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              borderSide: BorderSide(
                color: Color.fromRGBO(62,176,0,1),
                width: 3,
                ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              child: Text("Login",
              style: TextStyle(
                fontSize: 18,
                ),
              ),
              onPressed: () {
                login = true;
                signUp = false;
                _formModal(context);
              },
            ),
            SizedBox(height: 10.0,),
            RaisedButton(
              color: Color.fromRGBO(62,176,0,1),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 36.0),
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text("Sign Up",
              style: TextStyle(
                fontSize: 18,
                ),
              ),
              onPressed: () {
                signUp = true;
                login = false;
                _formModal(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}


