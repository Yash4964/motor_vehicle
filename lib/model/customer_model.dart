import 'dart:convert';

class CustomerModel {
  String name;
  String email;
  String password;
  String mobileno;
  int age;
  String address;
  String pincode;
  String id;

  CustomerModel({
    required this.name,
    required this.email,
    required this.password,
    required this.mobileno,
    required this.age,
    required this.address,
    required this.pincode,
    required this.id,
  });

  factory CustomerModel.fromRawJson(String str) => CustomerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    name: json["name"],
    email: json["email"],
    password: json["password"] ?? "",
    mobileno: json["mobile_no"],
    age: json["age"],
    address: json["address"],
    pincode: json["pincode"],
    id: json["id"].toString(),
  );

  Map<String, dynamic> toJson() => {
  "name": name,
  "email": email,
  "password": password,
  "mobileno": mobileno,
  "age": age,
  "address": address,
  "pincode": pincode,
  "id":id,
  };
}