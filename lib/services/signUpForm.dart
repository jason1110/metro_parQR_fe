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
            decoration: const InputDecoration(
              labelText: 'name',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
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
            child: Text('Submit'),
          )
        ]
      )
    );
  }
}