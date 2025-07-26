import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';

import '../model/vehicle_model.dart';

class VehicleController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController carno = TextEditingController();
  final TextEditingController modelno = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController description = TextEditingController();
  RxBool loader = false.obs;
  RxList<VehicleModel> vehicleList = <VehicleModel>[].obs;
  ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    clr();
    getVehicle();
  }


  void getVehicle() async {
    loader.value = true;
    final response = await apiService.vehicleget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        vehicleList.value = responseData
            .map((json) => VehicleModel.fromJson(json))
            .toList();
      }
    }
    loader.value = false;
  }

  Future<void> postVehicle() async
  {
    Response response = await apiService.vehicleadd(_getData());
    if(response.statusCode==200 || response.statusCode==201)
    {
      Get.snackbar("Success", "Customer added successfully");
      getVehicle();
      clr();
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }
//update
  Future<void> updatevehicleapi (String id) async
  {
    Response cusresponse = await apiService.vehicleupdate(id, _getData());
    if(cusresponse.statusCode==200 || cusresponse.statusCode==201)
    {
      clr();
      int index = vehicleList.indexWhere((vehicle) => vehicle.id == id);
      vehicleList[index] = VehicleModel.fromJson(cusresponse.body['data'] as Map<String, dynamic>);
      vehicleList.refresh();
      Get.snackbar("Success", "vehicle update successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }

  //delete
  Future<void> deletevehicleapi (String id) async
  {
    final cusresponse = await apiService.vehicledelete(id);
    if(cusresponse.statusCode==200)
    {
      vehicleList.removeWhere((item)=> item.id == id);
      Get.snackbar("Success", "Item deleted successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data fatch");
    }
  }

  void setData(arguments) {
    name.text = arguments['name'];
    carno.text = arguments['carno'];
    modelno.text = arguments['modelno'];
    color.text = arguments['color'];
    description.text = arguments['description'];
  }

  void clr() {
    name.clear();
    carno.clear();
    modelno.clear();
    color.clear();
    description.clear();
  }

  Map<String,dynamic> _getData ()
  {
    return
      {
        "name": name.text,
        "car_no": carno.text,
        "color": modelno.text,
        "model_no":color.text,
        "description": description.text,
      };
  }
}
