import 'dart:convert';

import 'package:motor_vehicle/model/booking_model.dart';
import 'package:motor_vehicle/model/driver_model.dart';
import 'package:motor_vehicle/model/report_model.dart';

class AttendanceModel {
  String booking_id;
  String date;
  String time;
  String driver_id;
  String id;
  String? image;
  BookingModel? bookingModel;
  DriverModel? driverModel;

  AttendanceModel({
    required this.booking_id,
    required this.date,
    required this.time,
    required this.driver_id,
    required this.id,
    this.image,
    required this.bookingModel,
    required this.driverModel,
  });

  factory AttendanceModel.fromRawJson(String str) =>
      AttendanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        booking_id: json["booking_id"].toString(),
        driver_id: json["driver_id"]?.toString() ?? "",
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        id: json["id"].toString(),
        image: json["image"],
        bookingModel: (json["booking"] == null)
            ? null
            : BookingModel.fromJson(json["booking"]),
        driverModel: (json["driver"] == null)
            ? null
            : DriverModel.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
    "booking_id": booking_id,
    "driver_id": driver_id,
    "date": date,
    "time": time,
    "id": id,
    "image": image,
  };
}
