

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tara_app/screens/base/base_state.dart';

class MapWidget extends StatefulWidget {
  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends BaseState<MapWidget> {

  GoogleMapController myMapController;

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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
//            markers: this.myMarker(),
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                myMapController = controller;
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }


}