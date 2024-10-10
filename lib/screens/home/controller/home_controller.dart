import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{

  int currentPage = 0;

  void changePage(int index){
    currentPage = index;
    notifyListeners();
  }
}