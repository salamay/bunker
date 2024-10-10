import 'dart:developer';

import 'package:bunker/screens/transaction/controller/withrawal_controller.dart';
import 'package:bunker/screens/transaction/model/withrawal.dart';
import 'package:flutter/cupertino.dart';

import '../../../api/my_api.dart';
import '../../../api/url/Api_url.dart';
import '../../../user/model/user_crendential.dart';
import '../../transaction/model/withdrawal_ticket.dart';

class AdminController extends ChangeNotifier{

  final my_api = MyApi();
  List<WithdrawalTicket> withdrawalTickets=[];

  Future<void> getTickets({required UserCredential credential})async{
    log("(Admin) Getting all ticket");
    try{
      var response = await my_api.get(ApiUrls.withdrawTickets, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("(Admin) Getting all ticket: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final tickets=withdrawalTicketFromJson(response.body);
        withdrawalTickets=tickets;
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("(Admin) Unable to get ticket");
    }
  }

  Future<void> approveWithdrawal({required UserCredential credential,required String withdrawalId})async{
    log("(Admin) Approving withdrawal ticket");
    log(withdrawalId);
    try{
      var response = await my_api.get("${ApiUrls.approveWithdrawal}?withdrawalId=$withdrawalId", {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("(Admin) Approving withdrawal ticket: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        WithdrawalTicket ticket=withdrawalTickets.firstWhere((element) => element.id==withdrawalId);
        int index=withdrawalTickets.indexOf(ticket);
        withdrawalTickets[index]=WithdrawalTicket(
          id: ticket.id,
          userId: ticket.userId,
          email: ticket.email,
          walletId: ticket.walletId,
          amount: ticket.amount,
          walletName: ticket.walletName,
          status: approved,
          date: ticket.date,
        );
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("(Admin) Unable to approve ticket");
    }
  }


  Future<void> rejectWithdrawal({required UserCredential credential,required String withdrawalId})async{
    log("(Admin) Rejecting withdrawal ticket");
    log(withdrawalId);
    try{
      var response = await my_api.get("${ApiUrls.rejectWithdrawal}?withdrawalId=$withdrawalId", {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("(Admin) Rejecting withdrawal ticket: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        WithdrawalTicket ticket=withdrawalTickets.firstWhere((element) => element.id==withdrawalId);
        int index=withdrawalTickets.indexOf(ticket);
        withdrawalTickets[index]=WithdrawalTicket(
          id: ticket.id,
          userId: ticket.userId,
          email: ticket.email,
          walletId: ticket.walletId,
          amount: ticket.amount,
          walletName: ticket.walletName,
          status: rejected,
          date: ticket.date,
        );
      }
      notifyListeners();
    }catch(e){
      log(e.toString());
      notifyListeners();
      throw Exception("(Admin) Unable to reject ticket");
    }
  }
}