import 'dart:convert';

class BookingModel {
  String customerId;
  String lernerName;
  String packageId;
  String joinigDate;
  String timeSlot;
  String bookingDate;
  String id;

  BookingModel({
    required this.customerId,
    required this.lernerName,
    required this.packageId,
    required this.joinigDate,
    required this.timeSlot,
    required this.bookingDate,
    required this.id,
  });

  factory BookingModel.fromRawJson(String str) => BookingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    customerId: json["customer_id"],
    lernerName: json["lerner_name"],
    packageId: json["package_id"],
    joinigDate: json["joinig_date"],
    timeSlot: json["time_slot"],
    bookingDate: json["booking_date"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "lerner_name": lernerName,
    "package_id": packageId,
    "joinig_date": joinigDate,
    "time_slot": timeSlot,
    "booking_date": bookingDate,
    "id": id,
  };
}
