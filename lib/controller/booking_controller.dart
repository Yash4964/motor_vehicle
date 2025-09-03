import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/model/booking_model.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/package_model.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/utils/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/booking_model.dart';

class BookingController extends GetxController {
  ApiService apiService = ApiService();
  final TextEditingController learner_name = TextEditingController();
  final TextEditingController timeSlot = TextEditingController();
  RxBool bookingloaders = false.obs;
  RxList<BookingModel> bookingList = <BookingModel>[].obs;

  Rx<BookingModel>? bookingDetails;

  Rx<CustomerModel>? selectCustomer;

  Rx<PackageModel>? selectpackage;

  RxString joining_date = '12/08/2025'.obs;
  RxBool customerbookingloader = false.obs;
  bool isEdit = false;
  bool isCustomer = false;

  @override
  void onInit() {
    super.onInit();
    bookingget();
    clear();
    getData();
  }

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isCustomer = prefs.getBool('customer')!;
  }

  //get
    Future<void> bookingget() async {
      bookingloaders.value = true;
      final response = await apiService.bookingget();
      if (response.status.isOk) {
        final data = response.body;
        if (data["status"] == true && data["data"] != null) {
          final List<dynamic> responseData = data["data"];
          bookingList.value = responseData
              .map((json) => BookingModel.  fromJson(json))
              .toList();
        }
      }
      bookingloaders.value = false;
    }

  Future<void> addBooking() async {
    bookingloaders.value = true;
    Response response = await apiService.addBooking(_getData());
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Success", "Booking added successfully");
      await bookingget();
      clear();
      Get.back();
    } else {
      Get.snackbar("Error", "Not data Add");
    }
    bookingloaders.value = false;
  }

  Future<void> updateBooking() async {
    Response cusresponse = await apiService.updateBooking(
      bookingId,
      _getData(),
    );
    if (cusresponse.statusCode == 200 || cusresponse.statusCode == 201) {
      await bookingget();
      Get.snackbar("Success", "Booking updated successfully");

      int index = bookingList.indexWhere(
        (booking) => booking.id.toString() == bookingId,
      );

      bookingList[index] = BookingModel.fromJson(
        cusresponse.body['data'] as Map<String, dynamic>,
      );
      Get.snackbar("Success", "booking update successfully");
    } else {
      Get.snackbar("Error", "Not data Add");
    }
  }

  Future<void> deleteBooking(String id) async {
    final cusresponse = await apiService.deleteBooking(id);
    if (cusresponse.statusCode == 200) {
      bookingList.removeWhere((booking) => booking.id.toString() == id);
      Get.snackbar("Success", "Item deleted successfully");
    } else {
      Get.snackbar("Error", "Not data fatch");
    }
  }

  Future<void> bookingDetailsget(String bookingId) async {
    customerbookingloader.value = true;
    final response = await apiService.bookingDetailsApi(bookingId);
    if (response.status.isOk) {
      final data = response.body['data'];
      if (bookingDetails == null) {
        bookingDetails = Rx<BookingModel>(BookingModel.fromJson(data));
      } else {
        bookingDetails?.value = BookingModel.fromJson(data);
      }
    }
    customerbookingloader.value = false;
  }

  String bookingId = "";

  void setData() {
    bookingId = Get.arguments?['booking_id'] ?? "";
    BookingModel? bookingModel = bookingList.firstWhereOrNull(
      (booking) => booking.id.toString() == bookingId,
    );

    if (bookingModel != null) {
      learner_name.text = bookingModel.learnerName;
      selectCustomer?.value = bookingModel.customer;
      selectpackage?.value = bookingModel.package;
      joining_date.value = AppUtils.getStringDateFromDatTime(
        bookingModel.joiningDate,
      );
      timeSlot.text = bookingModel.timeSlot;
    }
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

  void clear() {
    learner_name.clear();
    selectCustomer = null;
    selectpackage = null;
    final today = DateTime.now();
    joining_date.value = "${today.year}-${today.month}-${today.day}";
  }

  BookingModel get bookingModel => bookingDetails!.value;
}
