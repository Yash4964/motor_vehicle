import 'dart:convert';

class AdminModel {
  String email;
  String password;

  AdminModel({
    required this.email,
    required this.password,
  });

  factory AdminModel.fromRawJson(String str) => AdminModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
