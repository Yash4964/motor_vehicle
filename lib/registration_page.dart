import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';
import 'package:motor_vehicle/login_page.dart'; // Ensure this file exists and is correct

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Registration Page'),
        actions: [
          Image.asset('assets/images/logo.png', height: 80, width: 160),
          const SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 56, vertical: 20),
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Create your account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Name', style: TextStyle(fontSize: 15)),
                      ),
                      TextFieldWidget(
                        hint: 'ex: Jon Smith',
                        textInputType: TextInputType.name,
                      ),
                      SizedBox(height: 8),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Email', style: TextStyle(fontSize: 15)),
                      ),
                      TextFieldWidget(
                        hint: 'ex: jon.smith@gmail.com',
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 8),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Password', style: TextStyle(fontSize: 15)),
                      ),
                      TextFieldWidget(
                        hint: 'Password',
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 8),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      TextFieldWidget(
                        hint: 'Confirm Password',
                        textInputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: const Color.fromARGB(
                              255,
                              65,
                              33,
                              243,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Have an account? ',
                            children: [
                              TextSpan(
                                text: 'SIGN IN',
                                style: const TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => login());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
