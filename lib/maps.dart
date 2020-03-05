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
          pinPillPosition = 0;
        });
      },
    );
    Marker sl2 = Marker(
      markerId: MarkerId('2'),
      position: LatLng(-7.5595978, 110.8543561),
      infoWindow: InfoWindow(title: 'UNS Street Light'),
      icon: BitmapDescriptor.defaultMarker,
      onTap: () {
        setState(() {
          id = '2';
          mapsMarker = "UNS Street Light";
          // currentlySelectedPin = sourcePinInfo;
          pinPillPosition = 0;
        });
      },
    );
    @override
    Completer<GoogleMapController> _controller = Completer();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BatteryData>(
              create: (BuildContext context) => BatteryData()),
        ],
        child: Consumer<BatteryData>(builder:
            (BuildContext context, BatteryData batteryData, Widget child) {
          print(batteryData.loading);
          // if (batteryData.lat == "0") {
          //   print(batteryData.loading);
          //   batteryData.setLoading();
          //   batteryData.downloadData();
          //   print('loading on');
          //   return Scaffold(
          //     body: Center(child: CircularProgressIndicator()),
          //   );
          // } else {
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
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              blurRadius: 20,
                              offset: Offset.zero,
                              color: Colors.grey.withOpacity(0.5))
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(mapsMarker,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 8.0),
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
                                Text("View Details"),
                              ],
                            ),
                            onPressed: () {
                              setState(
                                () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setString("deviceId", id);
                                  // batteryData.setId(id);
                                },
                              );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => AllData()));
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
          //       }
          //     },
          //   ),
          // );
        }));
  }
}
// }

// class Maps2 extends StatelessWidget {
//   @override
// Widget build(BuildContext context) {
//   Marker sl1 = Marker(
//     markerId: MarkerId('streetlight1'),
//     position: LatLng(-7.561837, 110.7908509),
//     infoWindow: InfoWindow(title: 'Purwosari Street Light'),
//     icon: BitmapDescriptor.defaultMarker,
//   );
//   Marker sl2 = Marker(
//     markerId: MarkerId('streetlight2'),
//     position: LatLng(-7.5595978, 110.8543561),
//     infoWindow: InfoWindow(title: 'UNS Street Light'),
//     icon: BitmapDescriptor.defaultMarker,
//   );
//   @override
//   Completer<GoogleMapController> _controller = Completer();

//   return MultiProvider(
//     providers: [
//       ChangeNotifierProvider<BatteryData>(
//           create: (BuildContext context) => BatteryData()),
//     ],
//     child: Consumer<BatteryData>(
//       builder: (BuildContext context, BatteryData batteryData, Widget child) {
//         print(batteryData.loading);
//         if (batteryData.lat == "0") {
//           print(batteryData.loading);
//           batteryData.setLoading();
//           batteryData.downloadData();
//           print('loading on');
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         } else {
//           return Scaffold(
//             appBar: AppBar(
//               iconTheme: IconThemeData(color: Colors.black),
//               brightness: Brightness.light,
//               title: Text(
//                 'Your Street Light Location',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//               backgroundColor: Colors.grey[200],
//             ),
//             body: Stack(
//               children: <Widget>[
//                 GoogleMap(
//                   myLocationEnabled: true,
//                   compassEnabled: true,
//                   tiltGesturesEnabled: false,
//                   mapType: MapType.normal,
//                   markers: {sl1, sl2},
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(double.parse(batteryData.lat),
//                         double.parse(batteryData.lng)),
//                     zoom: 11,
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                   onTap: (LatLng location) {},
//                 ),
//                 AnimatedPositioned(
//                   bottom: 0,
//                   right: 0,
//                   left: 0,
//                   duration: Duration(milliseconds: 200),
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       margin: EdgeInsets.all(20),
//                       height: 70,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(50)),
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                               blurRadius: 20,
//                               offset: Offset.zero,
//                               color: Colors.grey.withOpacity(0.5))
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     ),
//   );
// }
// }

// class Maps extends StatefulWidget {
//   @override
//   _MapsState createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

// class Maps extends StatefulWidget {
//   @override
//   _MapsState createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   // Marker sl1 =
//   // );
//   // Marker sl2 = Marker(
//   //   markerId: MarkerId('streetlight2'),
//   //   position: LatLng(-7.5595978, 110.8543561),
//   //   infoWindow: InfoWindow(title: 'UNS Street Light'),
//   //   icon: BitmapDescriptor.defaultMarkerWithHue(
//   //     BitmapDescriptor.hueViolet,
//   //   ),
//   // );

//   GoogleMapController mapController;

//   // final LatLng _center = const LatLng(-7.550676, 110.829316);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   // @override
//   Completer<GoogleMapController> _controller = Completer();

//   // static final CameraPosition _kGooglePlex = CameraPosition(
//   //   target: LatLng(37.42796133580664, -122.085749655962),
//   //   zoom: 14.4746,
//   // );

//   // static final CameraPosition _kLake = CameraPosition(
//   //     bearing: 192.8334901395799,
//   //     target: LatLng(37.43296265331129, -122.08832357078792),
//   //     tilt: 59.440717697143555,
//   //     zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body:
//         GoogleMap(
//     //       markers: {Marker(
//     // markerId: MarkerId('streetlight1'),
//     // position: LatLng(-7.561837, 110.7908509),
//     // infoWindow: InfoWindow(title: 'Purwosari Street Light'),
//     // icon: BitmapDescriptor.defaultMarkerWithHue(
//     //   BitmapDescriptor.hueViolet,
//     // ),),},
//           mapType: MapType.normal,
//           initialCameraPosition:
//               CameraPosition(target: LatLng(-7.550676, 110.828316),zoom: 10),
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         ),
//         // Container(
//         //   width: double.infinity,
//         //   color: Colors.black26,
//         //   child: Padding(
//         //     padding: EdgeInsets.all(16.0),
//         //     child: Text(
//         //       "Last Update time: unknown :(",
//         //       style: TextStyle(
//         //           fontWeight: FontWeight.bold,
//         //           color: Colors.white,
//         //           shadows: <Shadow>[
//         //             Shadow(
//         //               offset: Offset(
//         //                 2.0,
//         //                 2.0,
//         //               ),
//         //               blurRadius: 6.0,
//         //               color: Colors.black,
//         //             )
//         //           ]),
//         //     ),
//         //   ),
//         // ),

//       // floatingActionButton: FloatingActionButton.extended(
//       //   onPressed: _goToTheLake,
//       //   label: Text('To the lake!'),
//       //   icon: Icon(Icons.directions_boat),
//       // ),
//     );
//   }

//   // Future<void> _goToTheLake() async {
//   //   final GoogleMapController controller = await _controller.future;
//   //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   // }
// }
