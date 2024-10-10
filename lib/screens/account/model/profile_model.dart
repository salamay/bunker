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
  dynamic firstName;
  dynamic lastName;
  dynamic dob;
  dynamic country;
  dynamic state;
  dynamic city;

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
  };
}
