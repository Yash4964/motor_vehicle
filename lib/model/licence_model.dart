import 'dart:convert';

class LicencesModel {
  int id;
  String name;
  String price;
  String description;

  LicencesModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory LicencesModel.fromRawJson(String str) => LicencesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LicencesModel.fromJson(Map<String, dynamic> json) => LicencesModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
  };
}
