// import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BatteryData with ChangeNotifier {
  String vc1 = '0';
  String vc2 = '0';
  String vc3 = '0';
  String vc4 = '0';
  String c1 = '0';
  String t1 = '0';
  String temp = '0';
  String date = '0';
  String percentage = '0';
  String power = '0';
  bool loading = false;
  BuildContext context;

  var data;

  final String url = 'http://smartbms.000webhostapp.com/api/get_datas2.php?z=1';

  void setLoading() {
    loading = true;
    notifyListeners();
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
      vc1 = double.parse(data['vc1']).toStringAsFixed(2);
      vc2 = double.parse(data['vc2']).toStringAsFixed(2);
      vc3 = double.parse(data['vc3']).toStringAsFixed(2);
      vc4 = double.parse(data['vc4']).toStringAsFixed(2);
      c1 = double.parse(data['c1']).toStringAsFixed(2);
      t1 = double.parse(data['t1']).toStringAsFixed(2);
      temp = double.parse(data['temp']).toStringAsFixed(2);
      date = data['date'];
      double e = ((double.parse(t1) / 13.4) * 100);
      if (e > 100) {
        percentage = '100';
      } else {
        percentage = e.toStringAsFixed(0);
      }
      //0.92 is value of efficiency
      power = ((double.parse(t1)) * (double.parse(c1).abs() * 0.92))
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
