import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Set<Marker> markers = new Set();
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    getMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      onCameraIdle: () {},
      initialCameraPosition: CameraPosition(
        target: LatLng(40.9896068858736, 29.14728433174961),
        zoom: 18,
      ),
      onCameraMove: (position) async {},
      onMapCreated: (GoogleMapController controller) async {
        _controller.complete(controller);
      },
    ));
  }

  Future<Set<Marker>> getMarkers() async {
    List<LatLng> a = [];

    a.add(LatLng(40.9896068858736, 29.14728433174961));
    a.add(LatLng(40.990716361703214, 29.147692027517053));
    a.add(LatLng(40.98950970461972, 29.147734942860996));
    a.add(LatLng(40.989833641575636, 29.14996654074595));

    for (var i = 0; i < 4; i++) {
      double id = i.toDouble();
      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: a[i],
        infoWindow: InfoWindow(
          title: i.toString(),
          snippet: i.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
    return markers;
  }
}
