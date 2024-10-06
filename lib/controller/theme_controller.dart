import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ThemeController extends ChangeNotifier{
  bool isDark=true;

  void changeThemeToDark(){

    notifyListeners();
  }
  void changeThemeToWhite(){
    isDark=false;
    notifyListeners();
  }
}