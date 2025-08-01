// report_model.dart

import 'dart:convert';

class ReportModel {
  final List<Booking> bookings;
  final Summary summary;

  ReportModel({
    required this.bookings,
    required this.summary,
  });

  factory ReportModel.fromRawJson(String str) =>
      ReportModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
    bookings: (json["bookings"] as List<dynamic>)
        .map((x) => Booking.fromJson(x as Map<String, dynamic>))
        .toList(),
    summary: Summary.fromJson(json["summary"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "bookings": bookings.map((x) => x.toJson()).toList(),
    "summary": summary.toJson(),
  };

  /// convenience: bookings whose joining date is before today
  List<Booking> get pastJoiningDateBookings =>
      bookings.where((b) => b.hasJoiningDatePassed).toList();
}

class Booking {
  final int id;
  final int customerId;
  final String learnerName;
  final int packageId;
  final DateTime joiningDate;
  final String timeSlot;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final Customer customer;
  final Package package;

  Booking({
    required this.id,
    required this.customerId,
    required this.learnerName,
    required this.packageId,
    required this.joiningDate,
    required this.timeSlot,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.customer,
    required this.package,
  });

  factory Booking.fromRawJson(String str) =>
      Booking.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  /// true if the joining date is strictly before today (date-only comparison)
  bool get hasJoiningDatePassed {
    final now = DateTime.now();
    final jd = DateTime(joiningDate.year, joiningDate.month, joiningDate.day);
    final today = DateTime(now.year, now.month, now.day);
    return jd.isBefore(today);
  }

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"] as int,
    customerId: json["customer_id"] as int,
    learnerName: json["learner_name"] as String,
    packageId: json["package_id"] as int,
    joiningDate: DateTime.parse(json["joining_date"] as String),
    timeSlot: json["time_slot"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
    deletedAt: json["deleted_at"],
    customer: Customer.fromJson(json["customer"] as Map<String, dynamic>),
    package: Package.fromJson(json["package"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "learner_name": learnerName,
    "package_id": packageId,
    "joining_date": joiningDate.toIso8601String(),
    "time_slot": timeSlot,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "customer": customer.toJson(),
    "package": package.toJson(),
  };
}

class Customer {
  final int id;
  final String name;
  final String email;
  final String mobileNo;
  final int age;
  final String address;
  final String pincode;
  final dynamic image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.age,
    required this.address,
    required this.pincode,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] as int,
    name: json["name"] as String,
    email: json["email"] as String,
    mobileNo: json["mobile_no"] as String,
    age: json["age"] as int,
    address: json["address"] as String,
    pincode: json["pincode"] as String,
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
    "age": age,
    "address": address,
    "pincode": pincode,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Package {
  final int id;
  final String name;
  final int vehicleId;
  final int days;
  final int km;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final dynamic vehicle; // keep dynamic/null for now, replace with concrete model if available

  Package({
    required this.id,
    required this.name,
    required this.vehicleId,
    required this.days,
    required this.km,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.vehicle,
  });

  factory Package.fromRawJson(String str) =>
      Package.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"] as int,
    name: json["name"] as String,
    vehicleId: json["vehicle_id"] as int,
    days: json["days"] as int,
    km: json["km"] as int,
    price: json["price"] as String,
    createdAt: DateTime.parse(json["created_at"] as String),
    updatedAt: DateTime.parse(json["updated_at"] as String),
    deletedAt: json["deleted_at"],
    vehicle: json["vehicle"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "vehicle_id": vehicleId,
    "days": days,
    "km": km,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "vehicle": vehicle,
  };
}

class Summary {
  final int totalBookings;
  final int totalAttendances;
  final int totalPackagePrice;
  final String totalPaid;
  final int remainingBalance;

  Summary({
    required this.totalBookings,
    required this.totalAttendances,
    required this.totalPackagePrice,
    required this.totalPaid,
    required this.remainingBalance,
  });

  factory Summary.fromRawJson(String str) =>
      Summary.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalBookings: (json["total_bookings"] ?? 0) as int,
    totalAttendances: (json["total_attendances"] ?? 0) as int,
    totalPackagePrice: (json["total_package_price"] ?? 0) as int,
    totalPaid: json["total_paid"]?.toString() ?? "0.00",
    remainingBalance: (json["remaining_balance"] ?? 0) as int,
  );

  Map<String, dynamic> toJson() => {
    "total_bookings": totalBookings,
    "total_attendances": totalAttendances,
    "total_package_price": totalPackagePrice,
    "total_paid": totalPaid,
    "remaining_balance": remainingBalance,
  };
}
