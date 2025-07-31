import 'dart:convert';

class SummaryModel {
  int totalAttendances;
  int totalPaid;
  String packagePrice;
  int remainingBalance;

  SummaryModel({
    required this.totalAttendances,
    required this.totalPaid,
    required this.packagePrice,
    required this.remainingBalance,
  });

  factory SummaryModel.fromRawJson(String str) => SummaryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
    totalAttendances: json["total_attendances"],
    totalPaid: json["total_paid"],
    packagePrice: json["package_price"],
    remainingBalance: json["remaining_balance"],
  );

  Map<String, dynamic> toJson() => {
    "total_attendances": totalAttendances,
    "total_paid": totalPaid,
    "package_price": packagePrice,
    "remaining_balance": remainingBalance,
  };
}
