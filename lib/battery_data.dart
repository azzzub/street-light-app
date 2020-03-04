// import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BatteryData with ChangeNotifier {
  String user_id = '0';
  String device_id = '0';
  String v1 = '0';
  String v2 = '0';
  String v3 = '0';
  String v4 = '0';
  String v_tot = '0';
  String c = '0';
  String t = '0';
  String c_off = '0';
  String date = '0';
  String lat = '0';
  String lng = '0';
  String percentage = '0';
  String power = '0';
  bool loading = false;
  bool initialRunLogic = true;
  BuildContext context;

  var data;

  final String url =
      'http://smart-street-light.000webhostapp.com/read_data.php?device_id=1';

  void setLoading() {
    loading = true;
    notifyListeners();
  }

  bool initialRun() {
    if (initialRunLogic) {
      setLoading();
      downloadData();
      if (!loading) {
        return true;
      }
    }
      return false;
    
  }

  Future downloadData() async {
    var response =
        await http.get(url).timeout(Duration(seconds: 10), onTimeout: () {
      print('to');
      loading = false;
      Fluttertoast.showToast(msg: "Request Timeout!");
      return null;
    });
    print(response);

    if (response != null) {
      data = json.decode(response.body)['0'];

      loading = false;
      user_id = double.parse(data['user_id']).toString();
      device_id = double.parse(data['device_id']).toString();
      v1 = double.parse(data['v1']).toStringAsFixed(2);
      v2 = double.parse(data['v2']).toStringAsFixed(2);
      v3 = double.parse(data['v3']).toStringAsFixed(2);
      v4 = double.parse(data['v4']).toStringAsFixed(2);
      v_tot = double.parse(data['v_tot']).toStringAsFixed(2);
      c = double.parse(data['c']).toStringAsFixed(2);
      t = double.parse(data['t']).toStringAsFixed(2);
      date = data['date'];
      lat = double.parse(data['lat']).toStringAsFixed(6);
      lng = double.parse(data['lng']).toStringAsFixed(6);

      double e = ((double.parse(v_tot) / 13.4) * 100);
      if (e > 100) {
        percentage = '100';
      } else {
        percentage = e.toStringAsFixed(0);
      }
      //0.92 is value of efficiency
      power = ((double.parse(v_tot)) * (double.parse(c).abs() * 0.92))
          .toStringAsFixed(2);

      print(data);
      Fluttertoast.showToast(msg: "Getting data success!");
    }
    notifyListeners();
  }

  String currentLogic(String value, int condition) {
    // conditon 0 = charge condition
    double e = double.parse(value);
    if ((e > 0) && (condition == 0)) {
      // some logic that allow animated arrow when current is positive
      // and on the charge condition
      return e.abs().toString() + ' A';
    } else if ((e > 0) && (condition == 1)) {
      return '-';
    } else if ((e < 0) && (condition == 1)) {
      return e.abs().toString() + ' A';
    } else if ((e < 0) && (condition == 0)) {
      return '-';
    } else {
      return '-';
    }
  }
}
