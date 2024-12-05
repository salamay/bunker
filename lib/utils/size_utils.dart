import 'dart:developer';

import 'package:flutter/cupertino.dart';

class SizeUtils{

  static double getSize(BuildContext context, double size) {
    var screenWidth = MediaQuery.of(context).size.width;
     if (screenWidth > 1200) { // Adjust this threshold as needed
      return size /1.5; // Adjust the scaling factor as needed
    } else {
      return size*3 ;
    }
  }

  static bool isTablet(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }

  static bool isMobileView(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }
}