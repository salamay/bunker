import 'dart:convert';
import 'dart:developer';

import 'package:bunker/user/model/user_crendential.dart';
import 'package:flutter/cupertino.dart';

import '../../api/my_api.dart';
import '../../api/url/Api_url.dart';

class UserController extends ChangeNotifier{
  final my_api = MyApi();
  // UserCredential? userCredential=UserCredential(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJheW90dW5kZXNhbGFtMTZAZ21haWwuY29tIiwiaWF0IjoxNzMwODQ3NDEwLCJleHAiOjE3NjIyOTcwMTAsImF1ZCI6ImF5b3R1bmRlc2FsYW0xNkBnbWFpbC5jb20iLCJqdGkiOiIyMjIzNzUzNzIifQ.2TxRyE0qZH56EYmI-6ll98epIZWZrRmF-U9hUHWRcAg");
  UserCredential? userCredential;

  Future<UserCredential> signIn({required String email,required String password})async{
    log("Signing in");
    var response;
    try{
      var body={
        "email":email,
        "password":password
      };
      response = await my_api.post(jsonEncode(body),ApiUrls.signIn, {"Content-Type": "application/json"});
      log("signIn: Response code ${response!.statusCode}");
    }catch(e){
      log(e.toString());
      throw ("Unable to establish connection");
    }
    if(response!=null){
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final credential=userCredentialFromJson(response.body);
        userCredential=credential;
        notifyListeners();
        return credential;
      }else{
        log(response.body);
        String message=jsonDecode(response.body)['error'];
        throw Exception(message);
      }
    }else{
      throw ("Unable to establish connection");

    }

  }

  Future<UserCredential> signUp({required String email,required String password,required String phoneNo,required String countryCode})async{
    log("Registering user");
    var response;
    try{
      var body={
        "email":email,
        "phone_no":phoneNo,
        "country_code":countryCode,
        "password":password
      };
      response = await my_api.post(jsonEncode(body),ApiUrls.signUp, {"Content-Type": "application/json"});
      log("signIn: Response code ${response!.statusCode}");
    }catch(e){
      log(e.toString());
      throw ("Unable to establish connection");
    }
    if(response!=null){
      if(response.statusCode==200){
        final credential=userCredentialFromJson(response.body);
        userCredential=credential;
        notifyListeners();
        return credential;
      }else{
        log(response.body);
        String message=jsonDecode(response.body)['error'];
        throw Exception(message);
      }
    }else{
      throw ("Unable to establish connection");
    }

  }

  Future<void> passwordChangeOtp({required String email})async{
    log("Sending password reset otp to $email");
    try{
      var response = await my_api.get("${ApiUrls.passwordChangeOtp}?email=$email", {"Content-Type": "application/json"});
      log("signIn: Response code ${response!.statusCode}");
      if(response.statusCode==200){

      }else{
        log(response.body);
        throw Exception("Unable to send otp");
      }
    }catch(e){
      log(e.toString());
      throw (e.toString());
    }
  }

  Future<void> passwordChange({required String email,required String otp,required String newPassword})async{
    log("Changing password");
    try{
      var response = await my_api.get("${ApiUrls.passwordChange}?email=$email&otp=$otp&newPassword=$newPassword", {"Content-Type": "application/json"});
      log("signIn: Response code ${response!.statusCode}");
      if(response.statusCode==200){

      }else{
        log(response.body);
        final data=jsonDecode(response.body);
        throw Exception(data['error']);
      }
    }catch(e){
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}