// To parse this JSON data, do
//
//     final paymentMethodModel = paymentMethodModelFromJson(jsonString);

import 'dart:convert';

List<PaymentMethodModel> paymentMethodModelFromJson(String str) => List<PaymentMethodModel>.from(json.decode(str).map((x) => PaymentMethodModel.fromJson(x)));

String paymentMethodModelToJson(List<PaymentMethodModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMethodModel {
  String? id;
  int? userId;
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? routingNumber;
  String? swiftCode;
  String? note;

  PaymentMethodModel({
    this.id,
    this.userId,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.routingNumber,
    this.swiftCode,
    this.note,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => PaymentMethodModel(
    id: json["id"],
    userId: json["user_id"],
    bankName: json["bank_name"],
    accountName: json["account_name"],
    accountNumber: json["account_number"],
    routingNumber: json["routing_number"],
    swiftCode: json["swift_code"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "bank_name": bankName,
    "account_name": accountName,
    "account_number": accountNumber,
    "routing_number": routingNumber,
    "swift_code": swiftCode,
    "note": note,
  };
}
