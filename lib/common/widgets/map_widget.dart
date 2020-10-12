
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tara_app/screens/base/base_state.dart';

class MapWidget extends StatefulWidget {
  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends BaseState<MapWidget> {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build (BuildContext context) {
    return Expanded(
      child:GoogleMap(initialCameraPosition: CameraPosition(target:
      LatLng(-33.870840,151.206286),
          zoom: 12)
      ),
    );
  }

  @override
  BuildContext getContext() {
    // TODO: implement getContext
    return context;
  }


}