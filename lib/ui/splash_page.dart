import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/main.dart';
import 'package:motor_vehicle/ui/login_page.dart';

class SplashPage extends StatefulWidget {
   SplashPage({Key? key}) : super(key: key); // Constructor properly defined

  @override
  State<SplashPage> createState() => _SplashPageState(); // Link to state
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer( Duration(seconds: 2), () {
      Get.off(() => LoginPage()); // Ensure Homepage exists
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
}
