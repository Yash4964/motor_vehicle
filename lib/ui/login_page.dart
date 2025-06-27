import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:motor_vehicle/ui/customer/home/home_page.dart';
import 'package:motor_vehicle/ui/registration_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
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
                  hint: "ex: jon.smith@gmail.com",
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24),
                Text("Password", style: TextStyle(fontSize: 18)),
               SizedBox(height: 8),
                TextFieldWidget(
                  hint: "**********",
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 30),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to((CustomerHomePage()));
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
                SizedBox(height: 16),

                Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(RegistrationPage());
                    },
                    child: Text("Don't have an account ? SIGN UP"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
