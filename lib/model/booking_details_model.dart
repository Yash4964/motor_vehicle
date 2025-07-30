import 'package:motor_vehicle/model/attendence_model.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/package_model.dart';
import 'package:motor_vehicle/model/payment_model.dart';

class BookingDetailModel {
  int id;
  int customerId;
  String learnerName;
  int packageId;
  DateTime joiningDate;
  String timeSlot;
  List<AttendanceModel> attendances;
  List<dynamic> transactions;

  CustomerModel customer;
  PackageModel package;
  //SummaryModel summary;

  BookingDetailModel({
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
    //required this.summary,
  });

  factory BookingDetailModel.fromJson(Map<String, dynamic> json) => BookingDetailModel(
    id: json["id"],
    customerId: json["customer_id"],
    learnerName: json["learner_name"],
    packageId: json["package_id"],
    joiningDate: DateTime.parse(json["joining_date"]),
    timeSlot: json["time_slot"],
    attendances: List<AttendanceModel>.from(json["attendances"].map((x) => AttendanceModel.fromJson(x))),
    transactions: List<PaymentModel>.from(json["transactions"]),
    customer: CustomerModel.fromJson(json["customer"]),
    package: PackageModel.fromJson(json["package"]),
    //summary: SummaryModel.fromJson(json["summary"]),
  );
}
