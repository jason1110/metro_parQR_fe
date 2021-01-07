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
            decoration: const InputDecoration(
              labelText: 'email',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'password',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please create a password';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              _submit();
            },
            child: Text('Login'),
          )
        ]
      )
    );
  }
}