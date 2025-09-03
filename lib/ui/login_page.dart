import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/login_api_controller.dart';
import 'package:motor_vehicle/ui/registration_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LoginApiController loginApiController = Get.put(LoginApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Stack(
          children: [
            // Main Page
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 200,
                            height: 130,
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Sign in your account",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                          controller: loginApiController.passwordController,
                          hint: "**********",
                          textInputType: TextInputType.text,
                          obscureText: false,
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          height: 45,
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
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
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
            ),


            if (loginApiController.isLoading.value)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3), // dim background
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Appcolor.primary,
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
