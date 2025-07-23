import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http ;
import 'package:motor_vehicle/model/admin_model.dart';
import 'package:motor_vehicle/model/customer_model.dart';

class LoginApiController extends GetxController {

  TextEditingController eemail = TextEditingController();
  TextEditingController pass = TextEditingController();

  RxList<AdminModel> customerlist = <AdminModel>[].obs;

  Future<void> postapi() async {
    final response = await http.post(
      Uri.parse('https://motordriving.sathwarainfotech.com/api/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": eemail.text,
        "password":pass.text}),
    );
    Get.snackbar("confrim", response.statusCode.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("confrim", "thankyou");
    }
  }

}

