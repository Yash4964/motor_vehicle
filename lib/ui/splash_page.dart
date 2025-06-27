import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/main.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key}) {
    Timer( Duration(seconds: 1), () {
      Get.off(Homepage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset("assets/images/logo.png", width: 200,height: 200,),
      ),
    );
  }
}
