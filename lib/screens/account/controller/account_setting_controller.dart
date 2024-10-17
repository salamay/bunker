import 'dart:convert';
import 'dart:developer';

import 'package:bunker/screens/account/model/profile_model.dart';
import 'package:bunker/screens/account/payment_methods/model/payment_method_model.dart';
import 'package:bunker/screens/account/security/model/login_history.dart';
import 'package:flutter/cupertino.dart';

import '../../../api/my_api.dart';
import '../../../api/url/Api_url.dart';
import '../../../user/model/user_crendential.dart';

enum SettingType{
  general,notification,verification,security,payment
}
class AccountSettingController extends ChangeNotifier{
  final my_api = MyApi();
  ProfileModel? profileModel;
  List<LoginHistory> loginHistory=[];
  List<PaymentMethodModel> paymentMethods=[];
  bool authHistoryLoading=true;
  bool paymentMethodsLoading=true;
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

  Future<void> getAuthHistory({required UserCredential credential})async{
    log("Getting auth history");
    authHistoryLoading=true;
    notifyListeners();
    try{
      var response = await my_api.get(ApiUrls.authHistories, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Auth history: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        loginHistory=loginHistoryFromJson(response.body);
      }
      authHistoryLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("Unable to get auth histories");
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

  Future<void> getPaymentMethods({required UserCredential credential})async{
    log("Getting payment methods");
    paymentMethodsLoading=true;
    notifyListeners();
    try{
      var response = await my_api.get(ApiUrls.paymentMethods, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Payment method: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        paymentMethods=paymentMethodModelFromJson(response.body);

      }
      paymentMethodsLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("Unable to get payment methods");
    }
  }

  Future<void> addPaymentMethod({required UserCredential credential,required PaymentMethodModel paymentMethod})async{
    log("Adding payment method");
    try{
      var body= {
          "bank_name":paymentMethod.bankName,
          "account_name": paymentMethod.accountName,
          "account_number":paymentMethod.accountNumber,
          "routing_number":paymentMethod.routingNumber,
          "swift_code": paymentMethod.swiftCode,
          "note": paymentMethod.swiftCode
      };
      var response = await my_api.post(jsonEncode(body),ApiUrls.addPaymentMethod, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Adding method: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        paymentMethods.add(paymentMethod);
      }else{
        throw Exception();
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      throw Exception("Unable to get add payment method");
    }
  }

  Future<void> deletePaymentMethod({required UserCredential credential,required String id})async{
    log("Deleting payment method");
    try{
      paymentMethods.removeWhere((element) => element.id==id);
      notifyListeners();
      var response = await my_api.get("${ApiUrls.deletePaymentMethod}?id=$id", {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Deleting method: Response code ${response!.statusCode}");
      if(response.statusCode==200){

      }
      paymentMethodsLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("Unable to get delete payment method");
    }
  }
}