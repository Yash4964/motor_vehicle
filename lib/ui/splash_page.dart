import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/main.dart';
import 'package:motor_vehicle/ui/admin/home/dashboard_page.dart';
import 'package:motor_vehicle/ui/customer/home/booking_page.dart';
import 'package:motor_vehicle/ui/customer/home/home_page.dart';
import 'package:motor_vehicle/ui/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Timer(
    //   Duration(seconds: 5),
    //   () => Get.off(LoginPage()),
    // );
    Timer(
      Duration(seconds: 1),
      () => Get.off(Homepage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Image.asset("assets/images/logo.jpg"))
    );
  }
}
