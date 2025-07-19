import 'dart:convert';

class PaymentModel {
  String bookingid;
  String amount;
  String date;
  String id;

  PaymentModel({
    required this.bookingid,
    required this.amount,
    required this.date,
    required this.id,
  });

  factory PaymentModel.fromRawJson(String str) => PaymentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    bookingid: json["bookingid"],
    amount: json["amount"],
    date: json["date"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "bookingid": bookingid,
    "amount": amount,
    "date": date,
    "id": id,
  };
}
