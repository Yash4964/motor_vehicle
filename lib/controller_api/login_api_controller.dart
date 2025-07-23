import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/model/admin_model.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/response_model.dart';
import 'package:motor_vehicle/ui/admin/home/admin_dashboard_page.dart';
import 'package:motor_vehicle/ui/customer/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GetStorage getStorage = GetStorage();
  RxList<AdminModel> customerlist = <AdminModel>[].obs;

  Future<void> postapi() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Missing Fields",
        "Please enter both email and password",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
      );
      return;
    }

    Response response = await ApiService().login({"email": email, "password": password});

    if (response.statusCode == 200 || response.statusCode == 201) {
      ResponseModel responseModel = ResponseModel.fromJson(response.body);

      getStorage.write("token", responseModel.data['token_type'] + " " + responseModel.data['token']);
      getStorage.write("user_mode", responseModel.data['user_type']);
      getStorage.write("user", CustomerModel.fromJson(responseModel.data['user']).toJson().toString());

      if(responseModel.data['user_type'] == "customer"){
        Get.off(CustomerHomePage());
      }else{
        Get.off(Dashboard_page());
      }
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid email or password",
        colorText: Colors.white,
        backgroundColor: Colors.lightGreen,
      );
    }
  }
}
