import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/model/vehicle_model.dart';

import '../model/package_model.dart';


class PackageConrollerApi extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController days = TextEditingController();
  final TextEditingController km = TextEditingController();
  final TextEditingController price = TextEditingController();

  Rx<VehicleModel>? selectedVehicle;

  @override
  void onInit() {
    super.onInit();
    clr();
    getapi();
  }

  RxList<PackageModel> tolist = <PackageModel>[].obs;

  Future<void> getapi() async {
    final response = await http.get(
      Uri.parse('https://68724ae676a5723aacd438b0.mockapi.io/motor/package'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<PackageModel> demo1 = data
          .map((e) => PackageModel.fromJson(e))
          .toList();
      tolist.value = demo1;
    }
  }

  Future<void> delapi(String id) async {
    final response = await http.delete(
      Uri.parse(
        'https://68724ae676a5723aacd438b0.mockapi.io/motor/package/$id',
      ),
    );
    if (response.statusCode == 200) {
      tolist.removeWhere((item) => item.id == id);
      Get.snackbar('deleted', 'thank you');
      getapi();
    }
  }

  Future<void> postapi() async {
    final response = await http.post(
      Uri.parse('https://68724ae676a5723aacd438b0.mockapi.io/motor/package'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_getData()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confrim", "thankyou");
    }
  }

  Future<void> editapi() async {
    String id = Get.arguments['id'];
    final response = await http.put(
      Uri.parse(
        'https://68724ae676a5723aacd438b0.mockapi.io/motor/package/$id',
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(_getData()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confirm", "thankyou");
    }
  }

  void setData(arguments) {
    name.text = arguments['name'];
    // selectedVehicle.text = arguments['vehicleid'];
    days.text = arguments['days'];
    km.text = arguments['km'];
    price.text = arguments['price'];
  }

  void clr() {
    name.clear();
    //vehicleid.clear();
    days.clear();
    km.clear();
    price.clear();
  }

  Map<String, dynamic> _getData() {
    return {
      "name": name.text,
      "vehicleid": selectedVehicle?.value.id ?? "",
      "days": int.parse(days.text),
      "km": int.parse(km.text),
      "price": int.parse(price.text),
    };
  }
}
