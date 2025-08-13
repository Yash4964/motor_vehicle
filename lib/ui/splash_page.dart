import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/login_api_controller.dart';
import 'package:motor_vehicle/main.dart';
import 'package:motor_vehicle/ui/admin/home/admin_dashboard_page.dart';
import 'package:motor_vehicle/ui/customer/home/home_page.dart';
import 'package:motor_vehicle/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key); // Constructor properly defined

  @override
  State<SplashPage> createState() => _SplashPageState(); // Link to state
}

class _SplashPageState extends State<SplashPage> {
  LoginApiController loginApiController = Get.put(LoginApiController());
  @override
  void initState() {
    super.initState();
    //loginApiController.clr();
    Timer(Duration(seconds: 2), () {

      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png", width: 200, height: 200),
      ),
    );
  }

  void checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    if (isLogin) {
      bool isCustomer = prefs.getBool('customer') ?? false;

      if (isCustomer) {
        Get.to(() => CustomerHomePage());
      } else {
        Get.to(() => Dashboard_page());
      }
    } else {
      Get.off(() => LoginPage());
    }
  }
}
