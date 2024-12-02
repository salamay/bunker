class PassWordChecker{

  static bool containNumber(String input) {
    // Regular expression to check if the input contains a number
    final RegExp regex = RegExp(r'\d');

    return regex.hasMatch(input);
  }

  static bool containsSymbol(String input) {
    // Regular expression to check if the input contains a symbol
    final RegExp regex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    return regex.hasMatch(input);
  }

  static bool containLowercase(String input) {
    // Regular expression to check if the input contains lowercase letters
    final RegExp regex = RegExp(r'[a-z]');

    return regex.hasMatch(input);
  }
  static bool containsUppercase(String input) {
    // Regular expression to check if the input contains uppercase letters
    final RegExp regex = RegExp(r'[A-Z]');

    return regex.hasMatch(input);
  }
  static bool isEightCharactersLong(String input){
    if(input.length>=8){
      return true;
    }else{
      return false;
    }
  }
}