import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/package_model.dart';

import '../model/booking_model.dart';

class BookingApiController extends GetxController {
  final TextEditingController lernerName = TextEditingController();
  final TextEditingController joinigDate = TextEditingController();
  final TextEditingController timeSlot = TextEditingController();
  final TextEditingController bookingDate = TextEditingController();
  RxBool loader = false.obs;
  RxList<BookingModel> bookingList = <BookingModel>[].obs;
  Rx<CustomerModel>? selectCustomer ;
  Rx<PackageModel>? selectpackage ;
  @override
  void onInit() {
    super.onInit();
    clr();
    fetchBookings();
  }


  Future<void> fetchBookings() async {
    loader.value = true;
    final response = await http.get(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/booking'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      bookingList.value = data.map((e) => BookingModel.fromJson(e)).toList();
    }
    loader.value = false;
  }


  Future<void> addBooking() async {
    final response = await http.post(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/booking'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_getData()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      fetchBookings();
      Get.snackbar("Success", "Booking created successfully");
    }
  }

  Future<void> updateBooking(String id) async {
    final response = await http.put(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/booking/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_getData()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      fetchBookings();
      Get.snackbar("Success", "Booking updated successfully");
    }
  }


  Future<void> deleteBooking(String id) async {
    final response = await http.delete(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/booking/$id'),
    );
    if (response.statusCode == 200) {
      bookingList.removeWhere((element) => element.id == id);
      Get.snackbar("Deleted", "Booking removed");
      fetchBookings();
    }
  }

  void setData(arguments) {
    lernerName.text = arguments['lerner_name'];
    joinigDate.text = arguments['joinig_date'];
    timeSlot.text = arguments['time_slot'];
    bookingDate.text = arguments['booking_date'];
  }

  Map<String,dynamic> _getData ()
  {
    return
        {
          "customer_id": selectCustomer?.value.id ?? "",
          "lerner_name": lernerName.text,
          "package_id": selectpackage?.value.id ?? "",
          "joinig_date": joinigDate.text,
          "time_slot": timeSlot.text,
          "booking_date": bookingDate.text,
        };
  }
  void clr() {
    lernerName.clear();
    joinigDate.clear();
    timeSlot.clear();
    bookingDate.clear();
    selectCustomer = null;
    selectpackage = null;
  }
}
