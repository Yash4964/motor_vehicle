import 'dart:convert';

class AttendanceModel {
  String booking_id;
  String date;
  String time;
  //String driverid;
  String id;

  AttendanceModel({
    required this.booking_id,
    required this.date,
    required this.time,
    //required this.driverid,
    required this.id,
  });

  factory AttendanceModel.fromRawJson(String str) => AttendanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    booking_id: json["booking_id"].toString(),
    date: json["date"] ?? "",
    time: json["time"] ?? "",
    id: json["id"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "booking_id": booking_id,
    "date": date,
    "time": time,
    //"Driverid": driverid,
    "id": id,
  };
}
