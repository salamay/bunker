import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../api/my_api.dart';
import '../../api/url/Api_url.dart';
import '../crypto_constants.dart';
import '../model/CryptoData.dart';
import '../model/supported_assets.dart';
import '../network_constants.dart';

class AssetController extends ChangeNotifier{
  final my_api = MyApi();

  List<SupportedCoin> supportedCoin=[
    // SupportedCoin(id: "4687",name: COIN_FGRID,symbol: fgrid,image: "https://res.cloudinary.com/djwu7p6ti/image/upload/v1723042511/ic_launcher_qb8djy.png",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 10,contractAddress: fgrid_contract),
    //BNB has wrapped contract address
    SupportedCoin(id: "1839",name: COIN_BINANCE_COIN,symbol: bnb,image: "https://cryptologos.cc/logos/bnb-bnb-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.NATIVE_TOKEN,decimal: 18,contractAddress: wrapped_bnb_contract),
    SupportedCoin(id: "825",name: COIN_TETHER,symbol: usdt,image: "https://cryptologos.cc/logos/tether-usdt-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: usdt_contract),
    SupportedCoin(id: "3408",name: COIN_USDC,symbol: usdc,image: "https://cryptologos.cc/logos/usd-coin-usdc-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: usdc_contract),
    // SupportedCoin(id: "74",name: COIN_DOGE,symbol: doge,image: "https://cryptologos.cc/logos/dogecoin-doge-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 8,contractAddress: doge_contract),
    // SupportedCoin(id: "11419",name: COIN_TONCOIN,symbol: ton,image: "https://cryptologos.cc/logos/toncoin-ton-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: ton_contract),
    // // SupportedCoin(id: "5994",name: COIN_SHIBA,symbol: shib,image: "https://cryptologos.cc/logos/shiba-inu-shib-logo.png?v=032",wallet_address: "",networkModel: chain_eth),
    SupportedCoin(id: "7192",name: W_COIN_BINANCE_COIN,symbol: wbnb,image: "https://cryptologos.cc/logos/bnb-bnb-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.WRAPPED_TOKEN,decimal: 18,contractAddress: wrapped_bnb_contract),
    // SupportedCoin(id: "1975",name: COIN_CHAINLINK,symbol: link,image: "https://cryptologos.cc/logos/chainlink-link-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: link_contract),
    // SupportedCoin(id: "7083",name: COIN_UNISWAP,symbol: uni,image: "https://cryptologos.cc/logos/uniswap-uni-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: uni_contract),
    // SupportedCoin(id: "3890",name: COIN_POLYGON,symbol: matic,image: "https://cryptologos.cc/logos/polygon-matic-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: matic_contract),
    // // SupportedCoin(id: "24478",name: COIN_PEPE,symbol: pepe,image: "https://cryptologos.cc/logos/pepe-pepe-logo.png?v=032",wallet_address: "",networkModel: chain_eth),
    // SupportedCoin(id: "3773",name: COIN_FETCH_AI,symbol: fet,image: "https://cryptologos.cc/logos/fetch-fet-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: fet_contract),
    // SupportedCoin(id: "4943",name: COIN_DAI,symbol: dai,image: "https://cryptologos.cc/logos/multi-collateral-dai-dai-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: dai_contract),
    // SupportedCoin(id: "7186",name: COIN_PANCAKESWAP,symbol: cake,image: "https://cryptologos.cc/logos/pancakeswap-cake-logo.png?v=032",wallet_address: "",networkModel: chain_bsc,coinType: CoinType.TOKEN,decimal: 18,contractAddress: cake_contract),
  ];

  Future<void> getMarketQuotesHistorical(String time_start,String time_end,String interval)async {
    log("Getting historical market quotes");
    await Future.wait(supportedCoin.map((e)async{
      try {
        Uri uri=Uri.parse(ApiUrls.quoteHistorical);
        Uri finalUri=uri.replace(
            queryParameters: {
              "id":e.id,
              "time_start":time_start,
              "time_end":time_end,
              "interval":interval
            });
        var response = await my_api.get(finalUri.toString(), {"Content-Type": "application/json","X-CMC_PRO_API_KEY":MyApi.coinMarketCapKey});
        log("Historical market quotes: Response code ${response!.statusCode}");
        if (response.statusCode == 200) {
          final data=jsonDecode(response.body);
          final marketQuote = marketQuoteFromJson(jsonEncode(data["data"][e.id]));
          SupportedCoin asset=supportedCoin.where((element) => element.id==e.id).first;
          int index=supportedCoin.indexWhere((element) => element.id==e.id);
          SupportedCoin newData=asset.copyWith(quotes: marketQuote.quotes!);
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
}