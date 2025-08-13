import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/customer_api_controller.dart';
import 'package:motor_vehicle/utils/app_enum.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class AddcustomerPage extends StatelessWidget {
  AddcustomerPage({super.key});

  var args = Get.arguments;
  final _formkey = GlobalKey<FormState>();

  CustomerController customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    if (args?['isEdit'] ?? false) {
      customerController.setData(Get.arguments);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Customer Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image Picker
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue, width: 2.5),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Obx(
                              () => Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage: customerController
                                    .imageController.returnimage.value !=
                                    null
                                    ? FileImage(File(customerController
                                    .imageController
                                    .returnimage
                                    .value!
                                    .path))
                                    : const AssetImage('assets/images/default_person.png')
                                as ImageProvider,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    customerController.imageController.pickImageOption(context);
                                  },
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
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Customer Details',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 20),

                    labels("Name"),
                    TextFieldWidget(
                      controller: customerController.cname,
                      hint: 'Name',
                      textInputType: TextInputType.name,
                    ),

                    labels("Email"),
                    TextFieldWidget(
                      controller: customerController.email,
                      hint: 'ex: jon.smith@gmail.com',
                      textInputType: TextInputType.emailAddress,
                      inputTypeMode: InputTypeMode.email,
                    ),

                    labels("Password"),
                    TextFieldWidget(
                      controller: customerController.pass,
                      hint: "password",
                      obscureText: true,
                      inputTypeMode: InputTypeMode.password,
                    ),

                    labels("Mobile"),
                    TextFieldWidget(
                      controller: customerController.mobile,
                      hint: "91+ 9698521475",
                      textInputType: TextInputType.phone,
                      inputTypeMode: InputTypeMode.phone,
                    ),

                    labels("Age"),
                    TextFieldWidget(
                      controller: customerController.age,
                      hint: "Age must be 18+",
                      textInputType: TextInputType.number,
                      inputTypeMode: InputTypeMode.age,
                    ),

                    labels("Address"),
                    TextFieldWidget(
                      controller: customerController.address,
                      hint: "Address",
                      textInputType: TextInputType.text,
                    ),

                    labels("Pincode"),
                    TextFieldWidget(
                      controller: customerController.pincode,
                      hint: "Pincode",
                      textInputType: TextInputType.number,
                      inputTypeMode: InputTypeMode.pincode,
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          if ((args?['isEdit'] ?? false) == false) {
                            customerController.postcustomerapi();

                          } else {
                            customerController.updatecustomerapi(args['id']);
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

            // Loader Overlay (same as Vehicle)
            if (customerController.loader.value)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),

          ],
        );
      }),
    );
  }

  Widget labels(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style: const TextStyle(fontSize: 16)),
    );
  }
}
