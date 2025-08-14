import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/controller/camera_contoller.dart';

import '../model/vehicle_model.dart';

class VehicleController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController carno = TextEditingController();
  final TextEditingController modelno = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController description = TextEditingController();

  CameraContoller imageController = Get.put(CameraContoller());

  RxBool loader = false.obs;
  RxList<VehicleModel> vehicleList = <VehicleModel>[].obs;
  ApiService apiService = ApiService();

  // NEW: store existing image in edit mode
  RxString existingImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    clr();
  }

  void getVehicle() async {
    loader.value = true;
    final response = await apiService.vehicleget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        vehicleList.value =
            responseData.map((json) => VehicleModel.fromJson(json)).toList();
      }
    }
    loader.value = false;
  }

  Future<void> postVehicle() async {
    loader.value = true;
    File? profile;
    if (imageController.returnimage.value != null) {
      profile = File(imageController.returnimage.value!.path);
    }

    try {
      Response response = await apiService.vehicleadd(_getData(), profile);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        getVehicle();
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

  Future<void> updatevehicleapi(String id) async {
    loader.value = true;
    File? profile;

    if (imageController.returnimage.value != null) {
      profile = File(imageController.returnimage.value!.path);
    }

    try {
      Response response =
      await apiService.vehicleupdate(id, _getData(), profile);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Vehicle updated successfully");
        getVehicle();
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to update vehicle");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loader.value = false;
    }
  }

  Future<void> deletevehicleapi(String id) async {
    final cusresponse = await apiService.vehicledelete(id);
    if (cusresponse.statusCode == 200) {
      vehicleList.removeWhere((item) => item.id == id);
      Get.snackbar("Success", "Item deleted successfully");
    } else {
      Get.snackbar("Error", "Not data fetch");
    }
  }

  void setData(arguments) {
    name.text = arguments['name'];
    carno.text = arguments['carno'];
    modelno.text = arguments['modelno'];
    color.text = arguments['color'];
    description.text = arguments['description'];
    existingImageUrl.value = arguments['image'] ?? ''; // store old image
  }

  void clr() {
    name.clear();
    carno.clear();
    modelno.clear();
    color.clear();
    description.clear();
    existingImageUrl.value = '';
    imageController.returnimage.value = null;
  }

  Map<String, String> _getData() {
    return {
      "name": name.text,
      "car_no": carno.text,
      "model_no": modelno.text,
      "color": color.text,
      "description": description.text,
    };
  }
}

