import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/attendence_model.dart';

class attendenceConrollerApi extends GetxController {

  final TextEditingController bookingid = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    clr();
    getapi();

  }

  var tolist = <AttendanceModel>[].obs;


  Future<void> getapi() async {
    final response = await http.get(
      Uri.parse(
          'https://68735d60c75558e27353fea7.mockapi.io/motor/Attendence'),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<AttendanceModel> demo1 = data
          .map((e) => AttendanceModel.fromJson(e))
          .toList();
      tolist.value = demo1;
    }
  }


  Future<void> delapi(String id) async {
    final response = await http.delete(
      Uri.parse(
          'https://68735d60c75558e27353fea7.mockapi.io/motor/Attendence/$id'),
    );
    if (response.statusCode == 200) {
      tolist.removeWhere((item) => item.id == id);
      Get.snackbar('deleted', 'thank you');
      getapi();
    }
  }
  //
  Future<void> postapi(String bookingid,String date,String time) async {
    final response = await http.post(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/Attendence'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
         {
           "Bookingid": bookingid,
           "Date": date,
           "Time": time,
         }
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confrim", "thankyou");
    }
  }

  Future<void> editapi(String id,String bookingid,String date,String time) async {
    final response = await http.put(
      Uri.parse('https://68735d60c75558e27353fea7.mockapi.io/motor/Attendence/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Bookingid": bookingid,
        "Date": date,
        "Time": time,}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getapi();
      Get.snackbar("confirm", "thankyou");
    }
  }

  void setData(arguments) {
    bookingid.text = arguments['bookingid'];
    date.text=arguments['date'];
    time.text = arguments['time'];





  }
  void clr(){
    bookingid.clear();
    date.clear();
    time.clear();


   }
}
