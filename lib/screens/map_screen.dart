import 'dart:async';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tara_app/common/constants/assets.dart';
import 'package:tara_app/common/constants/colors.dart';
import 'package:tara_app/common/constants/strings.dart';
import 'package:tara_app/common/constants/styles.dart';
import 'package:tara_app/screens/base/base_state.dart';

class Map extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends BaseState<Map> {

  LatLng _center = LatLng(0.0,0.0);
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {

    setState(() {
      mapController = controller;
    });
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1=await c.getVisibleRegion();
    LatLngBounds l2=await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if(l1.southwest.latitude==-90 ||l2.southwest.latitude==-90)
      check(u, c);
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.zero,
              onMapCreated: _onMapCreated,
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              tiltGesturesEnabled: false,
              mapToolbarEnabled: false,
              onCameraMove: _onCameraMove,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),),
            Positioned(
              top: 24,
              child: Container(
                margin: EdgeInsets.only(bottom: 10,right: 16,top: 10,left: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: InkWell(child:getTabImageWithSize(Assets.ic_back_arrow,25,25),onTap: (){
                        Navigator.pop(context, false);
                      },),
                    ),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child:Container(
                          padding: EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.search,size: 24,), //Navigator.pop(context, false),
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text(getTranslation(Strings.select_location),
                                  style: BaseStyles.alreadyHaveAccountTextStyle,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  init() {

  }
}