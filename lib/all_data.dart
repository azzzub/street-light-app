import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class AllData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      url: "https://smart-street-light.000webhostapp.com/",
      // withJavascript: true,
      // withZoom: false,
    );
  }
}