import 'dart:convert';

class PackageModel {
  String name;
  String vehicle_id;
  int days;
  int km;
  String price;
  String id;

  PackageModel({
    required this.name,
    required this.vehicle_id,
    required this.days,
    required this.km,
    required this.price,
    required this.id,
  });

  factory PackageModel.fromRawJson(String str) => PackageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
    name: json["name"] ?? "",
    vehicle_id: json["vehicle_id"].toString() ?? "",
    days: int.tryParse(json["days"].toString()) ?? 0,
    km: int.tryParse(json["km"].toString()) ?? 0,
    price: json["price"].toString(),
    id: json["id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "vehicle_id": vehicle_id,
    "days": days,
    "km": km,
    "price": price,
    "id": id,
  };
}
