import 'crypto_constants.dart';
import 'model/network_model.dart';

enum CoinType{
  TOKEN,COIN,NATIVE_TOKEN,WRAPPED_TOKEN
}
enum ChainUnit{
  satoshi,ethers,wei,matic
}

String bsc = "Binance Smart Chain";
String ethereum = "Ethereum";
String ids="4687,1839,825,3408,74,11419,1975,7083,3890,3773,4943,7186,1839,7192";
NetworkModel chain_bsc = NetworkModel(chain_name: bsc, image_url: "https://cryptologos.cc/logos/bnb-bnb-logo.png?v=032", chain_id: 56 ,chain_symbol: "BSC",unit: ChainUnit.satoshi.name,chain_currency: bnb,nativeCoinId: "1839",scanUrl: "https://bscscan.com/",scanName: "BscScan",minimumCurrency: 0.001);
NetworkModel chain_eth= NetworkModel(chain_name: bsc, image_url: "https://cryptologos.cc/logos/ethereum-eth-logo.png?v=032", chain_id: 1, chain_symbol: eth,unit: ChainUnit.ethers.name,chain_currency: ethereum,nativeCoinId: "1027",scanUrl: "https://etherscan.io/",scanName: "Etherscan",minimumCurrency: 0.003);

