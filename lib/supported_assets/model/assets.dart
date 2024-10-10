// To parse this JSON data, do
//
//     final assetModel = assetModelFromJson(jsonString);

import 'dart:convert';

import 'CryptoData.dart';

List<AssetModel> assetModelFromJson(String str) => List<AssetModel>.from(json.decode(str).map((x) => AssetModel.fromJson(x)));

String assetModelToJson(List<AssetModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssetModel {
  String? id;
  int? userId;
  String? mnemonic;
  String? address;
  String? name;
  String? symbol;
  String? image;
  String? marketId;
  double? balance;
  List<QuoteElement>? quotes=[];

  AssetModel({
    this.id,
    this.userId,
    this.mnemonic,
    this.address,
    this.name,
    this.symbol,
    this.image,
    this.marketId,
    this.balance,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
    id: json["id"],
    userId: json["user_id"],
    mnemonic: json["mnemonic"],
    address: json["address"],
    name: json["name"],
    symbol: json["symbol"],
    image: json["image"],
    marketId: json["market_id"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "mnemonic": mnemonic,
    "address": address,
    "name": name,
    "symbol": symbol,
    "image": image,
    "market_id": marketId,
    "balance": balance,
  };
}
