import 'package:geolocator/geolocator.dart';


  void getLocation() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  print(position);
  }