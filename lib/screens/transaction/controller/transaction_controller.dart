import 'dart:developer';

import 'package:bunker/screens/transaction/model/transaction_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../api/my_api.dart';
import '../../../api/url/Api_url.dart';
import '../../../user/model/user_crendential.dart';
enum TxPage{
  deposit,
  withdrawal
}
class TransactionController extends ChangeNotifier{

  final my_api = MyApi();
  List<TransactionModel> transactions = [];
  bool transactionLoading=true;


  Future<void> getTransactions({required UserCredential credential})async{
    log("Getting transactions");
    try{
      transactionLoading=true;
      var response = await my_api.get(ApiUrls.transactions, {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Getting transactions: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final tickets=transactionModelFromJson(response.body);
        transactions=tickets;
        log(transactions.length.toString());
      }
      transactionLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      transactionLoading=false;
      throw Exception("Unable to get transactions");
    }
  }
}