// report_controller.dart

import 'package:get/get.dart';
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/model/report_model.dart';

class ReportController extends GetxController {
  final ApiService apiService = ApiService();
  RxBool reportloader = false.obs;
  RxList<ReportModel> reportlist = <ReportModel>[].obs;
  RxString dateFilter = ''.obs;

  /// Normalize to dd-MM-yyyy (pad zeros)
  String _normalize(String inputDate) {
    final parts = inputDate.split('-');
    if (parts.length == 3) {
      final d = parts[0].padLeft(2, '0');
      final m = parts[1].padLeft(2, '0');
      final y = parts[2];
      return "$d-$m-$y";
    }
    return inputDate;
  }
  Future<void> fetchByDate(String ddMMyyyy) async {
    final normalized = _normalize(ddMMyyyy);
    dateFilter.value = normalized;
    reportloader.value = true;
    try {
      final payload = {'date_filter': normalized};
      print("🚀 fetchByDate payload: $payload");
      final response = await apiService.reportpost(payload);
      print("📥 status: ${response.statusCode}, body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body as Map<String, dynamic>;
        if (body["status"] == true && body["data"] != null) {
          final dynamic rawData = body["data"];
          if (rawData is List) {
            // list of reports
            if (rawData.isEmpty) {
              Get.snackbar("Info", "No records found for $normalized");
              reportlist.clear();
            } else {
              reportlist.value = rawData
                  .map((json) => ReportModel.fromJson(json as Map<String, dynamic>))
                  .toList();
            }
          } else if (rawData is Map<String, dynamic>) {
            // single report object
            reportlist.value = [ReportModel.fromJson(rawData)];
          } else {
            Get.snackbar("Error", "Unexpected data format");
            reportlist.clear();
          }
        } else {
          Get.snackbar("Error", body["message"] ?? "No data for $normalized");
          reportlist.clear();
        }
      } else {
        Get.snackbar("Error", "Failed to fetch. Code: ${response.statusCode}");
        reportlist.clear();
      }
    } catch (e) {
      Get.snackbar("Error", "Exception: $e");
      reportlist.clear();
    } finally {
      reportloader.value = false;
    }
  }

  List<Booking> allBookings() {
    return reportlist.expand((r) => r.bookings).toList();
  }

  int totalCustomers() {
    final ids = allBookings().map((b) => b.customer.id).toSet();
    return ids.length;
  }

  double totalPayment() {
    double sum = 0;
    for (var b in allBookings()) {
      sum += double.tryParse(b.package.price) ?? 0.0;
    }
    return sum;
  }
}
