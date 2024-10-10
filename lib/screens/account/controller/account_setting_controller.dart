import 'dart:convert';
import 'dart:developer';

import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../api/my_api.dart';
import '../../../api/url/Api_url.dart';
import '../../../user/model/user_crendential.dart';

enum SettingType{
  general
}
class AccountSettingController extends ChangeNotifier{
  final my_api = MyApi();
  ProfileModel? profileModel;

  Future<void> getProfile({required UserCredential credential})async{
    log("Getting profile");
    try{
      var response = await my_api.get(ApiUrls.profile, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("profile: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final profile=profileModelFromJson(response.body);
        profileModel=profile;
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("Unable to get profile");
    }
  }

  Future<void> updateProfile({required UserCredential credential,required ProfileModel profile})async{
    log("Updating profile");
    try{
      var body=profileModelToJson(profile);
      var response = await my_api.post(body,ApiUrls.updateProfile, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Updating profile: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final profile=profileModelFromJson(response.body);
        profileModel=profile;
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("Unable to get profile");
    }
  }
}