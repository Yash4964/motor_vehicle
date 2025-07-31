import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/controller_api/vehicle_api_controller.dart';
import 'package:motor_vehicle/model/licence_model.dart';
import 'package:motor_vehicle/model/package_detail_byid.dart';
import 'package:motor_vehicle/model/vehicle_model.dart';
import '../model/package_model.dart';
class LicenceControllerApi extends GetxController {
  // final TextEditingController name = TextEditingController();
  // final TextEditingController days = TextEditingController();
  // final TextEditingController km = TextEditingController();
  // final TextEditingController price = TextEditingController();

  // Rx<VehicleModel>? selectedVehicle;

  RxList<LicencesModel> Licencelist = <LicencesModel>[].obs;
  ApiService apiService = ApiService();
  RxBool loader = false.obs;
  GetStorage getStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    clr();
  }

//get
  Future<void> licenceget() async {
    loader.value = true;
    final response = await apiService.licenceget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        Licencelist.value = responseData
            .map((json) => LicencesModel.fromJson(json))
            .toList();
      }
    }
    loader.value = false;
  }

  void clr() {
    // name.clear();
    // selectedVehicle = null;
    // days.clear();
    // km.clear();
    // price.clear();
  }
}