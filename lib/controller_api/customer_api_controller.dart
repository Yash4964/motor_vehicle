import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/response_model.dart';

import '../ui/admin/customer/customerlist_page.dart';
class CustomerApiController extends GetxController
{
  RxList<CustomerModel> customerlist =<CustomerModel>[].obs;

  GetStorage getStorage = GetStorage();
  ApiService apiService = ApiService();

  // String url = 'https://motordriving.sathwarainfotech.com/api/customers';
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
      clr();
      super.onInit();

    }

  void getCustomer() async {
    loader.value = true;
    final response = await apiService.customerget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        customerlist.value = responseData
            .map((json) => CustomerModel.fromJson(json))
            .toList();
      }
    }
    loader.value = false;
  }

  // add

  Future<void> postcustomerapi () async
  {

    Response response = await apiService.customeradd(_getData());

    if(response.statusCode==200 || response.statusCode==201)
    {
      Get.snackbar("Success", "Customer added successfully");
      getCustomer();
      clr();
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }
  //update
  Future<void> updatecustomerapi (String id) async
  {
    Response cusresponse = await apiService.customerupdate(id, _getData());
    if(cusresponse.statusCode==200 || cusresponse.statusCode==201)
    {
      clr();

      int index = customerlist.indexWhere((customer) => customer.id == id);
      customerlist[index] = CustomerModel.fromJson(cusresponse.body['data'] as Map<String, dynamic>);
      customerlist.refresh();

      Get.snackbar("Success", "Customer added successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }

  //delete
  Future<void> deletecustomerapi (String id) async
  {
    final cusresponse = await apiService.customerdelete(id);
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