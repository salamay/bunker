// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? userId;
  String? email;
  DateTime? joinedAt;
  String? roles;
  String? firstName;
  String? lastName;
  dynamic dob;
  String? country;
  String? state;
  String? city;
  String? address;
  dynamic imageUrl;
  bool? isTxSent;
  bool? isTxReceived;
  bool? is2FaEnabled;
  bool? basicDetailsUpdated;
  bool? kycEnabled;

  ProfileModel({
    this.userId,
    this.email,
    this.joinedAt,
    this.roles,
    this.firstName,
    this.lastName,
    this.dob,
    this.country,
    this.state,
    this.city,
    this.address,
    this.imageUrl,
    this.isTxSent,
    this.isTxReceived,
    this.is2FaEnabled,
    this.basicDetailsUpdated,
    this.kycEnabled,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    userId: json["user_id"],
    email: json["email"],
    joinedAt: json["joined_at"] == null ? null : DateTime.parse(json["joined_at"]),
    roles: json["roles"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    dob: json["dob"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    address: json["address"],
    imageUrl: json["image_url"],
    isTxSent: json["is_tx_sent"],
    isTxReceived: json["is_tx_received"],
    is2FaEnabled: json["is2faEnabled"],
    basicDetailsUpdated: json["basicDetailsUpdated"],
    kycEnabled: json["kycEnabled"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email": email,
    "joined_at": joinedAt?.toIso8601String(),
    "roles": roles,
    "first_name": firstName,
    "last_name": lastName,
    "dob": dob,
    "country": country,
    "state": state,
    "city": city,
    "address": address,
    "image_url": imageUrl,
    "is_tx_sent": isTxSent,
    "is_tx_received": isTxReceived,
    "is2faEnabled": is2FaEnabled,
    "basicDetailsUpdated": basicDetailsUpdated,
    "kycEnabled": kycEnabled,
  };
}
