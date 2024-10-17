// To parse this JSON data, do
//
//     final loginHistory = loginHistoryFromJson(jsonString);

import 'dart:convert';

List<LoginHistory> loginHistoryFromJson(String str) => List<LoginHistory>.from(json.decode(str).map((x) => LoginHistory.fromJson(x)));

String loginHistoryToJson(List<LoginHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginHistory {
  String? id;
  int? userId;
  DateTime? loginTime;
  String? ipAddress;
  String? device;

  LoginHistory({
    this.id,
    this.userId,
    this.loginTime,
    this.ipAddress,
    this.device,
  });

  factory LoginHistory.fromJson(Map<String, dynamic> json) => LoginHistory(
    id: json["id"],
    userId: json["user_id"],
    loginTime: json["login_time"] == null ? null : DateTime.parse(json["login_time"]),
    ipAddress: json["ip_address"],
    device: json["device"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "login_time": loginTime?.toIso8601String(),
    "ip_address": ipAddress,
    "device": device,
  };
}
