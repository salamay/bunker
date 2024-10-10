// To parse this JSON data, do
//
//     final withdrawalTicket = withdrawalTicketFromJson(jsonString);

import 'dart:convert';

List<WithdrawalTicket> withdrawalTicketFromJson(String str) => List<WithdrawalTicket>.from(json.decode(str).map((x) => WithdrawalTicket.fromJson(x)));

String withdrawalTicketToJson(List<WithdrawalTicket> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WithdrawalTicket {
  String? id;
  int? userId;
  String? email;
  DateTime? date;
  double? amount;
  String? status;
  String? walletName;
  String? walletId;

  WithdrawalTicket({
    this.id,
    this.userId,
    this.email,
    this.date,
    this.amount,
    this.status,
    this.walletName,
    this.walletId,
  });

  factory WithdrawalTicket.fromJson(Map<String, dynamic> json) => WithdrawalTicket(
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
