import 'package:flutter/material.dart';
import '../services/signUpForm.dart';

class SignUpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SignUpForm(),
      ),
    );
  }
}