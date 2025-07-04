import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:motor_vehicle/main.dart';
import 'package:motor_vehicle/ui/admin/home/dashboard_page.dart';
import 'package:motor_vehicle/ui/customer/home/home_page.dart';
import 'package:motor_vehicle/ui/registration_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String Cusemail = 'customer@gmail.com';
  final String Cuspass = 'customer';

  final String Adminemail = 'admin@gmail.com';
  final String Adminpass = 'admin';

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
                    controller: emailController,
                    hint: "ex: jon.smith@gmail.com",
                    textInputType: TextInputType.emailAddress,
                  ),
              
                  SizedBox(height: 24),
                  Text("Password", style: TextStyle(fontSize: 18)),
                 SizedBox(height: 8),
                  TextFieldWidget(
                    controller:passwordController,
                    hint: "**********",
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar(
                            "Missing Fields",
                            "Please enter both email and password",
                            colorText: Colors.white,
                            backgroundColor: Colors.lightGreen,
                          );
                          return;
                        }

                        if (email == Cusemail && password == Cuspass)
                        {
                          Get.off(CustomerHomePage(), arguments: 'customer');
                        }
                        else if (email == Adminemail && password == Adminpass)
                        {
                          Get.off(Dashboard_page(), arguments: 'admin');
                        }
                        else {
                          Get.snackbar(
                            "Login Failed",
                            "Invalid email or password",
                            colorText: Colors.white,
                            backgroundColor: Colors.lightGreen,
                          );
                        }
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
