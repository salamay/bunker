// To parse this JSON data, do
//
//     final marketQuote = marketQuoteFromJson(jsonString);

import 'dart:convert';

MarketQuote marketQuoteFromJson(String str) => MarketQuote.fromJson(json.decode(str));

String marketQuoteToJson(MarketQuote data) => json.encode(data.toJson());

class MarketQuote {
  List<QuoteElement>? quotes;

  MarketQuote({
    this.quotes,
  });

  factory MarketQuote.fromJson(Map<String, dynamic> json) => MarketQuote(
    quotes: json["quotes"] == null ? [] : List<QuoteElement>.from(json["quotes"]!.map((x) => QuoteElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quotes": quotes == null ? [] : List<dynamic>.from(quotes!.map((x) => x.toJson())),
  };
}

class QuoteElement {
  DateTime? timestamp;
  QuoteQuote? quote;

  QuoteElement({
    this.timestamp,
    this.quote,
  });

  factory QuoteElement.fromJson(Map<String, dynamic> json) => QuoteElement(
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    quote: json["quote"] == null ? null : QuoteQuote.fromJson(json["quote"]),
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp?.toIso8601String(),
    "quote": quote?.toJson(),
  };
}

class QuoteQuote {
  Usd? usd;

  QuoteQuote({
    this.usd,
  });

  factory QuoteQuote.fromJson(Map<String, dynamic> json) => QuoteQuote(
    usd: json["USD"] == null ? null : Usd.fromJson(json["USD"]),
  );

  Map<String, dynamic> toJson() => {
    "USD": usd?.toJson(),
  };
}

class Usd {
  num? price;
  num? volume24H;
  num? marketCap;
  num? circulatingSupply;
  num? totalSupply;
  DateTime? timestamp;

  Usd({
    this.price,
    this.volume24H,
    this.marketCap,
    this.circulatingSupply,
    this.totalSupply,
    this.timestamp,
  });

  factory Usd.fromJson(Map<String, dynamic> json) => Usd(
    price: json["price"]?.toDouble(),
    volume24H: json["volume_24h"],
    marketCap: json["market_cap"]?.toDouble(),
    circulatingSupply: json["circulating_supply"],
    totalSupply: json["total_supply"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "volume_24h": volume24H,
    "market_cap": marketCap,
    "circulating_supply": circulatingSupply,
    "total_supply": totalSupply,
    "timestamp": timestamp?.toIso8601String(),
  };
}
