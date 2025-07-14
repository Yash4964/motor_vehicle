import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/vehicle_model.dart';

class VehicleConrollerApi extends GetxController {

  final TextEditingController name = TextEditingController();
  final TextEditingController carno = TextEditingController();
  final TextEditingController modelno = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController description = TextEditingController();




  @override
  void onInit() {
    super.onInit();
    clr();
    getapi();

  }

  var tolist = <VehicleModel>[].obs;


  Future<void> getapi() async {
    final response = await http.get(
      Uri.parse(
          'https://68724ae676a5723aacd438b0.mockapi.io/motor/vehicle'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<VehicleModel> demo1 = data
          .map((e) => VehicleModel.fromJson(e))
          .toList();
      tolist.value = demo1;
    }
  }


  Future<void> delapi(String id) async {
    final response = await http.delete(
      Uri.parse(
          'https://68724ae676a5723aacd438b0.mockapi.io/motor/vehicle/$id'),
    );
    if (response.statusCode == 200) {
      tolist.removeWhere((item) => item.id == id);
      Get.snackbar('deleted', 'thank you');
      getapi();
    }
  }

  Future<void> postapi(String name,String carno,String modelno, String color,String description) async {
    final response = await http.post(
      Uri.parse('https://68724ae676a5723aacd438b0.mockapi.io/motor/vehicle'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name,"carno":carno,"modelno":modelno,"color":color,"description":description,}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confrim", "thankyou");
    }
  }

  Future<void> editapi(String id,String name,String carno,String modelno, String color,String description) async {
    final response = await http.put(
      Uri.parse('https://68724ae676a5723aacd438b0.mockapi.io/motor/vehicle/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name,"carno":carno,"modelno":modelno,"color":color,"description":description,}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confirm", "thankyou");
    }
  }

  void setData(arguments) {

    name.text = arguments['name'];
    carno.text=arguments['carno'];
    modelno.text = arguments['modelno'];
    color.text=arguments['color'];
    description.text = arguments['description'];




  }
  void clr(){
    name.clear();
    carno.clear();
    modelno.clear();
    color.clear();
    description.clear();

  }
}
