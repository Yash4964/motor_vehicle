import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/controller_api/booking_api_controller.dart';
import 'package:motor_vehicle/controller_api/driver_api_controller.dart';
import 'package:motor_vehicle/model/driver_model.dart';
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

    ApiService apiService = ApiService();
  var tolist = <AttendanceModel>[].obs;
  RxBool loader = false.obs;

  @override
  void onInit() {
    super.onInit();
    clr();
  }

  Future<void> attendanceget() async {
    loader.value = true;
    final response = await apiService.attendanceget();
    debugPrint("API Raw Response: ${response.body}");
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

  Future<void> attendanceadd() async
  {
    loader.value = true;
    Response response = await apiService.attendanceadd(_getData());
    if(response.statusCode==200 || response.statusCode==201)
    {
      Get.snackbar("Success", "attendance added successfully");
       attendanceget();
      clr();
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
    loader.value = false;
  }


  Future<void> attendanceupdate (String id) async
  {
    Response cusresponse = await apiService.attendanceupdate(id, _getData());
    if(cusresponse.statusCode==200 || cusresponse.statusCode==201)
    {
      clr();
      int index = tolist.indexWhere((attedance) => attedance.id == id);
      tolist[index] = AttendanceModel.fromJson(cusresponse.body['data'] as Map<String, dynamic>);
      tolist.refresh();
      Get.snackbar("Success", "attendance update successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
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

  void clr(){
    c.datepick.value = '12/08/2025';
    c.timeselected.value = '6:30 AM';
    selectedbooking = null;
    selecteddriver = null;
    final today = DateTime.now();

    c.datepick.value = "${today.year}-${today.month}-${today.day}";


  }
  Map<String, dynamic> _getData() {
    return {
      "booking_id": selectedbooking?.value.id?.toString() ?? "0",
      "driver_id": selecteddriver?.value.id?.toString() ?? "0",
      "date": c.datepick.value.toString(),
      "time": c.timeselected.value.toString(),
    };
  }
  void setData(Map<String, dynamic> arguments) {
    final DropdownController c = Get.find<DropdownController>();

    c.timeselected.value = arguments["Time"]?.toString() ?? c.timeselected.value;
    c.datepick.value = arguments["date"]?.toString() ?? c.datepick.value;
  }
}
