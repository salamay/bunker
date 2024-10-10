// To parse this JSON data, do
//
//     final userCredential = userCredentialFromJson(jsonString);

import 'dart:convert';

UserCredential userCredentialFromJson(String str) => UserCredential.fromJson(json.decode(str));

String userCredentialToJson(UserCredential data) => json.encode(data.toJson());

class UserCredential {
  String? token;
  dynamic authType;

  UserCredential({
    this.token,
    this.authType,
  });

  factory UserCredential.fromJson(Map<String, dynamic> json) => UserCredential(
    token: json["token"],
    authType: json["auth_type"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "auth_type": authType,
  };
}
