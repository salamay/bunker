import 'package:shared_preferences/shared_preferences.dart';

class MyLocalStorage{

  Future<void> setIsFirstLogin(bool status)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("first_login", status);
  }
  Future<bool> isFirstLogin()async{
    final prefs = await SharedPreferences.getInstance();
    bool? value= prefs.getBool("first_login");
    return value??false;
  }

  Future<void> setIsGoogleAuth(bool status)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("google_auth", status);
  }

  Future<bool> isGoogleAuth()async{
    final prefs = await SharedPreferences.getInstance();
    bool? value= prefs.getBool("google_auth");
    return value??false;
  }
  Future<void> setGoogleAuthSecretKey(String secretKey)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("google_secret_key",secretKey);
  }
  Future<String> getGoogleAuthSecretKey()async{
    final prefs = await SharedPreferences.getInstance();
    String? value= prefs.getString("google_secret_key");
    return value??"";
  }
}