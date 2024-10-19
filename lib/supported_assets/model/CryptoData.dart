// To parse this JSON data, do
//
//     final marketQuote = marketQuoteFromJson(jsonString);

import 'dart:convert';

List<MarketQuote> marketQuoteFromJson(String str) => List<MarketQuote>.from(json.decode(str).map((x) => MarketQuote.fromJson(x)));

String marketQuoteToJson(List<MarketQuote> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarketQuote {
  String? symbol;
  int? isActive;
  String? name;
  int? id;
  int? isFiat;
  List<QuoteElement>? quotes;

  MarketQuote({
    this.symbol,
    this.isActive,
    this.name,
    this.id,
    this.isFiat,
    this.quotes,
  });

  factory MarketQuote.fromJson(Map<String, dynamic> json) => MarketQuote(
    symbol: json["symbol"],
    isActive: json["isActive"],
    name: json["name"],
    id: json["id"],
    isFiat: json["isFiat"],
    quotes: json["quotes"] == null ? [] : List<QuoteElement>.from(json["quotes"]!.map((x) => QuoteElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "isActive": isActive,
    "name": name,
    "id": id,
    "isFiat": isFiat,
    "quotes": quotes == null ? [] : List<dynamic>.from(quotes!.map((x) => x.toJson())),
  };
}

class QuoteElement {
  QuoteQuote? quote;
  DateTime? timestamp;

  QuoteElement({
    this.quote,
    this.timestamp,
  });

  factory QuoteElement.fromJson(Map<String, dynamic> json) => QuoteElement(
    quote: json["quote"] == null ? null : QuoteQuote.fromJson(json["quote"]),
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "quote": quote?.toJson(),
    "timestamp": timestamp?.toIso8601String(),
  };
}

class QuoteQuote {
  Usd? usd;

  QuoteQuote({
    this.usd,
  });

  factory QuoteQuote.fromJson(Map<String, dynamic> json) => QuoteQuote(
    usd: json["usd"] == null ? null : Usd.fromJson(json["usd"]),
  );

  Map<String, dynamic> toJson() => {
    "usd": usd?.toJson(),
  };
}

class Usd {
  double? percentChange30D;
  double? circulatingSupply;
  double? percentChange1H;
  double? percentChange24H;
  double? marketCap;
  double? totalSupply;
  double? price;
  double? volume24H;
  double? percentChange7D;
  DateTime? timestamp;

  Usd({
    this.percentChange30D,
    this.circulatingSupply,
    this.percentChange1H,
    this.percentChange24H,
    this.marketCap,
    this.totalSupply,
    this.price,
    this.volume24H,
    this.percentChange7D,
    this.timestamp,
  });

  factory Usd.fromJson(Map<String, dynamic> json) => Usd(
    percentChange30D: json["percentChange30d"]?.toDouble(),
    circulatingSupply: json["circulatingSupply"]?.toDouble(),
    percentChange1H: json["percentChange1h"]?.toDouble(),
    percentChange24H: json["percentChange24h"]?.toDouble(),
    marketCap: json["marketCap"]?.toDouble(),
    totalSupply: json["totalSupply"]?.toDouble(),
    price: json["price"]?.toDouble(),
    volume24H: json["volume24h"]?.toDouble(),
    percentChange7D: json["percentChange7d"]?.toDouble(),
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "percentChange30d": percentChange30D,
    "circulatingSupply": circulatingSupply,
    "percentChange1h": percentChange1H,
    "percentChange24h": percentChange24H,
    "marketCap": marketCap,
    "totalSupply": totalSupply,
    "price": price,
    "volume24h": volume24H,
    "percentChange7d": percentChange7D,
    "timestamp": timestamp?.toIso8601String(),
  };
}
