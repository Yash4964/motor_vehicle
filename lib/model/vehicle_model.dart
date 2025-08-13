import 'dart:convert';

class VehicleModel {
  String name;
  String carno;
  String modelno;
  String color;
  String description;
  String id;
  String image;

  VehicleModel({
    required this.name,
    required this.carno,
    required this.modelno,
    required this.color,
    required this.description,
    required this.id,
    required this.image,
  });

  factory VehicleModel.fromRawJson(String str) =>
      VehicleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    name: json["name"] ?? "",
    carno: json["car_no"] ?? "",
    modelno: json["model_no"] ?? "",
    color: json["color"] ?? "",
    description: json["description"] ?? "",
    id: json["id"].toString(),
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "car_no": carno,
    "model_no": modelno,
    "color": color,
    "description": description,
    "id": id,
    "image": image,
  };
}
