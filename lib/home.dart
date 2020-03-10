import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'all_data.dart';
import 'battery_data.dart';
import 'image_controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BatteryData>(
            create: (BuildContext context) => BatteryData()),
        ChangeNotifierProvider<ImageController>(
            create: (BuildContext context) => ImageController()),
      ],
      child: Consumer<BatteryData>(
        builder: (BuildContext context, BatteryData batteryData, Widget child) {
          return ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              backgroundColor: Colors.red[900],
            ),
            inAsyncCall: batteryData.loading,
            child: RefreshIndicator(
              color: Colors.red[900],
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          top: 16.0,
                          bottom: 12.0,
                        ),
                        child: Text(
                          'Last Update: ' + batteryData.date,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     left: 16.0,
                      //     bottom: 12.0,
                      //   ),
                      //   child: Text(
                      //     'Device ID: ' + batteryData.deviceId,
                      //     style: TextStyle(fontSize: 14.0),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/solarPanel.png',
                                  width: 45.0,
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  batteryData.currentLogic(batteryData.c, 0),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Charge')
                              ],
                            ),
                          ),
                          Consumer<ImageController>(
                            builder: (BuildContext context,
                                ImageController imageController, Widget child) {
                              return Image.asset(
                                imageController.arrowLogic(batteryData.c, 0),
                                width: 30.0,
                              );
                            },
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Consumer<ImageController>(
                                builder: (BuildContext context,
                                    ImageController imageController,
                                    Widget child) {
                                  return Image.asset(
                                      imageController
                                          .battLogic(batteryData.percentage),
                                      width: 140.0);
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      batteryData.percentage + '%',
                                      style: TextStyle(
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      batteryData.vTot + ' V of 13.4 V',
                                      style: TextStyle(fontSize: 11.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Consumer<ImageController>(
                            builder: (BuildContext context,
                                ImageController imageController, Widget child) {
                              return Image.asset(
                                imageController.arrowLogic(batteryData.c, 1),
                                width: 30.0,
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Column(
                              children: <Widget>[
                                Consumer<ImageController>(
                                  builder: (BuildContext context,
                                      ImageController imageController,
                                      Widget child) {
                                    return Image.asset(
                                      imageController.loadLogic(batteryData.c),
                                      width: 45.0,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  batteryData.currentLogic(batteryData.c, 1),
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Discharge")
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 14.0),
                        child: Center(
                          child: Text(
                            'Power : ' + batteryData.power + ' W',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 8.0, left: 16.0, top: 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.ev_station),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'Voltage',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Cell 1: ' + batteryData.v1 + ' V',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Cell 2: ' + batteryData.v2 + ' V',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Cell 3: ' + batteryData.v3 + ' V',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Cell 4: ' + batteryData.v4 + ' V',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 8.0, left: 16.0, top: 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.ac_unit),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'Climate',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Sensor 1: ' + batteryData.t + '°C',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: 8.0, left: 16.0, top: 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.my_location),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              'Location',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Device ID: ' + batteryData.deviceId
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Device Name: ' + batteryData.getDeviceName(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Latitude: ' + batteryData.lat,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 24.0,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 42.0),
                              child: Text(
                                'Longitude: ' + batteryData.lng,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.insert_chart),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text("Show All Data"),
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AllData()));
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     MaterialButton(
                      //       color: Colors.grey[200],
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(18.0)),
                      //       child: Row(
                      //         children: <Widget>[
                      //           Icon(Icons.location_on),
                      //           SizedBox(
                      //             width: 8.0,
                      //           ),
                      //           Text("Street Light Locations"),
                      //         ],
                      //       ),
                      //       onPressed: () {
                      //         Navigator.of(context).push(MaterialPageRoute(
                      //             builder: (context) => Maps()));
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
              onRefresh: () {
                Completer<Null> completer = new Completer<Null>();
                new Timer(
                  new Duration(seconds: 1),
                  () {
                    batteryData.setLoading();
                    batteryData.downloadData();
                    completer.complete();
                  },
                );
                return completer.future;
              },
            ),
          );
        },
      ),
    );
  }
}
