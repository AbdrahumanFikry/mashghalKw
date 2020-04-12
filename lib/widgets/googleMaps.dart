import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoder/geocoder.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  //-----------------------------variables--------------------------------------

  double lastLat;
  double lastLong;
  String address;
  var geolocator = Geolocator();
  List<Marker> allMarkers = [];
  bool _moved = false;
  Completer<GoogleMapController> _controller = Completer();

  static LatLng latLng = LatLng(24.774265, 46.738586);
  LatLng userLatLng;

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: latLng, zoom: 5);
  CameraPosition _position = _kInitialPosition;

  GoogleMapController mapController;

  //-------------------------------methods--------------------------------------
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void yourFunction(double latitude, double longitude) {
    final coordinates = new Coordinates(latitude, longitude);
    Geocoder.local.findAddressesFromCoordinates(coordinates).then((addresses) {
      var first = addresses.first.addressLine;
      address = first;
    });
  }

  void _extractMapInfo(position) {
    _position = position;
  }

  void _onDone(BuildContext context) {
    Navigator.pop(context, [userLatLng, address]);
  }

  Future<void> getLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.denied:
//        print('denied');
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
//        print('restricted');
        break;
      case GeolocationStatus.unknown:
//        print('unknown');
        break;
      case GeolocationStatus.granted:
        await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((Position _position) {
          if (_position != null) {
            setState(() {
              latLng = LatLng(
                _position.latitude,
                _position.longitude,
              );
              userLatLng = LatLng(_position.latitude, _position.longitude);
              yourFunction(_position.latitude, _position.longitude);
//              print('::::::::::::::::::::::::::::' +
//                  _position.latitude.toString());
//              print('::::::::::::::::::::::::::::' +
//                  _position.latitude.toString());
            });
            allMarkers.add(
              Marker(
                markerId: MarkerId('myMarker'),
                draggable: true,
                onTap: () {
//                  print('Marker Tapped');
                },
                position: LatLng(
                  _position.latitude,
                  _position.longitude,
                ),
                visible: true,
                onDragEnd: ((value) {
                  setState(() {
                    _moved = true;
                  });
                  userLatLng = LatLng(value.latitude, value.longitude);
                  yourFunction(value.latitude, value.longitude);
                }),
              ),
            );
          }
        });
        break;
    }
  }

  //---------------------------------build--------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            onCameraMove: (_position) => _extractMapInfo(_position),
            initialCameraPosition: _position,
            myLocationButtonEnabled: false,
            gestureRecognizers: Set()
              ..add(
                Factory<PanGestureRecognizer>(
                  () => PanGestureRecognizer(),
                ),
              ),
            markers: Set.from(allMarkers),
          ),
          Positioned(
            bottom: 20.0,
            right: 5.0,
            child: FloatingActionButton.extended(
              label: Text(
                _moved ? 'تم' : 'استخدام موقعك الحالى ',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'beINNormal',
                  fontSize: 12.0,
                ),
              ),
              backgroundColor: Color.fromRGBO(104, 57, 120, 10),
              onPressed: () => _onDone(context),
              icon: Icon(
                Icons.done,
                color: Color.fromRGBO(235, 218, 241, 10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
