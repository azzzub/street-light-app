import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllData extends StatefulWidget {
  @override
  _AllDataState createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  String deviceName;

  downloadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      deviceName = preferences.getString("deviceId");
    });
    // print(deviceName);
    // return deviceName.toString();
  }

  @override
  Widget build(BuildContext context) {
    // print(deviceName);
    downloadData();
    return WebviewScaffold(
      // userAgent: "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1",
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        title: Text(
          'Show All Data',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
      ),
      url:
          "https://smart-street-light.000webhostapp.com/view_data.php?device_id=" +
              deviceName,
      withJavascript: true,
      // withZoom: false,
    );
  }
}
