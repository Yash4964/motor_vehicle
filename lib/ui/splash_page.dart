import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/main.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key}) {
    Timer( Duration(seconds: 1), () {
      Get.off(Homepage());
    });
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset("assets/images/logo.png", width: 200,height: 200,),
      ),
    );
  }
}
