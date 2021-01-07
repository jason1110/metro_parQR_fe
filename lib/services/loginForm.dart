import 'package:flutter/material.dart';
import 'package:metro_parqr_fe/screens/mainScreen.dart';

class LoginForm extends StatefulWidget {

  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();


void _submit() {
    _loginFormKey.currentState.validate();
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            cursorColor: Color.fromRGBO(235,255,235,1),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: Color.fromRGBO(62,176,0,1)),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(235,255,235,1)),
                ),
              labelText: 'email',
              labelStyle: TextStyle(color: Color.fromRGBO(235,255,235,0.5))
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            cursorColor: Color.fromRGBO(235,255,235,1),
            obscureText: true,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: Color.fromRGBO(62,176,0,1)),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(235,255,235,1)),
                ),
              labelText: 'password',
              labelStyle: TextStyle(color: Color.fromRGBO(235,255,235,0.5))
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0,),
          Center(
            child: RaisedButton(
              onPressed: () {
                _submit();
              },
              child: Text('Login'),
              color: Color.fromRGBO(62,176,0,1),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.green[700]),
              )
            ),
          )
        ]
      )
    );
  }
}