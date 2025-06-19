import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:motor_vehicle/registration_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Image.asset(
                      'images/logo.jpg',
                      width: 200,
                      height: 100,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Sign in your account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                Text("Email", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                TextFieldWidget(
                  hint: "ex: jon.smith@gmail.com",
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24),
                Text("Password", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                TextFieldWidget(
                  hint: "**********",
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 30),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 65, 33, 243),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(fontSize: 16, color: Colors.black),
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
