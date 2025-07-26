import 'dart:convert';

class PaymentModel {
  String booking_id;
  String amount;
  String date;
  String id;

  PaymentModel({
    required this.booking_id,
    required this.amount,
    required this.date,
    required this.id,
  });

  factory PaymentModel.fromRawJson(String str) => PaymentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    booking_id: json["booking_id"].toString() ?? "",
    amount: json["amount"] ?? "",
    date: json["date"].toString() ?? "",
    id: json["id"].toString()?? "",
  );

  Map<String, dynamic> toJson() => {
    "booking_id": booking_id,
    "amount": amount,
    "date": date,
    "id": id,
  };
}
