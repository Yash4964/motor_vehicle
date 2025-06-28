import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

// ignore: must_be_immutable
class AddDriverPage extends StatelessWidget {
  AddDriverPage({super.key});

  var args=Get.arguments;
  @override
  Widget build(BuildContext context) {
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
                      backgroundImage: AssetImage(args?[2] ?? 'assets/images/default_person.png',),
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
              hint: args?[0] ?? 'Name',
              textInputType: TextInputType.name,
            ),

            labels("Email"),
            TextFieldWidget(
              hint: args?[1] ?? 'ex: jon.smith@gmail.com',
              textInputType: TextInputType.emailAddress,
            ),



            labels("Password"),
            TextFieldWidget(
              hint:
              "password",
              obscureText: true,
            ),

            labels("Mobile"),
            TextFieldWidget(
              hint: args?[3] ?? '91+ 9698521475',
              textInputType: TextInputType.phone,
            ),

            labels("Age"),
            TextFieldWidget(
              hint: "Age must be 18+",
              textInputType: TextInputType.number,
            ),

            labels("Address"),
            TextFieldWidget(
              hint: "Address",
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            InkWell(
              onTap: () {

              },
              child: Container(
                width: double.infinity,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Appcolor.primary,
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
