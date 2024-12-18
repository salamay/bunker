import 'dart:convert';
import 'dart:developer';

import 'package:bunker/screens/transaction/model/withrawal.dart';
import 'package:flutter/cupertino.dart';
import '../../../api/my_api.dart';
import '../../../api/url/Api_url.dart';
import '../../../user/model/user_crendential.dart';
import '../model/withdrawal_ticket.dart';


const String pending="Pending";
const String rejected="Rejected";
const String approved="Approved";

class WithdrawalController extends ChangeNotifier{
  final my_api = MyApi();
  List<WithdrawalTicket> withdrawalTickets=[];
  bool withdrawalLoading=true;


  Future<void> getWithdrawals({required UserCredential credential})async{
    log("Getting withdrawals");
    try{
      var response = await my_api.get(ApiUrls.userWithdrawals, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Getting withdrawals: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final tickets=withdrawalTicketFromJson(response.body);
        withdrawalTickets=tickets;
      }
      withdrawalLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      withdrawalLoading=false;
      notifyListeners();
      throw Exception("Unable to get withdrawals");
    }
  }

  Future<void> createWithdrawalTicket({required UserCredential credential,required double amount,required String walletId})async{
    log("Creating withdrawal ticket");
    var response;
    try{
      response = await my_api.get("${ApiUrls.withdraw}?amount=$amount&walletId=$walletId", {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Creating withdrawal ticket: Response code ${response!.statusCode}");
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
    }
    if(response!=null){
      if(response.statusCode==200){
        final withdrawal=withdrawalFromJson(response.body);
        withdrawalTickets.add(
            WithdrawalTicket(
                id: withdrawal.id,
                userId: withdrawal.userId,
                email: withdrawal.email,
                amount: withdrawal.amount,
                status: withdrawal.status,
                walletId: withdrawal.walletId,
                date: withdrawal.date,
                walletName: withdrawal.walletName
            )
        );
      }else{
        String message=jsonDecode(response.body)['error'];
        throw Exception(message);
      }
    }else{
      throw ("Unable to establish connection");
    }
  }
}