import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'services/geolocator.dart';
import 'screens/login.dart';
import 'screens/mainScreen.dart';
import 'screens/scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metro ParQR',
      theme: ThemeData.dark(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/mainScreen': (context) => MainScreen(),
        '/scanner': (context) => Scanner(),
      }
    );
  }
}
