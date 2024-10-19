import 'dart:convert';
import 'dart:developer';

import 'package:bunker/user/model/user_crendential.dart';
import 'package:flutter/cupertino.dart';

import '../../api/my_api.dart';
import '../../api/url/Api_url.dart';

class UserController extends ChangeNotifier{
  final my_api = MyApi();
  UserCredential? userCredential=UserCredential(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJheW90dW5kZXNhbGFtMTZAZ21haWwuY29tIiwiaWF0IjoxNzI5MjY2NDg2LCJleHAiOjE3NjA3MTYwODYsImF1ZCI6ImF5b3R1bmRlc2FsYW0xNkBnbWFpbC5jb20iLCJqdGkiOiI0MjM0MTQ2MTcifQ.XCbxNZ189vNb-6aoMsW5Q97OqvchIY0cuWNG7PAKxO4");
  // UserCredential? userCredential;

  Future<UserCredential> signIn({required String email,required String password})async{
    log("Signing in");
    try{
      var body={
        "email":email,
        "password":password
      };
      var response = await my_api.post(jsonEncode(body),ApiUrls.signIn, {"Content-Type": "application/json"});
      log("signIn: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final data=jsonDecode(response.body);
        final credential=userCredentialFromJson(response.body);
        userCredential=credential;
        notifyListeners();
        return credential;
      }else{
        log(response.body);
        throw Exception("Unable to sign in");
      }
    }catch(e){
      log(e.toString());
      throw (e.toString());
    }
  }
}