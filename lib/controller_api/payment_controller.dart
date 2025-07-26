import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';

import 'package:motor_vehicle/model/booking_model.dart';
import 'package:motor_vehicle/model/payment_model.dart';

class PaymentController extends GetxController {
  final TextEditingController amount = TextEditingController();
  ApiService apiService = ApiService();
  GetStorage getStorage = GetStorage();
  RxBool loader = false.obs;
  RxString datevalue = '12/08/2025'.obs;

  @override
  void onInit() {
    super.onInit();
    getapi();
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

  Future<void> postapi() async
  {
    loader.value = true;
    Response response = await apiService.paymentadd(_getData());
    if(response.statusCode==200 || response.statusCode==201)
    {
      Get.snackbar("Success", "driver added successfully");
      getapi();
      clr();
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
    loader.value = false;
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



  void clr() {
    amount.clear();
    selectedbook = null;
    final today = DateTime.now();
    datevalue.value = "${today.year}-${today.month}-${today.day}";
  }
  // add
  Map<String, dynamic> _getData() {
    return {
      "booking_id": selectedbook?.value.id ?? "",
      "amount": amount.text,
      "date":datevalue.value,
    };
  }

  void setData(Map<String, dynamic> arguments) {
    amount.text = arguments["amount"];
    datevalue.value =
        arguments["date"] ?? datevalue.value;
  }
}
