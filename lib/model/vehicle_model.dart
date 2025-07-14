import 'dart:convert';

class VehicleModel {
  String name;
  String carno;
  String modelno;
  String color;
  String description;
  String id;

  VehicleModel({
    required this.name,
    required this.carno,
    required this.modelno,
    required this.color,
    required this.description,
    required this.id,
  });

  factory VehicleModel.fromRawJson(String str) => VehicleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    name: json["name"],
    carno: json["carno"],
    modelno: json["modelno"],
    color: json["color"],
    description: json["description"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "carno": carno,
    "modelno": modelno,
    "color": color,
    "description": description,
    "id": id,
  };
}
