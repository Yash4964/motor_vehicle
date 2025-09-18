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

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
    totalAttendances: json["total_attendances"] ?? 0,
    totalPaid: json["total_paid"] ?? 0,
    packagePrice: json["packagePrice"].toString(),
    remainingBalance: json["remaining_balance"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "total_attendances": totalAttendances,
    "total_paid": totalPaid,
    "package_price": packagePrice,
    "remaining_balance": remainingBalance,
  };
}
