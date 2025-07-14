import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

import '../../../controller_api/driver_api_controller.dart';

// ignore: must_be_immutable
class AddDriverPage extends StatelessWidget {
  AddDriverPage({super.key});

  var args=Get.arguments;
  final DriverConrollerApi d = Get.put(DriverConrollerApi());

  @override
  Widget build(BuildContext context) {
    if(args?['isEdit']??false)
    {
      d.setData(Get.arguments);
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
              controller: d.name,
              hint: 'Name',
              textInputType: TextInputType.name,
            ),

            labels("Email"),
            TextFieldWidget(
              controller: d.email,
              hint: 'ex: jon.smith@gmail.com',
              textInputType: TextInputType.emailAddress,
            ),

            labels("Password"),
            TextFieldWidget(
              controller: d.password,
              hint: "Password",
              obscureText: true,
              textInputType: TextInputType.text,
            ),

            labels("Mobile"),
            TextFieldWidget(
              controller: d.mobileno,
              hint: '91+ 9698521475',
              textInputType: TextInputType.phone,
            ),

            labels("Age"),
            TextFieldWidget(
              controller: d.age,
              hint: "Age must be 18+",
              textInputType: TextInputType.number,
            ),

            labels("Address"),
            TextFieldWidget(
              controller: d.address,
              hint: "Address",
              textInputType: TextInputType.text,
            ),


            labels("Licenceno"),
            TextFieldWidget(
              controller: d.licenceno,
              hint: 'AD24DD3344',
              textInputType: TextInputType.text
              ,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.back();
                if((args?["isEdit"] ?? false) == false)
                {
                  d.postapi(d.name.text, d.email.text, d.password.text, d.mobileno.text, d.age.text, d.address.text, d.licenceno.text);
                }
                else
                {
                  d.editapi(args['id'],d.name.text, d.email.text, d.password.text, d.mobileno.text, d.age.text, d.address.text, d.licenceno.text);
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
    );
  }

  Widget labels(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style: const TextStyle(fontSize: 16)),
    );
  }
}
