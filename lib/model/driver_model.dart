import 'dart:convert';

class DriverModel {
  String name;
  String email;
  String password;
  int mobileno;
  int age;
  String address;
  String licenceno;
  String id;

  DriverModel({
    required this.name,
    required this.email,
    required this.password,
    required this.mobileno,
    required this.age,
    required this.address,
    required this.licenceno,
    required this.id,
  });

  factory DriverModel.fromRawJson(String str) => DriverModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    mobileno: json["mobileno"],
    age: json["age"],
    address: json["address"],
    licenceno: json["licenceno"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "mobileno": mobileno,
    "age": age,
    "address": address,
    "licenceno": licenceno,
    "id": id,
  };
}