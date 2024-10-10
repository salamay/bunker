// To parse this JSON data, do
//
//     final withdrawal = withdrawalFromJson(jsonString);

import 'dart:convert';

Withdrawal withdrawalFromJson(String str) => Withdrawal.fromJson(json.decode(str));

String withdrawalToJson(Withdrawal data) => json.encode(data.toJson());

class Withdrawal {
  String? id;
  int? userId;
  String? email;
  DateTime? date;
  double? amount;
  String? status;
  String? walletName;
  String? walletId;

  Withdrawal({
    this.id,
    this.userId,
    this.email,
    this.date,
    this.amount,
    this.status,
    this.walletName,
    this.walletId,
  });

  factory Withdrawal.fromJson(Map<String, dynamic> json) => Withdrawal(
    id: json["id"],
    userId: json["user_id"],
    email: json["email"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    amount: json["amount"],
    status: json["status"],
    walletName: json["wallet_name"],
    walletId: json["wallet_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "email": email,
    "date": date?.toIso8601String(),
    "amount": amount,
    "status": status,
    "wallet_name": walletName,
    "wallet_id": walletId,
  };
}
