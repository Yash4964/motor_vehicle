import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/model/customer_model.dart';
import 'package:motor_vehicle/model/response_model.dart';

class Register extends GetxController {


  GetStorage getStorage = GetStorage();
  TextEditingController cname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  RxList<CustomerModel> customerlist = <CustomerModel>[].obs;

  ApiService apiService = Get.put(ApiService());
  Future<void> postapi() async
  {

    Response responce = await apiService.signUp(_getData());

    if (responce.statusCode == 200 || responce.statusCode == 201) {
      ResponseModel responseModel = ResponseModel.fromJson(responce.body);
      getStorage.write('token',  responseModel.data['token_type'] + " " + responseModel.data['token']);
      getStorage.write("user_mode", responseModel.data['user_type']);
      getStorage.write("user", CustomerModel.fromJson(responseModel.data['user']).toJson().toString());
      Get.snackbar("confrim", "thankyou");
    }
    else {
      Get.snackbar("Error", "Not data Add");
    }
  }

  void clr() {
    cname.clear();
    email.clear();
    pass.clear();
    mobile.clear();
    age.clear();
    address.clear();
    pincode.clear();
  }

  Map<String, dynamic> _getData() {
    return
        {
          "name": cname.text,
          "email": email.text,
          "password": pass.text,
          "mobile_no": mobile.text,
          "age": int.parse(age.text),
          "address": address.text,
          "pincode": pincode.text
        };
}
}