import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/customer/home/home_page.dart';
import 'package:motor_vehicle/ui/login_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Registration '),
        automaticallyImplyLeading: true,
        actions: [
          Image.asset('assets/images/logo.png', height: 40, width: 80),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                //width: double.infinity,
                child: Text(
                  'Create your account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Name', style: TextStyle(fontSize: 18)),
                    ),
                    TextFieldWidget(
                      hint: 'ex: jon smith',
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Email', style: TextStyle(fontSize: 18)),
                    ),
                    TextFieldWidget(
                      hint: 'ex: jon.smith@gmail.com',
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Password', style: TextStyle(fontSize: 18)),
                    ),
                    TextFieldWidget(
                      hint: 'Password',
                      textInputType: TextInputType.visiblePassword,
                    ),

                    SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Confirm Password',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    TextFieldWidget(
                      hint: 'Confirm Password',
                      textInputType: TextInputType.visiblePassword,
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
                          "Submit",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Get.to(LoginPage());
                        },
                        child: Text("Have an account? SIGN IN"),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
