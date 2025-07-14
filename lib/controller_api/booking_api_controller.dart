import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/booking_model.dart';

class BookingApiController extends GetxController {
  final TextEditingController customerId = TextEditingController();
  final TextEditingController lernerName = TextEditingController();
  final TextEditingController packageId = TextEditingController();
  final TextEditingController joinigDate = TextEditingController();
  final TextEditingController timeSlot = TextEditingController();
  final TextEditingController bookingDate = TextEditingController();

  var bookingList = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    clr();
    fetchBookings();
  }


  Future<void> fetchBookings() async {
    final response = await http.get(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/booking'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      bookingList.value = data.map((e) => BookingModel.fromJson(e)).toList();
    }
  }


  Future<void> addBooking(String customerId,String lernerName,String packageId ,String joinigDate , String timeSlot , String bookingDate) async {
    final response = await http.post(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/booking'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "customer_id": customerId,
        "lerner_name": lernerName,
        "package_id": packageId,
        "joinig_date": joinigDate,
        "time_slot": timeSlot,
        "booking_date": bookingDate,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      fetchBookings();
      Get.snackbar("Success", "Booking created successfully");
    }
  }

  /// Update an existing booking
  Future<void> updateBooking(String id,String customerId,String lernerName,String packageId ,String joinigDate , String timeSlot , String bookingDate) async {
    final response = await http.put(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/booking/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "customer_id": customerId,
        "lerner_name": lernerName,
        "package_id": packageId,
        "joinig_date": joinigDate,
        "time_slot": timeSlot,
        "booking_date": bookingDate,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      fetchBookings();
      Get.snackbar("Success", "Booking updated successfully");
    }
  }

  /// Delete a booking
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

  /// Set controller values from arguments (for update screen)
  void setData(arguments) {
    customerId.text = arguments['customer_id'];
    lernerName.text = arguments['lerner_name'];
    packageId.text = arguments['package_id'];
    joinigDate.text = arguments['joinig_date'];
    timeSlot.text = arguments['time_slot'];
    bookingDate.text = arguments['booking_date'];
  }

  /// Clear all controllers
  void clr() {
    customerId.clear();
    lernerName.clear();
    packageId.clear();
    joinigDate.clear();
    timeSlot.clear();
    bookingDate.clear();
  }
}
