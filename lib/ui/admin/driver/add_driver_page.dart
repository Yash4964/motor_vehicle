import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/utils/app_enum.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../../../controller/driver_api_controller.dart';

class AddDriverPage extends StatelessWidget {
  AddDriverPage({super.key});

  var args=Get.arguments;
  final DriverConrollerApi driverConrollerApi = Get.put(DriverConrollerApi());
  final _formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if(args?['isEdit']??false)
    {
      driverConrollerApi.setData(Get.arguments);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Driver Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 2.5,
                    ),
                  ),padding: EdgeInsets.all(2),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/default_person.png",),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.lightBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add, color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  args?[0] ?? 'Driver Details',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),

              labels("Name"),
              TextFieldWidget(
                controller: driverConrollerApi.cname,
                hint: 'Name',
                textInputType: TextInputType.name,
                inputTypeMode: InputTypeMode.normal,
              ),

              labels("Email"),
              TextFieldWidget(
                controller: driverConrollerApi.email,
                hint: 'ex: jon.smith@gmail.com',
                textInputType: TextInputType.emailAddress,
                inputTypeMode: InputTypeMode.email,
              ),

              labels("Password"),
              TextFieldWidget(
                controller: driverConrollerApi.pass,
                hint: "Password",
                obscureText: true,
                textInputType: TextInputType.text,
                inputTypeMode: InputTypeMode.password,
              ),

              labels("Mobile"),
              TextFieldWidget(
                controller: driverConrollerApi.mobile,
                hint: '91+ 9698521475',
                textInputType: TextInputType.phone,
                inputTypeMode: InputTypeMode.phone,
              ),

              labels("Age"),
              TextFieldWidget(
                controller: driverConrollerApi.age,
                hint: "Age must be 18+",
                textInputType: TextInputType.number,
                inputTypeMode: InputTypeMode.age,
              ),

              labels("Address"),
              TextFieldWidget(
                controller: driverConrollerApi.address,
                hint: "Address",
                textInputType: TextInputType.text,

              ),


              labels("Licenceno"),
              TextFieldWidget(
                controller: driverConrollerApi.licenceno,
                hint: 'GJ 2433447832453',
                textInputType: TextInputType.text,
                inputTypeMode: InputTypeMode.licenceno,

              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (_formkey.currentState!.validate()) {


                    if ((args?["isEdit"] ?? false) == false) {
                      driverConrollerApi.postDriverapi();
                      Get.back();

                    } else {
                      driverConrollerApi.updatedriverapi(args["id"]);
                      Get.back();

                    }

                  }
                },


                child: Container(
                  width: double.infinity,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
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
