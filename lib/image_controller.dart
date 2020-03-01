import 'package:flutter/material.dart';

String imageLink = 'assets/images/';

class ImageController with ChangeNotifier {
  String staticArrow = imageLink + 'staticArrow.png';
  String animatedArrow = imageLink + 'animatedArrow.gif';
  String batt25 = imageLink + 'batt25.png';
  String batt50 = imageLink + 'batt50.png';
  String batt75 = imageLink + 'batt75.png';
  String batt100 = imageLink + 'batt100.png';
  String loadOn = imageLink + 'loadOn.png';
  String loadOff = imageLink + 'loadOff.png';
  String solarPanel = imageLink + 'solarPanel.png';

  String battLogic(String value) {
    double e = double.parse(value);
    if (e <= 25) {
      return batt25;
    } else if ((e > 25) && (e <= 50)) {
      return batt50;
    } else if ((e > 50) && (e <= 75)) {
      return batt75;
    } else {
      return batt100;
    }
  }

  String arrowLogic(String value, int condition) {
    // conditon 0 = charge condition
    double e = double.parse(value);
    if ((e > 0) && (condition == 0)) {
      // some logic that allow animated arrow when current is positive
      // and on the charge condition
      return animatedArrow;
    } else if ((e > 0) && (condition == 1)) {
      return staticArrow;
    } else if ((e < 0) && (condition == 1)) {
      return animatedArrow;
    } else if ((e < 0) && (condition == 0)) {
      return staticArrow;
    } else {
      return staticArrow;
    }
  }

  String loadLogic(String value) {
    double e = double.parse(value);
    if (e >= 0) {
      return loadOff;
    } else {
      return loadOn;
    }
  }
}
