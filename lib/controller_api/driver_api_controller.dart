import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http ;
import '../model/driver_model.dart';

class DriverConrollerApi extends GetxController {

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController mobileno = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController licenceno = TextEditingController();



  @override
  void onInit() {
    super.onInit();
    clr();
    getapi();

  }
  var driverlist = <DriverModel>[].obs;

  Future<void> getapi() async {
    final response = await http.get(
      Uri.parse(
          'https://6870ea047ca4d06b34b89eaf.mockapi.io/motordriving/driver'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<DriverModel> demo1 = data
          .map((e) => DriverModel.fromJson(e))
          .toList();
      driverlist.value = demo1;
    }
  }


  Future<void> delapi(String id) async {
    final response = await http.delete(
      Uri.parse(
          'https://6870ea047ca4d06b34b89eaf.mockapi.io/motordriving/driver/$id'),
    );
    if (response.statusCode == 200) {
      driverlist.removeWhere((item) => item.id == id);
      Get.snackbar('deleted', 'thank you');
      getapi();
    }
  }

  Future<void> postapi(String name,String email,String password,String mobileno,String age,String address,String licenceno) async {
    final response = await http.post(
      Uri.parse('https://6870ea047ca4d06b34b89eaf.mockapi.io/motordriving/driver'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name,"email":email,"password":password,"mobileno":int.parse(mobileno),"age":int.parse(age),"licenceno":licenceno ,"address":address,}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      clr();
      Get.snackbar("confrim", "thankyou");
    }
  }

  Future<void> editapi(String id,String name,String email,String password,String mobileno,String age,String address,String licenceno) async {
    final response = await http.put(
      Uri.parse('https://6870ea047ca4d06b34b89eaf.mockapi.io/motordriving/driver/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name,"email":email,"password":password,"mobileno":int.parse(mobileno),"age":int.parse(age),"licenceno":licenceno ,"address":address,}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confrim", "thankyou");
    }
  }

  void setData(arguments) {

    name.text = arguments['name'];
    email.text=arguments['email'];
    password.text = arguments['password'];
    mobileno.text=arguments['mobileno'];
    age.text = arguments['age'];
    address.text=arguments['address'];
    licenceno.text = arguments['licenceno'];


  }
  void clr(){
    name.clear();
    email.clear();
    password.clear();
    mobileno.clear();
    age.clear();
    address.clear();
    licenceno.clear();
}
}
