import 'dart:async';

import 'package:absen_pekerja/model/absen_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailUser extends StatefulWidget {
  final Absen dataUser;
  DetailUser({this.dataUser});

  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  Completer<GoogleMapController> mapController = Completer();
  final Map<String, Marker> _marker = {};

  void getCurrentLoc() async {
    var currentLoc = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      final myMarker = Marker(
          markerId: MarkerId("My Location"),
          position: LatLng(currentLoc.latitude, currentLoc.longitude),
          infoWindow: InfoWindow(title: "My Location", snippet: "MyLocation"));
      _marker['current marker'] = myMarker;

      CameraPosition camPosition = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(currentLoc.latitude, currentLoc.longitude),
          zoom: 15);
      changeCameraPostion(camPosition);
    });

    print("Latitude ${currentLoc.latitude}");
    print("Longitude ${currentLoc.longitude}");
  }

  void changeCameraPostion(CameraPosition camPosition) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(camPosition));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLoc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail User"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 5,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Nama",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text(widget?.dataUser?.fullnameUser ?? "",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500))
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Check In",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text(widget?.dataUser?.checkIn ?? "-",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500))
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Place",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              Text(widget?.dataUser?.place ?? "-",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500))
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(-6.1753924, 106.8249641), zoom: 15.0),
                    onMapCreated: (controller) {
                      mapController.complete(controller);
                    },
                    markers: _marker.values.toSet(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
