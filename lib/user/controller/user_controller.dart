import 'dart:convert';
import 'dart:developer';

import 'package:bunker/user/model/user_crendential.dart';
import 'package:flutter/cupertino.dart';

import '../../api/my_api.dart';
import '../../api/url/Api_url.dart';

class UserController extends ChangeNotifier{
  final my_api = MyApi();
  UserCredential? userCredential=UserCredential(token: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJheW90dW5kZXNhbGFtMTZAZ21haWwuY29tIiwiaWF0IjoxNzI4NTIyOTkzLCJleHAiOjE3NTk5NzI1OTMsImF1ZCI6ImF5b3R1bmRlc2FsYW0xNkBnbWFpbC5jb20iLCJqdGkiOiI3ODQxMjE1MyJ9.Ohv-ifa2F5ld9RJOWqP3ajYR6j2aLdE2DiN5SEZ4wc8");
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