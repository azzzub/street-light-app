import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/undrawInfo.png',
            width: 300.0,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text('I am working on it! Wait for next update!'),
        ],
      ),
    );
  }
}