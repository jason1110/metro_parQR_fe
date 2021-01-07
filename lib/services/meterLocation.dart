import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;


class MeterLocation extends StatefulWidget {
  

  @override
  _MeterLocationState createState() => _MeterLocationState();

}

class _MeterLocationState extends State<MeterLocation> {


StreamSubscription _locationSubscription;
Location _locationTracker = Location();
Marker marker;
Marker meterMarker;
LatLng meterLoc = LatLng(39.746633, -104.981047);

GoogleMapController _controller;

static final CameraPosition initialLocation = CameraPosition(
target: LatLng(39.746633, -104.981047),
zoom: 17.0,
);


  void updateMarkerAndCircle() {
    // LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    LatLng meterLoc = LatLng(39.746633, -104.981047);
    this.setState(() {
      meterMarker = Marker(
        markerId: MarkerId('meter'),
        position: meterLoc,
        draggable: false,
        zIndex: 1,
        flat: false,
        anchor: Offset(1, 1),
        icon: BitmapDescriptor.defaultMarkerWithHue(240),
      );  
    });
  }

  Future<void> getCurrentLocation() async {
    try {
      // Uint8List imageData = await getMarker();
      var location = meterLoc;

      updateMarkerAndCircle();

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData){
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
            bearing: 192.8334901395799,
            target: meterLoc,
            tilt: 0,
            zoom: 17.00,
            ),
          ));
          updateMarkerAndCircle();
        }
      });
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION_DENIED') {
        debugPrint('Permission Denied');
      }
    }
  }

    @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          markers: Set.of((meterMarker != null) ? [meterMarker] : []),
          onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
