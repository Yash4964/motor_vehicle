import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:http/http.dart' as http;

class Register extends GetxController
{
    TextEditingController cname = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();
    TextEditingController mobile = TextEditingController();
    TextEditingController age = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController pincode = TextEditingController();

    RxList<CustomerModel> customerlist = <CustomerModel>[].obs;


    Future<void> postapi() async
    {
      final responce = await http.post(Uri.parse('https://motordriving.sathwarainfotech.com/api/register'),
      headers: {'Content-Type': 'application/json'},
        body: jsonEncode
          ({
              "name": cname.text,
              "email": email.text,
              "password": pass.text,
              "mobile_no":mobile.text,
              "age":int.parse(age.text),
              "address": address.text,
              "pincode":pincode.text
            }
          )
      );
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Get.snackbar("confrim", "thankyou");
      }
      else
      {
        Get.snackbar("Error", "Not data Add");
      }

    }
    void clr ()
    {
      cname.clear();
      email.clear();
      pass.clear();
      mobile.clear();
      age.clear();
      address.clear();
      pincode.clear();
    }
}