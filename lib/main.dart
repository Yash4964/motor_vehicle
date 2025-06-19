import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/registration_page.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motor Vehicle ',
      home: Scaffold(
        body: Center(
          child: ElevatedButton(onPressed: (){
            Get.to( RegistrationPage ());
          }, child:const Text('Registration_page')),

        ),
      ),
    );
  }
}
