// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

List<TransactionModel> transactionModelFromJson(String str) => List<TransactionModel>.from(json.decode(str).map((x) => TransactionModel.fromJson(x)));

String transactionModelToJson(List<TransactionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionModel {
  String? id;
  int? receiverId;
  String? walletId;
  int? senderId;
  String? type;
  int? amount;
  String? status;
  DateTime? date;
  String? walletName;
  String? walletSymbol;

  TransactionModel({
    this.id,
    this.receiverId,
    this.walletId,
    this.senderId,
    this.type,
    this.amount,
    this.status,
    this.date,
    this.walletName,
    this.walletSymbol,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    id: json["id"],
    receiverId: json["receiver_id"],
    walletId: json["wallet_id"],
    senderId: json["sender_id"],
    type: json["type"],
    amount: json["amount"],
    status: json["status"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    walletName: json["wallet_name"],
    walletSymbol: json["wallet_symbol"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "receiver_id": receiverId,
    "wallet_id": walletId,
    "sender_id": senderId,
    "type": type,
    "amount": amount,
    "status": status,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "wallet_name": walletName,
    "wallet_symbol": walletSymbol,
  };
}
