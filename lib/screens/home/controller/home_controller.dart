import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{

  int currentPage = 5;

  void changePage(int index){
    currentPage = index;
    notifyListeners();
  }
}