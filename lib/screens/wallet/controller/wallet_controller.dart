import 'package:flutter/cupertino.dart';

enum WalletAction{
  send,receive
}
class WalletController extends ChangeNotifier{

  int selectedIndex=0;

  void changeIndex(int index){
    selectedIndex=index;
    notifyListeners();
  }
}