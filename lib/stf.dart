import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    this.getData();
  }

  final String url = 'http://smartbms.000webhostapp.com/api/get_datas2.php?z=1';

  bool loading = true;
  Data _data;

  getData() async {
    var res = await http.get(url);
    setState(() {
      var content = json.decode(res.body)['0'];
      print(content);
      _data = new Data(
          content['vc1'], content['vc2'], content['vc3'], content['vc4']);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: RadialGradient(
          center: Alignment(0, -0.5),
          colors: <Color>[
            Colors.grey[200],
            Colors.grey[300],
            Colors.grey[400],
            Colors.grey[500],
            Colors.grey[600],
            Colors.black26,
            Colors.black38,
            Colors.black45,
            Colors.black54,
            Colors.black87,
            // Colors.black
          ],
          // focalRadius: 100
          // radius: 1,
          // stops: [0.4, 0.5, 0.6, 0.7, 0.8, 1.0],
        ),
      ),
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Text(_data.vc1),
                Text(_data.vc2),
                Text(_data.vc3),
                Text(_data.vc4),
              ],
            ),
    );
  }
}

class Data {
  String vc1;
  String vc2;
  String vc3;
  String vc4;

  Data(this.vc1, this.vc2, this.vc3, this.vc4);
}