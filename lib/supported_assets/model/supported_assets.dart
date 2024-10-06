

import '../network_constants.dart';
import 'CryptoData.dart';
import 'network_model.dart';

class SupportedCoin{
  String id;
  String symbol;
  String name;
  String image;
  String? wallet_address;
  String? private_key;
  List<QuoteElement>? quotes=[];
  NetworkModel? networkModel;
  int? decimal;
  CoinType? coinType;
  String? contractAddress;
  bool? isImplementedContract=false;
  String? implementationContractAddress;

  SupportedCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    this.quotes,
    this.wallet_address,
    this.private_key,
    this.networkModel,
    this.decimal,
    this.coinType,
    required this.contractAddress,
    this.isImplementedContract,
    this.implementationContractAddress
  });

  SupportedCoin copyWith({
    String? id,
    String? symbol,
    String? name,
    String? image,
    String? wallet_address,
    String? private_key,
    List<QuoteElement>? quotes,
    NetworkModel? networkModel,
    int? decimal,
    CoinType? coinType,
    String? contractAddress,
    bool? isImplementedContract,
    String? implementationContractAddress,
  }) {
    return SupportedCoin(
        id: id ?? this.id,
        symbol: symbol ?? this.symbol,
        name: name ?? this.name,
        image: image ?? this.image,
        quotes: quotes ?? this.quotes,
        wallet_address: wallet_address ?? this.wallet_address,
        private_key: private_key ?? this.private_key,
        networkModel: networkModel ?? this.networkModel,
        decimal: decimal ?? this.decimal,
        coinType: coinType??this.coinType,
        contractAddress: contractAddress??this.contractAddress,
        isImplementedContract: isImplementedContract??this.isImplementedContract,
        implementationContractAddress: implementationContractAddress??this.implementationContractAddress
    );
  }
}