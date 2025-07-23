import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/model/customer_model.dart';

import '../ui/admin/customer/customerlist_page.dart';
class CustomerApiController extends GetxController
{
  RxList<CustomerModel> customerlist =<CustomerModel>[].obs;

  TextEditingController cname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  RxBool loader = false.obs;
  @override
     void onInit()
    {
      super.onInit();
      clr();
      getcustomerapi();

    }
  Future<void> getcustomerapi () async
  {
    loader.value = true;
      final cusresponse = await http.get(Uri.parse('https://motordriving.sathwarainfotech.com/api/customers'));
      if(cusresponse.statusCode==200)
        {
          List data = jsonDecode(cusresponse.body);
          List<CustomerModel> cusdata =[];
          for ( var i in data)
            {
              cusdata.add(CustomerModel.fromJson(i));
            }
          customerlist.value=cusdata;

        }
      else
        {
          Get.snackbar("Error", "Not data fatch");
        }
    loader.value = false;
  }

  // add

  Future<void> postcustomerapi () async
  {
    final cusresponse = await http.post(Uri.parse('https://6870ea047ca4d06b34b89eaf.mockapi.io/motordriving/customer'),
        headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          _getData()),
        );
    if(cusresponse.statusCode==200 || cusresponse.statusCode==201)
    {
      clr();
      Get.snackbar("Success", "Customer added successfully");
      getcustomerapi();
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }
  //update
  Future<void> updatecustomerapi (String id ) async
  {
    final cusresponse = await http.put(Uri.parse('https://motordriving.sathwarainfotech.com/api/customers/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        _getData()),
      );
    if(cusresponse.statusCode==200 || cusresponse.statusCode==201)
    {
      clr();
      Get.snackbar("Success", "Customer added successfully");

      getcustomerapi();
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }

  //delete
  Future<void> deletecustomerapi (String id) async
  {
    final cusresponse = await http.delete(Uri.parse('https://motordriving.sathwarainfotech.com/api/customers//$id'));
    if(cusresponse.statusCode==200)
    {
      customerlist.removeWhere((item)=> item.id == id);
      Get.snackbar("Success", "Item deleted successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data fatch");
    }
  }

  void setData(arguments) {
    cname.text =  arguments['name'];
    email.text = arguments['email'];
    pass.text = arguments['password'];
    mobile.text = arguments['mobileno'];
    age.text = arguments['age'];
    address.text = arguments['address'];
    pincode.text = arguments['pincode'];
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
  Map<String,dynamic> _getData ()
  {
    return
      {
        "name": cname.text,
        "email": email.text,
        "password": pass.text,
        "mobile_no":mobile.text,
        "age":int.parse(age.text),
        "address": address.text,
        "pincode":pincode.text
      };
  }
}