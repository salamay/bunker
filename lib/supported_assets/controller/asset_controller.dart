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
  bool assetLoading=false;
  Map<String, CoinBalance> balances = {};
  double overallBalance = 0;
  List<AssetModel> supportedCoin=[];
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
    calculateTotalBalance();
  }

  Future<void> getMarketQuotesHistorical(String time_start,String time_end,String interval)async {
    log("Getting historical market quotes");
    await Future.wait(supportedCoin.map((e)async{
      try {
        Uri uri=Uri.parse(ApiUrls.quoteHistorical);
        Uri finalUri=uri.replace(
            queryParameters: {
              "id":ids,
              "time_start":time_start,
              "time_end":time_end,
              "interval":interval
            });
        var response = await my_api.get(finalUri.toString(), {
          "Content-Type": "application/json",
          "X-CMC_PRO_API_KEY":MyApi.coinMarketCapKey});
        log("Historical market quotes: Response code ${response!.statusCode}");
        if (response.statusCode == 200) {
          final data=jsonDecode(response.body);
          final marketQuote = marketQuoteFromJson(jsonEncode(data["data"][e.marketId]));
          AssetModel asset=supportedCoin.where((element) => element.id==e.id).first;
          int index=supportedCoin.indexWhere((element) => element.id==e.id);
          asset.quotes=marketQuote.quotes!;
          AssetModel newData=asset;
          supportedCoin[index]=newData;
          notifyListeners();
        } else {
          String message = jsonDecode(response.body)['status']["error_message"];
          log(message);
        }
      } catch (e) {
        log(e.toString());
      }
    }).toList());
  }

  Future<void> getAssets({required UserCredential credential})async{
    log("Getting assets");
    try{
      assetLoading=true;
      resetOverallBalance();
      notifyListeners();
      var response = await my_api.get("${ApiUrls.baseUrl}/wallets", {"Content-Type": "application/json","Authorization":"Bearer ${credential.token}"});
      log("Assets: Response code ${response!.statusCode}");
      if(response.statusCode==200){
        final assets=assetModelFromJson(response.body);
        supportedCoin=assets;
        colors=[];
        supportedCoin.map((e){
          CoinBalance coinBalance = CoinBalance(balanceInCrypto: e.balance!, balanceInFiat: e.balance!);
          balances[e.id!]=coinBalance;
          calculateTotalBalance();
          List<Color> c = [Colors.red, primary_color_button, Colors.blue, Colors.purple, Colors.green, Colors.orange,  Colors.greenAccent, Colors.blueAccent,Colors.amberAccent, Colors.cyanAccent, Colors.deepPurpleAccent, Colors.deepOrangeAccent, Colors.limeAccent, Colors.lightBlueAccent, Colors.lightGreenAccent, Colors.brown, Colors.grey, Colors.blueGrey, Colors.cyanAccent, Colors.deepPurpleAccent, Colors.deepOrangeAccent, Colors.limeAccent,];
          math.Random random = math.Random();
          Color randomColor = c[random.nextInt(c.length)];
          colors.add(randomColor);
        }).toList();
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