// To parse this JSON data, do
//
//     final ticketMessage = ticketMessageFromJson(jsonString);

import 'dart:convert';

TicketMessage ticketMessageFromJson(String str) => TicketMessage.fromJson(json.decode(str));

String ticketMessageToJson(TicketMessage data) => json.encode(data.toJson());

class TicketMessage {
  String? id;
  int? senderUid;
  String? senderEmail;
  String? message;
  String? ticketId;
  DateTime? createdAt;
  int? receiverUid;
  bool? isMedia;
  String? imageUrl;

  TicketMessage({
    this.id,
    this.senderUid,
    this.senderEmail,
    this.message,
    this.ticketId,
    this.createdAt,
    this.receiverUid,
    this.isMedia,
    this.imageUrl,
  });

  factory TicketMessage.fromJson(Map<String, dynamic> json) => TicketMessage(
    id: json["id"],
    senderUid: json["sender_uid"],
    senderEmail: json["sender_email"],
    message: json["message"],
    ticketId: json["ticket_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    receiverUid: json["receiver_uid"],
    isMedia: json["is_media"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_uid": senderUid,
    "sender_email": senderEmail,
    "message": message,
    "ticket_id": ticketId,
    "created_at": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
    "receiver_uid": receiverUid,
    "is_media": isMedia,
    "image_url": imageUrl,
  };
}
