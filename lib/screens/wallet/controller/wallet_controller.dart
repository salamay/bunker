import 'package:flutter/cupertino.dart';

enum WalletAction{
  send,receive
}
class WalletController extends ChangeNotifier{

  int selectedIndex=0;
  bool isReceive=false;

  void changeIndex(int index){
    selectedIndex=index;
    notifyListeners();
  }

  void changeModal(bool status){
    isReceive=status;
    notifyListeners();
  }
}