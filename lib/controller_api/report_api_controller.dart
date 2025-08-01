// report_controller.dart

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/model/report_model.dart';

class ReportController extends GetxController {
  ApiService apiService = ApiService();
  RxBool reportloader = false.obs;
  Rx<ReportModel>? reportlist;

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final TextEditingController dateController = TextEditingController();
  void onInit() {
    super.onInit();
    final today = DateTime.now();
    selectedDate.value = today;
    final formatted = DateFormat('MM-yyyy').format(today);
    dateController.text = formatted;
    fetchByDate(formatted.toString());
  }
  Future<void> fetchByDate(String selectedDate) async {
    reportloader.value = true;
    try {
      final payload = {'date_filter': selectedDate.toString()};
      print("fetchByDate payload: $payload");
      final response = await apiService.reportpost(payload);
      print(" status: ${response.statusCode}, body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201)
      {
        final body = response.body as Map<String, dynamic>;
        if (body["status"] == true && body["data"] != null)
        {
          final dynamic data = body["data"];
          if(reportlist == null) {
            reportlist = Rx<ReportModel>(ReportModel.fromJson(data));
          }else{
            reportlist?.value = ReportModel.fromJson(data);
          }
        }
        else {
          Get.snackbar("Error", body["message"]);
        }
      }
      else {
        Get.snackbar("Error", "Failed to fetch. Code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Exception: $e");
    } finally {
      reportloader.value = false;
    }
  }



}
