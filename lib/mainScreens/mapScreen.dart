import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mashghal_co/mainScreens/coiffeurDetails.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../providers/notificationProvider.dart';

class MapScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'mapScreen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //-----------------------------variables--------------------------------------
  final TextEditingController _searchQuery = new TextEditingController();
  String address;
  bool typing = false;
  double lastLat;
  double lastLong;
  var geolocator = Geolocator();
  List<Widget> closers = [];
  List<Marker> allMarkers = [];
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

  Widget _mapViewer(int id, String title, double lat, double long) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CoiffeurDetailsScreen(
              id: id,
            ),
          ),
        );
      },
      title: Text(
        title,
        style: TextStyle(
          color: Color.fromRGBO(104, 57, 120, 10),
          fontSize: 18.0,
          fontFamily: 'beINNormal',
        ),
        textAlign: TextAlign.end,
      ),
      trailing: Icon(
        Icons.location_on,
        color: Colors.red,
        size: 20.0,
      ),
    );
  }

  Future<void> _fetchClosers() async {
    await Provider.of<Notifications>(context, listen: false)
        .fetchClosers(address);
    final _closers = Provider.of<Notifications>(context, listen: false).closers;
    for (var i in _closers) {
      final newPlace = _mapViewer(i.id, i.name, i.lat, i.long);
      closers.add(newPlace);
    }
    _jopSelection();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _extractMapInfo(position) {
    _position = position;
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
                  userLatLng = LatLng(value.latitude, value.longitude);
                }),
              ),
            );
          }
        });
        break;
    }
  }

  //----------------------------Add handler-------------------------------------
  void _jopSelection() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        context: context,
        builder: (builder) {
          return ListView(children: closers);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: TextField(
            onChanged: (value) {
              address = value;
            },
            controller: _searchQuery,
            style: new TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
            ),
            decoration: new InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  width: 0.5,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  width: 1.0,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _fetchClosers();
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Icon(
                  Icons.search,
                  color: Color.fromRGBO(104, 57, 120, 10),
                ),
              ),
              hintText: 'بحث ...',
              hintStyle: new TextStyle(
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: GoogleMap(
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
      ),
    );
  }
}
