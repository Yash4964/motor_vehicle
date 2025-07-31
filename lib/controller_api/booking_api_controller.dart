import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/model/booking_details_model.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/package_model.dart';
import 'package:intl/intl.dart';
import '../model/booking_model.dart';

class BookingApiController extends GetxController {
  ApiService apiService = ApiService();
  final TextEditingController learner_name = TextEditingController();
  final TextEditingController timeSlot = TextEditingController();
  RxBool loader = false.obs;
  RxList<BookingModel> bookingList = <BookingModel>[].obs;

  Rx<BookingDetailModel>? bookingDetails;

  Rx<CustomerModel>? selectCustomer;

  Rx<PackageModel>? selectpackage;

  RxString joining_date = '12/08/2025'.obs;

  @override
  void onInit() {
    super.onInit();
    bookingget();
    clr();
  }

  //get
  Future<void> bookingget() async {
    loader.value = true;
    final response = await apiService.bookingget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        bookingList.value = responseData
            .map((json) => BookingModel.fromJson(json))
            .toList();
      }
    }
    loader.value = false;
  }

  Future<void> bookingadd() async {
    loader.value = true;
    Response response = await apiService.bookingadd(_getData());
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Success", "driver added successfully");
      bookingget();
      clr();
    } else {
      Get.snackbar("Error", "Not data Add");
    }
    loader.value = false;
  }

  Future<void> bookingupdate(String id) async {
    Response cusresponse = await apiService.bookingupdate(id, _getData());
    if (cusresponse.statusCode == 200 || cusresponse.statusCode == 201) {
      clr();
      int index = bookingList.indexWhere((driver) => driver.id == id);
      bookingList[index] = BookingModel.fromJson(
        cusresponse.body['data'] as Map<String, dynamic>,
      );
      bookingList.refresh();
      Get.snackbar("Success", "booking update successfully");
    } else {
      Get.snackbar("Error", "Not data Add");
    }
  }

  Future<void> bookingdelete(String id) async {
    final cusresponse = await apiService.bookingdelete(id);
    if (cusresponse.statusCode == 200) {
      bookingList.removeWhere((item) => item.id == id);
      Get.snackbar("Success", "Item deleted successfully");
    } else {
      Get.snackbar("Error", "Not data fatch");
    }
  }

  Future<void> bookingDetailsget(String bookingId) async {
   // loader.value = true/=;
    final response = await apiService.bookingDetailsApi(bookingId);
    if (response.status.isOk) {
      final data = response.body['data'];
      if(bookingDetails == null) {
        bookingDetails = Rx<BookingDetailModel>(BookingDetailModel.fromJson(data));
      }else{
        bookingDetails?.value = BookingDetailModel.fromJson(data);
      }
    }
    // loader.value = false;
  }

  void setData(arguments) {
    learner_name.text = arguments['learner_name'] ?? "";
    joining_date.value = arguments['joining_date'] ?? "";
    timeSlot.text = arguments['time_slot'] ??  "";
  }

  Map<String, dynamic> _getData() {
    return {
      "customer_id": selectCustomer?.value.id ?? "",
      "learner_name": learner_name.text,
      "package_id": selectpackage?.value.id ?? "",
      "joining_date": joining_date.value,
      "time_slot": timeSlot.text,
    };
  }

  void clr() {
    learner_name.clear();
    selectCustomer = null;
    selectpackage = null;
    final today = DateTime.now();
    joining_date.value = "${today.year}-${today.month}-${today.day}";
  }
}
