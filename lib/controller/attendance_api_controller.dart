  import 'dart:convert';
  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:http/http.dart' as http;
  import 'package:motor_vehicle/ApiService.dart';
  import 'package:motor_vehicle/controller/booking_controller.dart';
  import 'package:motor_vehicle/controller/camera_contoller.dart';
  import 'package:motor_vehicle/controller/driver_api_controller.dart';
  import 'package:motor_vehicle/model/driver_model.dart';
  import 'package:motor_vehicle/ui/admin/attendance/add_attendance_customer.dart';
  import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';

  import '../model/attendence_model.dart';
  import '../model/booking_model.dart';

  class AttendenceConrollerApi extends GetxController {
    DropdownController c = Get.put(DropdownController());
    Rx<BookingModel>? selectedbooking;

    Rx<DriverModel>? selecteddriver;
    CameraContoller imageController = Get.put(CameraContoller());
    var existingImageUrl = ''.obs;


    ApiService apiService = ApiService();
    RxList<AttendanceModel> attendList = <AttendanceModel>[].obs;
    RxBool loader = false.obs;
    bool isEdit = false;
    String bookingId = "";
    String attendanceId = "";


    @override
    void onInit() {
      super.onInit();
      attendanceget();
    }

    Future<void> attendanceget() async {
      loader.value = true;
      final response = await apiService.attendanceget();
      debugPrint("API Raw Response: ${response.body}");
      if (response.status.isOk) {
        final data = response.body;
        if (data["status"] == true && data["data"] != null) {
          final List<dynamic> responseData = data["data"];
          attendList.value = responseData
              .map((json) => AttendanceModel.fromJson(json))
              .toList();
        }
      }
      loader.value = false;
    }

    Future<void> addAttendance() async {
      File? profile;
      if (imageController.returnimage != null &&
          imageController.returnimage.value != null) {
        profile = File(imageController.returnimage.value?.path ?? "");
      }

      Response response = await apiService.attendanceadd(_getData(),profile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "vehicle added successfully");
        attendanceget();
        Get.back();

      } else {
        Get.snackbar("Error", "Not data Add");
      }
    }

    Future<void> updateAttendance(String id) async {
      loader.value = true;
      File? profile;

      // Only attach new image if picked
      if (imageController.returnimage.value != null) {
        profile = File(imageController.returnimage.value!.path);
      }

      try {
        Response response = await apiService.attendanceupdate(id, _getData(), profile);

        if (response.statusCode == 200) {
          Get.snackbar("Success", "Vehicle updated successfully");
          attendanceget(); // refresh vehicle list with new image
          Get.back(); // now go back to list page
        } else {
          Get.snackbar("Error", "Failed to update vehicle");
        }
      } catch (e) {
        Get.snackbar("Error", e.toString());
      } finally {
        loader.value = false;
      }
    }


    Future<void> attendancedelete(String id) async {
      final cusresponse = await apiService.attendancedelete(id);
      if (cusresponse.statusCode == 200) {
        attendList.removeWhere((item) => item.id == id);
        Get.snackbar("Success", "Item deleted successfully");
      } else {
        Get.snackbar("Error", "Not data fatch");
      }
    }

    void clear() {
      c.timeselected.value = c.timelist.first;
      selectedbooking = null;
      selecteddriver = null;
      final today = DateTime.now();
      c.datepick.value = "${today.year}-${today.month}-${today.day}";

      bookingId = Get.arguments?['booking_id'] ?? "";
      attendanceId = Get.arguments?['attendanceId'] ?? "";
      isEdit = attendanceId.isNotEmpty;
      imageController.returnimage.value = null;
    }

    Map<String, String> _getData() {
      return {
        "booking_id": bookingId.isNotEmpty
            ? bookingId
            : selectedbooking?.value.id.toString() ?? "0",
        "driver_id": selecteddriver?.value.id.toString() ?? "0",
        "date": c.datepick.value.toString(),
        "time": c.timeselected.value.toString(),
      };
    }

    void setData() {
      AttendanceModel? attendanceModel = attendList.firstWhereOrNull(
        (attendance) => attendance.id == attendanceId,
      );
      existingImageUrl.value = Get.arguments['image'] ?? '';
      if (attendanceModel != null) {
        selectedbooking?.value = attendanceModel.bookingModel as BookingModel;
      }
    }
  }
