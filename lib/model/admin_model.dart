import 'dart:convert';

class AdminModel {
  String name;
  String email;
  String password;
  String id;

  AdminModel({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
  });

  factory AdminModel.fromRawJson(String str) => AdminModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
  "name": name,
  "email": email,
  "password": password,
  "id":id
  };
}