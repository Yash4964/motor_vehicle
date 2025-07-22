import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/api_call/register.dart';
import 'package:motor_vehicle/ui/customer/home/home_page.dart';
import 'package:motor_vehicle/ui/login_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../utils/app_enum.dart';

class RegistrationPage extends StatelessWidget {

  Register register = Get.put(Register());

   RegistrationPage({super.key});
   final _formkey = GlobalKey<FormState>();
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Customer Details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20),

              labels("Name"),
              TextFieldWidget(
                controller: register.cname,
                hint: 'Name',
                textInputType: TextInputType.name,
              ),

              labels("Email"),
              TextFieldWidget(
                controller: register.email,
                hint:  'ex: jon.smith@gmail.com',
                textInputType: TextInputType.emailAddress,
                inputTypeMode: InputTypeMode.email,
              ),



              labels("Password"),
              TextFieldWidget(
                controller:register.pass,
                hint: "password",
                obscureText: true,
                inputTypeMode: InputTypeMode.normal,
              ),

              labels("Mobile"),
              TextFieldWidget(
                controller: register.mobile,
                hint:"91+ 9698521475",
                textInputType: TextInputType.phone,
                inputTypeMode: InputTypeMode.phone,
              ),

              labels("Age"),
              TextFieldWidget(
                controller: register.age,
                hint: "Age must be 18+",
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.age,
              ),

              labels("Address"),
              TextFieldWidget(
                controller: register.address,
                hint: "Address",
                textInputType: TextInputType.text,
              ),

              labels("Pincode"),
              TextFieldWidget(
                controller: register.pincode,
                hint:"Pincode",
                obscureText: false,
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.pincode,
              ),
              const SizedBox(height: 20),
                InkWell(
                  onTap: ()
                  {

                      register.postapi();
                      register.clr();
                      Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:  Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
   Widget labels(String txt) {
     return Padding(
       padding: const EdgeInsets.only(top: 12, bottom: 6, left: 5),
       child: Text(txt, style: const TextStyle(fontSize: 16)),
     );
   }
}
