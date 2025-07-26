import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/controller_api/driver_api_controller.dart';
import 'package:motor_vehicle/model/driver_model.dart';
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_customer.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';

import '../model/attendence_model.dart';
import '../model/booking_model.dart';

class AttendenceConrollerApi extends GetxController {

  DropdownController c = Get.put(DropdownController());
  BookingApiController bookingApiController = Get.put(BookingApiController());
  DriverConrollerApi driverConrollerApi = Get.put(DriverConrollerApi());
  Rx<BookingModel>? selectedbooking ;
  Rx<DriverModel>? selecteddriver;
  RxBool loader = false.obs;
  ApiService apiService = ApiService();
  var tolist = <AttendanceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    clr();
    attendanceget();

  }
  Future<void> attendanceget() async {
    loader.value = true;
    final response = await apiService.attendanceget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        tolist.value = responseData
            .map((json) => AttendanceModel.fromJson(json))
            .toList();
      }
    }
    loader.value = false;
  }

  Future<void> attendancedelete (String id) async
  {
    final cusresponse = await apiService.attendancedelete(id);
    if(cusresponse.statusCode==200)
    {
      tolist.removeWhere((item)=> item.id == id);
      Get.snackbar("Success", "Item deleted successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data fatch");
    }
  }


  // Future<void> delapi(String id) async {
  //   final response = await http.delete(
  //     Uri.parse(
  //         'https://68735d60c75558e27353fea7.mockapi.io/motor/Attendence/$id'),
  //   );
  //   if (response.statusCode == 200) {
  //     tolist.removeWhere((item) => item.id == id);
  //     Get.snackbar('deleted', 'thank you');
  //     getapi();
  //   }
  // }
  //
  // Future<void> postapi() async {
  //   final response = await http.post(
  //     Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/Attendence'),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(
  //          _getdata()
  //     ),
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     getapi();
  //     clr();
  //     Get.snackbar("confrim", "thankyou");
  //   }
  // }
  //
  // Future<void> editapi(String id) async {
  //   final response = await http.put(
  //     Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/Attendence/$id'),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(_getdata()),
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     getapi();
  //     Get.snackbar("confirm", "thankyou");
  //     clr();
  //   }
  // }

  void clr(){
    c.datepick.value = '12/08/2025';
    c.timeselected.value = '6:30 AM';
   }

  Map<String,dynamic> _getdata ()
  {
    return
        {
          "bookingid": selectedbooking?.value.id ?? "",
          "date": c.datepick.value,
          "time": c.timeselected.value,
          "Driverid": selecteddriver?.value.id ?? "",
        };
  }
  void setData(Map<String, dynamic> arguments) {
    c.timeselected.value = arguments["Time"];
    c.datepick.value =
        arguments["date"] ?? c.datepick.value;
  }
}
