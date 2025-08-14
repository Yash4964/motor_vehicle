import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/controller/camera_contoller.dart';
import 'package:motor_vehicle/model/customer_model.dart';

class CustomerController extends GetxController {
  RxList<CustomerModel> customerlist = <CustomerModel>[].obs;
  GetStorage getStorage = GetStorage();
  ApiService apiService = ApiService();
  CameraContoller imageController = Get.put(CameraContoller());

  // text fields
  TextEditingController cname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  RxBool loader = false.obs;

  // store existing image in edit mode
  RxString existingImageUrl = ''.obs;

  @override
  void onInit() {
    clr();
    super.onInit();
  }

  void getCustomerList() async {
    loader.value = true;
    final response = await apiService.customerget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        customerlist.value =
            responseData.map((json) => CustomerModel.fromJson(json)).toList();
      }
    }
    loader.value = false;
  }

  // add
  Future<void> postcustomerapi() async {
    loader.value = true;
    File? profile;
    if (imageController.returnimage.value != null) {
      profile = File(imageController.returnimage.value?.path ?? "");
    }

    try {
      Response response = await apiService.customeradd(_getData(), profile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        getCustomerList();
        clr();
      } else {
        Get.snackbar("Error", "Not data Add");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loader.value = false;
    }
  }



  // update
  Future<void> updatecustomerapi(String id) async {
    loader.value = true;
    File? profile;

    if (imageController.returnimage.value != null) {
      profile = File(imageController.returnimage.value!.path);
    }

    try {
      Response response =
      await apiService.customerupdate(id, _getData(), profile);
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar("Success", "Customer updated successfully");
        getCustomerList();
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to update customer");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loader.value = false;
    }
  }

  // delete
  Future<void> deletecustomerapi(String id) async {
    final cusresponse = await apiService.customerdelete(id);
    if (cusresponse.statusCode == 200) {
      customerlist.removeWhere((item) => item.id == id);
      Get.snackbar("Success", "Item deleted successfully");
    } else {
      Get.snackbar("Error", "Not data fetch");
    }
  }

  // set data for edit mode
  void setData(arguments) {
    cname.text = arguments['name'] ?? '';
    email.text = arguments['email'] ?? '';
    pass.text = arguments['password'] ?? '';
    mobile.text = arguments['mobileno'] ?? '';
    age.text = arguments['age'] ?? '';
    address.text = arguments['address'] ?? '';
    pincode.text = arguments['pincode'] ?? '';
    existingImageUrl.value = arguments['image'] ?? '';
  }

  // clear data
  void clr() {
    cname.clear();
    email.clear();
    pass.clear();
    mobile.clear();
    age.clear();
    address.clear();
    pincode.clear();
    existingImageUrl.value = '';
    imageController.returnimage.value = null;
  }

  Map<String, String> _getData() {
    return {
      "name": cname.text,
      "email": email.text,
      "password": pass.text,
      "mobile_no": mobile.text,
      "age": age.text,
      "address": address.text,
      "pincode": pincode.text,
    };
  }
}
