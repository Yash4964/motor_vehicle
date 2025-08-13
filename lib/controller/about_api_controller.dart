import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ApiService.dart';
import 'package:motor_vehicle/model/about_model.dart';
import 'package:motor_vehicle/model/admin_model.dart';

class AboutApiController extends GetxController {
  Rx<AboutUsModel>? aboutModel;
  final RxBool loader = false.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    if(aboutModel == null){
      aboutget();
    }
  }

  void aboutget() async {
    loader.value = true;
    final response = await apiService.getAboutus();
    if (response.status.isOk) {
      final data = response.body;
      if (data["status"] == true && data["data"] != null) {
        Map<String,dynamic> responseData = data["data"];
        if(aboutModel == null){
          aboutModel = Rx(AboutUsModel.fromJson(responseData));
        }else{
          aboutModel?.value = AboutUsModel.fromJson(responseData);
        }
      }
    }
    loader.value = false;
  }


}
