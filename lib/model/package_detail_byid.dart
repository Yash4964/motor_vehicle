import 'package:motor_vehicle/model/package_model.dart';

class PackageDetailsModel {
  final String id;
  final String name;
  final String carNo;
  final String modelNo;
  final String color;
  final String description;
  final String image;
  final List<PackageModel> packages;

  PackageDetailsModel({
    required this.id,
    required this.name,
    required this.carNo,
    required this.modelNo,
    required this.color,
    required this.description,
    required this.image,
    required this.packages,
  });

  factory PackageDetailsModel.fromJson(Map<String, dynamic> json) {
    return PackageDetailsModel(
      id: json["id"].toString(),
      name: json["name"] ?? '',
      carNo: json["car_no"] ?? '',
      modelNo: json["model_no"] ?? '',
      color: json["color"] ?? '',
      description: json["description"] ?? '',
      image: json["image"] ?? '',
      packages: (json["packages"] as List<dynamic>?)
          ?.map((e) => PackageModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "car_no": carNo,
      "model_no": modelNo,
      "color": color,
      "description": description,
      "image": image,
      "packages": packages.map((e) => e.toJson()).toList(),
    };
  }
}
