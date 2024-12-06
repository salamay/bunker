import 'dart:convert';
import 'dart:developer';

import 'package:bunker/screens/transaction/model/withdrawal_ticket.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:bunker/user/model/user_crendential.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/my_api.dart';
import '../../api/url/Api_url.dart';
import '../../balance/model/CoinBalance.dart';
import '../../components/app_component.dart';
import '../crypto_constants.dart';
import '../model/CryptoData.dart';
import '../network_constants.dart';
import 'dart:math' as math;

class AssetController extends ChangeNotifier{
  final my_api = MyApi();
  bool assetLoading=true;
  bool marketDataLoading=true;
  Map<String, CoinBalance> balances = {};
  double overallBalance = 0;
  List<AssetModel> supportedCoin=[];
  Map<String,List<QuoteElement>> quotes={};
  List<Color> colors = [];


  void calculateTotalBalance() {
    overallBalance = 0;
    balances.forEach((key, value) {
      overallBalance += balances[key]!.balanceInFiat;
      notifyListeners();
    });
  }

  void resetOverallBalance() {
    overallBalance = 0;
  }
  void deductBalance(String id,double amount){
    balances[id]!.balanceInFiat-=amount;
    overallBalance-=amount;
    notifyListeners();
  }

  Future<void> getMarketQuotesHistorical(UserCredential credential,String time_start,String time_end,String interval)async {
    try{
      log("Getting historical market quotes");
      if(supportedCoin.isEmpty){
        return;
      }
      Uri uri=Uri.parse(ApiUrls.quoteHistorical);
      String ids=supportedCoin.map((e) => e.marketId).join(",");
      Uri finalUri=uri.replace(
          queryParameters: {
            "ids":ids,
            "time_start":time_start,
            "time_end":time_end,
            "interval":interval
          });
      var response = await my_api.get(finalUri.toString(), {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Historical market quotes: Response code ${response!.statusCode}");
      if (response.statusCode == 200) {
        final marketQuote = marketQuoteFromJson(response.body);
        log(marketQuote.first.quotes!.length.toString());
        for (int i=0;i<marketQuote.length;i++) {
          // AssetModel asset=supportedCoin[i];
          // asset.quotes=marketQuote[i].quotes!;
          // AssetModel newData=asset;
          // supportedCoin[i]=newData;
          quotes[supportedCoin[i].marketId!]=marketQuote[i].quotes!;
          notifyListeners();
        }
      } else {

      }
      marketDataLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      marketDataLoading=false;
      notifyListeners();
      throw Exception("Unable to get market quotes");
    }
  }

  Future<void> getAssets({required UserCredential credential})async{
    log("Getting assets");
    try{
      assetLoading=true;
      var response = await my_api.get("${ApiUrls.baseUrl}/wallets", {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Assets: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        resetOverallBalance();
        final assets=assetModelFromJson(response.body);
        supportedCoin=assets;
        colors=[];
        notifyListeners();
        await Future.wait(supportedCoin.map((e)async{
          CoinBalance coinBalance = CoinBalance(balanceInCrypto: e.balance!, balanceInFiat: e.balance!);
          balances[e.id!]=coinBalance;
          calculateTotalBalance();
          List<Color> c = [Colors.red, primary_color_button, Colors.blue, Colors.purple, Colors.green, Colors.orange,  Colors.greenAccent, Colors.blueAccent,Colors.amberAccent, Colors.cyanAccent, Colors.deepPurpleAccent, Colors.deepOrangeAccent, Colors.limeAccent, Colors.lightBlueAccent, Colors.lightGreenAccent, Colors.brown, Colors.grey, Colors.blueGrey, Colors.cyanAccent, Colors.deepPurpleAccent, Colors.deepOrangeAccent, Colors.limeAccent,];
          math.Random random = math.Random();
          Color randomColor = c[random.nextInt(c.length)];
          colors.add(randomColor);
        }).toList());
        assetLoading=false;
        notifyListeners();
      }
      assetLoading=false;
      notifyListeners();
    }catch(e){
      log(e.toString());
      assetLoading=false;
      notifyListeners();
      throw Exception("Unable to get assets");
    }
  }


}