import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GeoProvider extends ChangeNotifier {
  bool isVisible = true;

  void activeMenu() {
    (isVisible == false) ? (isVisible = true) : (isVisible = false);
    notifyListeners();
  }

  StreamSubscription? streamSubscription;

  final Location _tracker = Location();

  Marker? marker;

  Circle? circle;

  GoogleMapController? googleMapController;

  CameraPosition initialLocation =
      const CameraPosition(target: LatLng(-12.0752471, -75.2194138), zoom: 14);

  void updateUser(LocationData newLocation) {
    LatLng latLng = LatLng(newLocation.latitude!, newLocation.longitude!);

    marker = Marker(
        markerId: const MarkerId('marcador'),
        position: latLng,
        rotation: newLocation.latitude!,
        draggable: false,
        zIndex: 2,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.defaultMarker);

    circle = Circle(
        circleId: const CircleId('mCircle'),
        radius: newLocation.accuracy!,
        zIndex: 1,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70),
        strokeColor: Colors.lightBlue);
  }

  void getLocationUser() async {
    try {
      var location = await _tracker.getLocation();

      updateUser(location);
      notifyListeners();

      await _tracker.onLocationChanged.listen((event) {
        if (googleMapController != null) {
          googleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(event.latitude!, event.longitude!), zoom: 10),
            ),
          );
        }
      });
    } on PlatformException catch (e) {
      print("MAP:" + e.code);
      if (e.code == 'PERMISION') {}
    }
  }
}
