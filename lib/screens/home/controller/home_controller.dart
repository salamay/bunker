import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{

  int currentPage = 4;

  void changePage(int index){
    currentPage = index;
    notifyListeners();
  }
}