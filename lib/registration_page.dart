import 'package:flutter/material.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Registration Page'),
        actions: [
          Image.asset('assets/images/logo.jpg', height: 80, width: 160),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 60),
        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black,width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 56),
                  width: double.infinity,
                  child: Text(
                    'Create your account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Name', style: TextStyle(fontSize: 15)),
                        ),
                        TextFieldWidget(
                          hint: 'ex: jon smith',
                          textInputType: TextInputType.name,
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Email', style: TextStyle(fontSize: 15)),
                        ),
                        TextFieldWidget(
                          hint: 'ex: jon.smith@gmail.com',
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Password', style: TextStyle(fontSize: 15)),
                        ),
                        TextFieldWidget(
                          hint: 'Password',
                          textInputType: TextInputType.visiblePassword,
                        ),

                        SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                              padding: EdgeInsets.symmetric(vertical: 15),
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
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,

                              ),

                            ),

                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: Text.rich(
                            TextSpan(text: 'Have an account? ',children: [
                              TextSpan(
                                 text: "SIGN IN",
                                  style: TextStyle(color: Colors.green),
                              ),
                            ],)
                          ),
                        )
                      ],
                    ),
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
