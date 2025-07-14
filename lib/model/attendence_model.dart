import 'dart:convert';

class AttendanceModel {
  String bookingid;
  String date;
  String time;
  String id;

  AttendanceModel({
    required this.bookingid,
    required this.date,
    required this.time,
    required this.id,
  });

  factory AttendanceModel.fromRawJson(String str) => AttendanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    bookingid: json["Bookingid"],
    date: json["Date"],
    time: json["Time"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "Bookingid": bookingid,
    "Date": date,
    "Time": time,
    "id": id,
  };
}
