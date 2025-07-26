import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/controller_api/vehicle_api_controller.dart';
import 'package:motor_vehicle/model/vehicle_model.dart';
import '../model/package_model.dart';

class PackageConrollerApi extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController days = TextEditingController();
  final TextEditingController km = TextEditingController();
  final TextEditingController price = TextEditingController();

  Rx<VehicleModel>? selectedVehicle;

  RxList<PackageModel> tolist = <PackageModel>[].obs;
  ApiService apiService = ApiService();
  RxBool loader = false.obs;
  GetStorage getStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    clr();

  }
//get
  Future<void> packageget() async {
    loader.value = true;
    final response = await apiService.packageget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        tolist.value = responseData
            .map((json) => PackageModel.fromJson(json))
            .toList();
      }
    }
    loader.value = false;
  }
//del
  Future<void> packagedelete(String id) async {
    final response = await apiService.packagedelete(id);
    if (response.statusCode == 200) {
      tolist.removeWhere((item) => item.id == id);
      Get.snackbar('Deleted', 'Package deleted successfully');
      packageget();
    }
  }

  Future<void> packageadd() async {
    final response = await apiService.packageadd(_getData());
    if (response.statusCode == 200 || response.statusCode == 201) {
      packageget();
      Get.snackbar("Success", "Package added");
    }
  }
//update
//   Future<void> packageupdate(String id) async {
//     String id = Get.arguments['id'];
//     final response = await apiService.packageupdate(id, _getData());
//     if (response.statusCode == 200 || response.statusCode == 201) {
//
//       int index = tolist.indexWhere((i) => i.id == id);
//       tolist[index] = PackageModel.fromJson(response.body['data'] as Map<String, dynamic>);
//       tolist.refresh();
//       clr();
//       Get.snackbar("Success", "Package updated");
//     }
//   }
  Future<void> packageupdates (String id) async
  {
    Response cusresponse = await apiService.packageupdate(id, _getData());
    if(cusresponse.statusCode==200 || cusresponse.statusCode==201)
    {
      clr();
      int index = tolist.indexWhere((package) => package.id == id);
      tolist[index] = PackageModel.fromJson(cusresponse.body['data'] as Map<String, dynamic>);
      tolist.refresh();
      Get.snackbar("Success", "driver update successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }


  void clr() {
    name.clear();
    selectedVehicle = null;
    days.clear();
    km.clear();
    price.clear();
  }

  Map<String, dynamic> _getData() {
    return {
      "name": name.text,
      "vehicle_id": selectedVehicle?.value.id ?? "",
      "days": int.parse(days.text),
      "km": int.parse(km.text),
      "price": price.text,
    };
  }

  void setData(arguments) {
    name.text = arguments['name'] ;
    days.text = arguments['days'].toString() ;
    km.text = arguments['km'].toString();
    price.text = arguments['price'].toString() ;

    String vid = arguments['vehicle_id'].toString();
    final VehicleController vehicleController = Get.find<VehicleController>();
    final matchedVehicle = vehicleController.vehicleList.firstWhereOrNull((v) => v.id == vid);

    if (matchedVehicle != null) {
      selectedVehicle = Rx<VehicleModel>(matchedVehicle);
    }
  }

}
