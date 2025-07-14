import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/package_model.dart';

class PackageConrollerApi extends GetxController {

  final TextEditingController name = TextEditingController();
  final TextEditingController vehicleid = TextEditingController();
  final TextEditingController days = TextEditingController();
  final TextEditingController km = TextEditingController();
  final TextEditingController price = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    clr();
    getapi();

  }

  var tolist = <PackageModel>[].obs;


  Future<void> getapi() async {
    final response = await http.get(
      Uri.parse(
          'https://68724ae676a5723aacd438b0.mockapi.io/motor/package'),
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
          'https://68724ae676a5723aacd438b0.mockapi.io/motor/package/$id'),
    );
    if (response.statusCode == 200) {
      tolist.removeWhere((item) => item.id == id);
      Get.snackbar('deleted', 'thank you');
      getapi();
    }
  }

  Future<void> postapi(String name,String vehicleid,String days, String km,String price) async {
    final response = await http.post(
      Uri.parse('https://68724ae676a5723aacd438b0.mockapi.io/motor/package'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name,"vehicleid":vehicleid,"days":int.parse(days),"km":int.parse(km),"price":int.parse(price),}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confrim", "thankyou");
    }
  }

  Future<void> editapi(String id,String name,String vehicleid,String days, String km,String price) async {
    final response = await http.put(
      Uri.parse('https://68724ae676a5723aacd438b0.mockapi.io/motor/package/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name,"vehicleid":vehicleid,"days":int.parse(days),"km":int.parse(km),"price":int.parse(price),}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confirm", "thankyou");
    }
  }

  void setData(arguments) {

    name.text = arguments['name'];
    vehicleid.text=arguments['vehicleid'];
    days.text = arguments['days'];
    km.text=arguments['km'];
    price.text = arguments['price'];
  }
  void clr(){
    name.clear();
    vehicleid.clear();
    days.clear();
    km.clear();
    price.clear();

  }
}
