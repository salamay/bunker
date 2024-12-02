import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../utils/password_checker.dart';

class RegistrationController extends ChangeNotifier{
  bool containsLowercase=false;
  bool containsUpperCase=false;
  bool containsNumber=false;
  bool containSymbol=false;
  bool eightCharacters=false;
  bool isPassObscured=true;

  void changeObscuredStatus(bool status){
    isPassObscured=status;
    notifyListeners();
  }

  void checkInput(String input){
    log("Check input for :$input");
    containsLowercase=PassWordChecker.containLowercase(input);
    containsUpperCase=PassWordChecker.containsUppercase(input);
    containsNumber=PassWordChecker.containNumber(input);
    containSymbol=PassWordChecker.containsSymbol(input);
    eightCharacters=PassWordChecker.isEightCharactersLong(input);
    notifyListeners();
  }

  void clearInputCheck(){
    log("Input check cleared");
    isPassObscured=false;
    containsLowercase=false;
    containsUpperCase=false;
    containsNumber=false;
    containSymbol=false;
    eightCharacters=false;
  }

}