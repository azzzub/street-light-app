import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'battery_data.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  double pinPillPosition = -200;
  String mapsMarker = "";
  String id;
  @override
  Widget build(BuildContext context) {
    Marker sl1 = Marker(
      markerId: MarkerId('1'),
      position: LatLng(-7.561837, 110.7908509),
      infoWindow: InfoWindow(title: 'Purwosari Street Light'),
      icon: BitmapDescriptor.defaultMarker,
      onTap: () {
        setState(() {
          id = '1';
          mapsMarker = "Purwosari Street Light";
          // currentlySelectedPin = sourcePinInfo;
          pinPillPosition = 50;
        });
      },
    );
    Marker sl2 = Marker(
      markerId: MarkerId('2'),
      position: LatLng(-7.5595978, 110.8543561),
      infoWindow: InfoWindow(title: 'UNS Street Light'),
      icon: BitmapDescriptor.defaultMarker,
      onTap: () {
        setState(
          () {
            id = '2';
            mapsMarker = "UNS Street Light";
            // currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 50;
          },
        );
      },
    );
    @override
    Completer<GoogleMapController> _controller = Completer();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BatteryData>(
            create: (BuildContext context) => BatteryData()),
      ],
      child: Consumer<BatteryData>(
        builder: (BuildContext context, BatteryData batteryData, Widget child) {
          print(batteryData.loading);
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              brightness: Brightness.light,
              title: Text(
                'Your Street Light Location',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              backgroundColor: Colors.grey[200],
            ),
            body: Stack(
              children: <Widget>[
                GoogleMap(
                  myLocationEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: false,
                  mapType: MapType.normal,
                  markers: {sl1, sl2},
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        double.parse("-7.550676"), double.parse("110.828316")),
                    zoom: 11,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: (LatLng location) {
                    setState(() {
                      pinPillPosition = -200;
                    });
                  },
                ),
                AnimatedPositioned(
                  bottom: pinPillPosition,
                  right: 0,
                  left: 0,
                  duration: Duration(milliseconds: 200),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              blurRadius: 20,
                              offset: Offset.zero,
                              color: Colors.grey.withOpacity(0.5))
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                            child: CircleAvatar(
                              child: Image.asset('/images/streetLightAva.png'),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: Text(
                              mapsMarker,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          MaterialButton(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.list),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text("Details"),
                              ],
                            ),
                            onPressed: () {
                              setState(
                                () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setString("deviceId", id);
                                  // Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
