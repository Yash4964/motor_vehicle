import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http ;
import 'package:motor_vehicle/ApiService.dart';
import '../model/driver_model.dart';

class DriverConrollerApi extends GetxController {

  RxBool loader = false.obs;
  ApiService apiService = ApiService();

  TextEditingController cname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController licenceno = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    clr();

  }
  var driverlist = <DriverModel>[].obs;
//get
  void getDriver() async {
    loader.value = true;
    final response = await apiService.driverget();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        final List<dynamic> responseData = data["data"];
        driverlist.value = responseData
            .map((json) => DriverModel.fromJson(json))
            .toList();
      }
    }
    loader.value = false;
  }
//add
  Future<void> postDriverapi () async
  {
    Response response = await apiService.driveradd(_getData());
    if(response.statusCode==200 || response.statusCode==201)
    {
      Get.snackbar("Success", "driver added successfully");
      getDriver();
      clr();
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }
//update
  Future<void> updatedriverapi (String id) async
  {
    Response cusresponse = await apiService.driverupdate(id, _getData());
    if(cusresponse.statusCode==200 || cusresponse.statusCode==201)
    {
      clr();
      int index = driverlist.indexWhere((driver) => driver.id == id);
      driverlist[index] = DriverModel.fromJson(cusresponse.body['data'] as Map<String, dynamic>);
      driverlist.refresh();
      Get.snackbar("Success", "driver update successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data Add");
    }
  }

  //delete
  Future<void> deletedriverapi (String id) async
  {
    final cusresponse = await apiService.driverdelete(id);
    if(cusresponse.statusCode==200)
    {
      driverlist.removeWhere((item)=> item.id == id);
      Get.snackbar("Success", "Item deleted successfully");
    }
    else
    {
      Get.snackbar("Error", "Not data fatch");
    }
  }

  void setData(arguments) {

    cname.text = arguments['name'];
    email.text=arguments['email'];
    pass.text = arguments['password'];
    mobile.text=arguments['mobileno'];
    age.text = arguments['age'];
    address.text=arguments['address'];
    licenceno.text = arguments['licenceno'];


  }
  void clr(){
    cname.clear();
    email.clear();
    pass.clear();
    mobile.clear();
    age.clear();
    address.clear();
    licenceno.clear();
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
        "licence_no":licenceno.text,
      };
  }
}
