import 'package:motor_vehicle/model/attendence_model.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/package_model.dart';
import 'package:motor_vehicle/model/payment_model.dart';
import 'package:motor_vehicle/model/summary.dart';

class BookingModel {
  int id;
  int customerId;
  String learnerName;
  int packageId;
  DateTime joiningDate;
  String timeSlot;

  List<AttendanceModel>? attendances;
  List<PaymentModel>? transactions;

  CustomerModel customer;
  PackageModel package;
  SummaryModel? summary;

  BookingModel({
    required this.id,
    required this.customerId,
    required this.learnerName,
    required this.packageId,
    required this.joiningDate,
    required this.timeSlot,

    required this.attendances,
    required this.transactions,
    required this.customer,
    required this.package,
    required this.summary,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json["id"],
    customerId: json["customer_id"],
    learnerName: json["learner_name"],
    packageId: json["package_id"],
    joiningDate: DateTime.parse(json["joining_date"]),
    timeSlot: json["time_slot"],

    attendances: (json["attendances"] == null) ? [] : List<AttendanceModel>.from(json["attendances"].map((x) => AttendanceModel.fromJson(x))) ?? null,
    transactions: (json["transactions"] == null) ? [] : List<PaymentModel>.from(json["transactions"].map((x) => PaymentModel.fromJson(x))) ?? null,
    customer: CustomerModel.fromJson(json["customer"]),
    package: PackageModel.fromJson(json["package"]),
    summary: json["summary"] == null ? null: SummaryModel.fromJson(json["summary"]),
  );
}
