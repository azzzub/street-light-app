import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'maps.dart';
import 'settings.dart';
import 'home.dart';
import 'info.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        fontFamily: 'MaisonNeue',
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.grey[200],
        title: Padding(
          padding: const EdgeInsets.only(
            top: 6.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Batex",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Azonix',
                  fontSize: 24.0,
                  color: Colors.red[900],
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                'energy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Coves',
                  letterSpacing: 1.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.red[900],
        inactiveIconColor: Colors.red[900],
        initialSelection: 1,
        tabs: [
          TabData(iconData: Icons.location_on, title: "Maps"),
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.info_outline, title: "Info")
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
            // print(currentPage);
          });
        },
      ),
      body: IndexedStack(
        index: currentPage,
        children: <Widget>[
          Maps(),
          Home(),
          Info(),
        ],
      ),
    );
  }
}