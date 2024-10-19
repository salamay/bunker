// To parse this JSON data, do
//
//     final supportTicket = supportTicketFromJson(jsonString);

import 'dart:convert';

List<SupportTicket> supportTicketFromJson(String str) => List<SupportTicket>.from(json.decode(str).map((x) => SupportTicket.fromJson(x)));

String supportTicketToJson(List<SupportTicket> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportTicket {
  String? id;
  int? userId;
  String? email;
  String? subject;
  String? message;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  SupportTicket({
    this.id,
    this.userId,
    this.email,
    this.subject,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory SupportTicket.fromJson(Map<String, dynamic> json) => SupportTicket(
    id: json["id"],
    userId: json["user_id"],
    email: json["email"],
    subject: json["subject"],
    message: json["message"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "email": email,
    "subject": subject,
    "message": message,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
