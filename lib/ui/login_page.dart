import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:motor_vehicle/controller_api/login_api_controller.dart';
import 'package:motor_vehicle/main.dart';
import 'package:motor_vehicle/ui/admin/home/admin_dashboard_page.dart';
import 'package:motor_vehicle/ui/customer/home/home_page.dart';
import 'package:motor_vehicle/ui/registration_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

import 'customer/home/home_page.dart';
class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  LoginApiController loginApiController = Get.put(LoginApiController());


  // final String Cusemail = 'customer@gmail.com';
  // final String Cuspass = 'customer';
  //
  // final String Adminemail = 'admin@gmail.com';
  // final String Adminpass = 'admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 200,
                        height: 130,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Sign in your account",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                 SizedBox(height: 40),
                  Text("Email", style: TextStyle(fontSize: 18)),
                 SizedBox(height: 8),
                  TextFieldWidget(
                    controller: loginApiController.emailController,
                    hint: "ex: jon.smith@gmail.com",
                    textInputType: TextInputType.emailAddress,
                  ),
              
                  SizedBox(height: 24),
                  Text("Password", style: TextStyle(fontSize: 18)),
                 SizedBox(height: 8),
                  TextFieldWidget(
                    controller:loginApiController.passwordController,
                    hint: "**********",
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 30),
                  // InkWell(
                  //   onTap: (){
                  //     loginApiController.postapi();
                  //   },
                     InkWell(
                       onTap: ()
                       {
                         loginApiController.postapi();
                       },
                       child: Container(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            loginApiController.postapi();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),

                                         ),
                     ),
                  // SizedBox(height: 16),
                  // ElevatedButton(onPressed: () {
                  //     loginApiController.postapi();
                  // }, child: Text(
                  //   "SIGN IN",
                  //   style: TextStyle(fontSize: 16),
                  // ),),
                  SizedBox(height: 8,),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Get.to(RegistrationPage());
                      },
                      child: Text("Don't have an account ? SIGN UP"),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(onPressed: (){
                      Get.to(Homepage());
                    }, child: Text('Pannels')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
