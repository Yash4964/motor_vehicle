import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/controller/report_api_controller.dart';

import 'package:motor_vehicle/model/booking_model.dart';
import 'package:motor_vehicle/model/payment_model.dart';

import 'booking_controller.dart';

class PaymentController extends GetxController {
  final TextEditingController amount = TextEditingController();
  ApiService apiService = ApiService();
  GetStorage getStorage = GetStorage();
  ReportController reportController =Get.put(ReportController());
  RxBool loader = false.obs;
  RxBool isLoading = false.obs;
  RxString datevalue = '12/08/2025'.obs;

  String bookingId = "";

  @override
  void onInit() {
    super.onInit();
    final today = DateTime.now();
    datevalue.value = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    clr();
  }

  RxList<PaymentModel> paymentList = <PaymentModel>[].obs;
  Rx<BookingModel>? selectedbook;






  Future<void> getapi() async {

    loader.value = true;

    final response = await apiService.paymentget();
    if (response.statusCode == 200) {
      final data = response.body;
      final List<dynamic> responseData = data["data"];
      paymentList.value = responseData
          .map((e) => PaymentModel.fromJson(e))
          .toList();
    }

    loader.value = false;
  }

  Future<void> delapi(String id) async {
    final response = await apiService.paymentdelete(id);
    if (response.statusCode == 200) {
      paymentList.removeWhere((item) => item.id == id);
      Get.snackbar('deleted', 'thank you');
      getapi();
    }
  }
  //
  // Future<void> postapi() async {
  //   try {
  //     loader.value = true;
  //
  //     Response response = await apiService.paymentadd(_getData());
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //
  //       if (bookingId.isNotEmpty) {
  //         BookingController bookingController = Get.find<BookingController>();
  //         await bookingController.bookingDetailsget(bookingId);
  //       }
  //
  //       Get.back();
  //       Get.snackbar("Success", "Payment added successfully");
  //
  //       clr(); // clear fields
  //     } else {
  //       Get.snackbar("Error", "Data not added");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     loader.value = false;
  //   }
  // }


  Future<void> postapi() async {
    try {
      loader.value = true;

      // ✅ Check booking price limit with remaining balance
      if (bookingId.isNotEmpty) {
        BookingController bookingController = Get.find<BookingController>();
        final booking = bookingController.bookingList.firstWhereOrNull(
              (b) => b.id.toString() == bookingId,
        );

        if (booking != null) {
          final enteredAmount = double.tryParse(amount.text) ?? 0;
          final packagePrice =
              double.tryParse(booking.package.price.toString()) ?? 0;

          final alreadyPaid = booking.transactions?.fold<double>(
            0.0,
                (sum, p) => sum + (double.tryParse(p.amount) ?? 0),
          ) ?? 0.0;

          final remainingBalance = packagePrice - alreadyPaid;
          if (enteredAmount > remainingBalance) {
            Get.snackbar("Error",
                "Amount cannot exceed remaining balance ₹$remainingBalance");
            loader.value = false;
            return;

          }
        }
      }

      Response response = await apiService.paymentadd(_getData());

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (bookingId.isNotEmpty) {
          BookingController bookingController = Get.find<BookingController>();
          await bookingController.bookingDetailsget(bookingId);
        }

        Get.back();
        Get.snackbar("Success", "Payment added successfully");
        clr(); // clear fields
      } else {
        Get.snackbar("Error", "Data not added");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loader.value = false;
    }
  }

  Future<void> editapi(String id) async {
    final response = await apiService.paymentupdate(id, _getData());
    if (response.statusCode == 200 || response.statusCode == 201) {
      clr();
      int index = paymentList.indexWhere((driver) => driver.id == id);
      paymentList[index] =
          PaymentModel.fromJson(response.body['data'] as Map<String, dynamic>);
      paymentList.refresh();
      Get.snackbar("Success", "payment update successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }



  void clr({bool clearBookingId = true}) {
    amount.clear();
    selectedbook = null;

    if (clearBookingId) {
      bookingId = "";
    }

    final today = DateTime.now();
    datevalue.value = "${today.year}-${today.month}-${today.day}";
  }

  // add
  Map<String, dynamic> _getData() {
    return {
      "booking_id": selectedbook?.value.id ?? bookingId,
      "amount": amount.text,
      "date":datevalue.value,
    };
  }

  void setData(Map<String, dynamic> data) {
    amount.text = data['amount'] ?? '';
    datevalue.value = data['date'] ?? '';

    if (data['booking_id'] != null) {
      final bookingId = data['booking_id'] is String
          ? int.tryParse(data['booking_id']) ?? 0
          : data['booking_id'];

      final matchedBooking = Get.find<BookingController>()
          .bookingList
          .firstWhereOrNull((book) => book.id == bookingId);
      if (matchedBooking != null) {
        selectedbook = Rx<BookingModel>(matchedBooking);
      }
    }
  }

}
