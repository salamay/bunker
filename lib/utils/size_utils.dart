import 'package:flutter/cupertino.dart';

class SizeUtils{

  static double getSize(BuildContext context,double size){
    if(!isTablet(context)){
      return size/1.6;
    }else{
      return size;
    }
  }

  static bool isTablet(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }
}