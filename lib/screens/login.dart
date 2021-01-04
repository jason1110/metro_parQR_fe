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
                  Text('Login'),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.green, size: 25,),
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
                login = true;
                signUp = false;
                _formModal(context);
              },
            ),
            OutlineButton(
              borderSide: BorderSide(
                color: Colors.lightGreen,
                width: 3,
                ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              child: Text("Sign Up"),
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


