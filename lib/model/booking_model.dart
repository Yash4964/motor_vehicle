import 'dart:convert';

class BookingModel {
  String customer_id;
  String learner_name;
  String package_id;
  String joining_date;
  String time_slot;
  String id;

  BookingModel({
    required this.customer_id,
    required this.learner_name,
    required this.package_id,
    required this.joining_date,
    required this.time_slot,
    required this.id,
  });

  factory BookingModel.fromRawJson(String str) => BookingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    customer_id: json["customer_id"].toString() ?? "",
    learner_name: json["learner_name"] ?? "",
    package_id: json["package_id"].toString() ?? "",
    joining_date: json["joining_date"] ?? "",
    time_slot: json["time_slot"] ?? "",
    id: json["id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customer_id,
    "learner_name": learner_name,
    "package_id": package_id,
    "joining_date": joining_date,
    "time_slot": time_slot,
    "id": id,
  };
}
