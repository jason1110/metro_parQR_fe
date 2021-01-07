import 'package:flutter/material.dart';
import 'package:metro_parqr_fe/screens/mainScreen.dart';

class SignUpForm extends StatefulWidget {

  const SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


void _submit() {
    _formKey.currentState.validate();
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
    print('Form submitted');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            cursorColor: Color.fromRGBO(235,255,235,1),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: Color.fromRGBO(101,184,0,0.6)),   
                ),  
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(235,255,235,1)),
                ),
              labelText: 'name',
              labelStyle: TextStyle(color: Color.fromRGBO(235,255,235,0.6))
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
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
              labelStyle: TextStyle(color: Color.fromRGBO(235,255,235,0.6))
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
              
              labelStyle: TextStyle(color: Color.fromRGBO(235,255,235,0.6))
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please create a password';
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
              child: Text('Submit'),
              color: Color.fromRGBO(62,176,0,1),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green[700]),
                ),
            )
          )
        ]
      )
    );
  }
}