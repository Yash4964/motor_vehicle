import 'dart:convert';

class PackageModel {
  String name;
  String vehicleid;
  int days;
  int km;
  int price;
  String id;

  PackageModel({
    required this.name,
    required this.vehicleid,
    required this.days,
    required this.km,
    required this.price,
    required this.id,
  });

  factory PackageModel.fromRawJson(String str) => PackageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    name: json["name"],
    vehicleid: json["vehicleid"],
    days: json["days"],
    km: json["km"],
    price: json["price"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "vehicleid": vehicleid,
    "days": days,
    "km": km,
    "price": price,
    "id": id,
  };
}
